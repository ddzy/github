import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:github/components/custom_empty/custom_empty.dart';
import 'package:github/main.dart';
import 'package:github/models/repository_model/repository_model.dart';
import 'package:github/models/user_list_model/user_list_model.dart';
import 'package:github/models/user_model/user_model.dart';
import 'package:github/utils/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:transparent_image/transparent_image.dart';

part 'gql.dart';

class StarredPage extends StatefulWidget {
  const StarredPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _StarredPageState();
  }
}

class _StarredPageState extends State<StarredPage> {
  @override
  void initState() {
    // 加载更多
    _controller.addListener(() async {
      var position = _controller.position;
      if (position.extentAfter == 0) {
        if (_isFetching) {
          return;
        }
        _isFetching = true;
        _isFirstLoad = false;
        await _fetchMore!(
          FetchMoreOptions(
            updateQuery: (previousResultData, fetchMoreResultData) {
              if (previousResultData == null) {
                return fetchMoreResultData;
              }
              if (fetchMoreResultData == null) {
                return fetchMoreResultData;
              }
              fetchMoreResultData["viewer"]?['starredRepositories']?["nodes"] = [
                ...previousResultData["viewer"]?['starredRepositories']?["nodes"],
                ...fetchMoreResultData["viewer"]?['starredRepositories']?["nodes"],
              ];
              return fetchMoreResultData;
            },
            variables: {
              'after': _paginationCursor,
            },
          ),
        );
        _isFetching = false;
      }
    });

    $routeObserver.addListener((route, previousRoute) {
      var path = route.settings.name;
      if (path == '/starred') {
        // 路由变化，重新获取数据
        if (!_isFirstLoad) {
          _isFirstLoad = false;
          if (_refetch != null) {
            _refetch!();
          }
        }
      }
    });
    super.initState();
  }

  final EmojiParser _emojiParser = EmojiParser();
  final ScrollController _controller = ScrollController();
  FetchMore? _fetchMore;

  /// 是否正在加载更多，避免重复触发
  bool _isFetching = false;
  String? _paginationCursor;

  /// 是否首次加载数据
  bool _isFirstLoad = true;

  VoidCallback? _refetch;
  RunMutation? _deleteRunMutation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('我赞过的'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        ],
      ),
      body: Query(
        options: QueryOptions(
          document: gql(
            getInfo(),
          ),
          fetchPolicy: FetchPolicy.noCache,
        ),
        builder: (
          QueryResult result, {
          VoidCallback? refetch,
          FetchMore? fetchMore,
        }) {
          // 只需要首次获取数据时展示全屏 loading
          if (result.isLoading && _isFirstLoad) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (result.hasException) {
            inspect(result.exception);
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomEmpty(
                    description: 'Exception...',
                  ),
                ],
              ),
            );
          }
          var data = result.data?['viewer'];
          if (data == null) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [CustomEmpty()],
              ),
            );
          }
          var parsedData = UserModel.fromJson(data);
          _fetchMore = fetchMore;
          _paginationCursor = parsedData.starredRepositories.pageInfo.endCursor;
          _refetch = refetch;

          return RefreshIndicator(
            child: ListView(
              scrollDirection: Axis.vertical,
              controller: _controller,
              children: [
                _buildListsSection(parsedData),
                _buildReposSection(parsedData),
              ],
            ),
            onRefresh: () async {
              _isFirstLoad = false;
              refetch!();
            },
          );
        },
      ),
    );
  }

  Widget _buildListsSection(UserModel parsedData) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
            child: Row(
              children: [
                const Icon(
                  Icons.list,
                  color: Colors.grey,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: Text('我的列表'),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: () {
                    GoRouter.of(context).push('/create-user-list');
                  },
                  icon: const Icon(Icons.add, color: Colors.blue),
                  label: const Text('新', style: TextStyle(color: Colors.blue)),
                ),
              ],
            ),
          ),
          Column(
            children: [
              ...parsedData.lists.nodes.map(
                (e) => _buildList(e),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildList(UserListModel data) {
    return Dismissible(
      key: ValueKey(data.id),
      background: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(bottom: 12),
        color: Colors.red,
        child: Mutation(
          options: MutationOptions(document: gql(deleteUserList())),
          builder: (
            RunMutation runMutation,
            QueryResult? result,
          ) {
            _deleteRunMutation = runMutation;

            if (result!.isLoading) {
              return const CircularProgressIndicator(
                color: Colors.white,
              );
            }
            if (result.hasException) {
              inspect(result.exception);
              var message = result.exception?.graphqlErrors[0].message;
              $utils.clearSnackBar(context);
              $utils.showSnackBar(context, Text(message ?? ''));
            }
            // 删除成功
            if (result.data != null) {
              if (_refetch != null) {
                _refetch!();
              }
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                $utils.clearSnackBar(context);
                $utils.showSnackBar(context, const Text('删除成功'));
              });
            }

            return TextButton(
              child: const Text(
                '删除',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {},
            );
          },
        ),
      ),
      child: Card(
        margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        child: ListTile(
          title: Text(data.name),
          trailing: Text('${data.items.totalCount}'),
          onTap: () {},
        ),
      ),
      confirmDismiss: (direction) async {
        if (_deleteRunMutation != null) {
          _deleteRunMutation!({
            'listId': data.id,
          });
        }
        return false;
      },
    );
  }

  Widget _buildReposSection(UserModel parsedData) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      color: Colors.white,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              children: [
                Icon(
                  Icons.star_border,
                  color: Colors.grey,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: Text('已加星标'),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                ...parsedData.starredRepositories.nodes.map((e) => _buildRepo(e)),
                Visibility(
                  visible: _isFetching,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: const Center(
                      child: SizedBox(
                        width: 30,
                        height: 30,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRepo(RepositoryModel data) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Card(
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: Column(
            children: [
              ListTile(
                dense: true,
                visualDensity: const VisualDensity(vertical: -2),
                minVerticalPadding: -1,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.grey.shade200,
                      backgroundImage: FadeInImage(
                        placeholder: MemoryImage(kTransparentImage),
                        image: NetworkImage(data.owner.avatarUrl),
                      ).image,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: Text(
                        data.owner.name,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                subtitle: Text(
                  data.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_horiz,
                    color: Colors.grey,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                child: Text(
                  _emojiParser.emojify(data.description),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.yellow.shade700,
                      size: 18,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Text('${data.stargazerCount}'),
                    ),
                    Icon(
                      Icons.circle,
                      color: Color(
                        int.tryParse(
                              data.primaryLanguage.color.replaceAll(
                                '#',
                                '0xff',
                              ),
                            ) ??
                            0xffcccccc,
                      ),
                      size: 14,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Text(data.primaryLanguage.name),
                    ),
                  ],
                ),
              ),
            ],
          ),
          onTap: () {
            GoRouter.of(context).push('/repo-detail/${data.id}');
          },
        ),
      ),
    );
  }
}
