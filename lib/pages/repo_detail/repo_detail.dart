import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:github/components/custom_empty/custom_empty.dart';
import 'package:github/components/custom_link/custom_link.dart';
import 'package:github/main.dart';
import 'package:github/models/repository_model/repository_model.dart';
import 'package:github/utils/utils.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:transparent_image/transparent_image.dart';

part 'gql.dart';

class RepoDetailPage extends StatefulWidget {
  const RepoDetailPage({super.key, required this.id});

  final String id;

  @override
  State<StatefulWidget> createState() {
    return _RepoDetailPageState();
  }
}

class _RepoDetailPageState extends State<RepoDetailPage> {
  String _title = '';
  Widget _widget = Container();
  bool _isStarLoading = false;
  late RepositoryModel _data;

  @override
  void initState() {
    super.initState();
    fetchInfo(isFirstFetch: true);
  }

  void _toggleStar(bool isStar) async {
    void next() async {
      _isStarLoading = true;
      await $client.value.mutate(
        MutationOptions(
          document: gql(isStar ? postStar() : postUnstar()),
          variables: {
            'id': _data.id,
          },
        ),
      );
      _isStarLoading = false;
      fetchInfo();
    }

    if (isStar) {
      next();
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('取消标星 ${_data.name}'),
            content: const Text('取消此仓库的标星后，也会将其从列表中删除'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('取消'),
              ),
              TextButton(
                onPressed: () {
                  next();
                  Navigator.pop(context);
                },
                child: const Text('确认'),
              ),
            ],
          );
        },
      );
    }
  }

  void fetchInfo({isFirstFetch = false}) async {
    if (isFirstFetch) {
      setState(() {
        _widget = _buildPageLoading();
      });
    }

    var result = await $client.value.query(
      QueryOptions(
        document: gql(getInfo()),
        variables: {
          'id': widget.id,
        },
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    if (result.hasException) {
      inspect(result.exception);
      setState(() {
        _widget = _buildPageException();
      });
    } else {
      var data = RepositoryModel.fromJson(result.data?['node']);
      _data = data;
      inspect(data);

      setState(() {
        _title = data.name;
        _widget = _buildPageContent();
      });
    }
  }

  Widget _buildPageLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildPageException() {
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

  Widget _buildPageContent() {
    return RefreshIndicator(
      onRefresh: () async {
        fetchInfo();
      },
      child: ListView(
        children: [
          _buildProfile(),
          _buildAttachment(),
          _buildBranch(),
          _buildReadme(),
        ],
      ),
    );
  }

  Widget _buildProfile() {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: FadeInImage(placeholder: MemoryImage(kTransparentImage), image: NetworkImage(_data.owner.avatarUrl)).image,
                radius: 15,
                backgroundColor: Colors.grey.shade200,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(_data.owner.name),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Text(
              _data.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Text(_data.description),
          ),
          Visibility(
            visible: _data.homepageUrl.isNotEmpty,
            child: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Row(
                children: [
                  Transform.rotate(
                    angle: $utils.angleToRadian(-45),
                    child: const Icon(Icons.link),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: CustomLink(url: _data.homepageUrl),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Row(
              children: [
                const Icon(Icons.star_border),
                Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: RichText(
                    text: TextSpan(
                      text: '${_data.stargazerCount}',
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                      children: const [
                        TextSpan(text: ' 个星标', style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal)),
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(12, 0, 6, 0),
                  child: Icon(Icons.call_split),
                ),
                RichText(
                  text: TextSpan(
                    text: '${_data.forkCount}',
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                    children: const [
                      TextSpan(text: ' 个复刻', style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Visibility(
                        visible: _data.viewerHasStarred,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: IconButton.filledTonal(
                            onPressed: () {
                              if (!_isStarLoading) {
                                _toggleStar(false);
                              }
                            },
                            icon: Icon(
                              Icons.star,
                              color: _data.viewerHasStarred ? Colors.black : Colors.grey.shade600,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: ElevatedButton.icon(
                            onPressed: () {
                              if (!_data.viewerHasStarred && !_isStarLoading) {
                                _toggleStar(true);
                              }
                            },
                            icon: _data.viewerHasStarred ? const Icon(Icons.add) : const Icon(Icons.star_border),
                            label: _data.viewerHasStarred ? const Text('添加到列表') : const Text('星标'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton.filledTonal(
                  onPressed: () {},
                  icon: Icon(
                    Icons.notifications_none,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttachment() {
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildAttachmentItem(Icons.adjust, Colors.green, '议题', _data.issues.totalCount),
          _buildAttachmentItem(Icons.hub_outlined, Colors.blue, '拉取请求', _data.pullRequests.totalCount),
          _buildAttachmentItem(Icons.forum_outlined, Colors.purple, '讨论', _data.pullRequests.totalCount),
        ],
      ),
    );
  }

  Widget _buildAttachmentItem(
    IconData iconData,
    Color leadingBgColor,
    String title,
    int count,
  ) {
    return Material(
      child: InkWell(
        child: ListTile(
          leading: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(6),
              ),
              color: leadingBgColor,
            ),
            child: Center(
              child: Icon(
                iconData,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),
          title: Text(title),
          trailing: Text('$count'),
          onTap: () {},
        ),
      ),
    );
  }

  Widget _buildBranch() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: Column(
        children: [
          ListTile(
            title: Row(
              children: [
                const Icon(Icons.route_outlined),
                Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: Text(_data.defaultBranchRef.name),
                ),
              ],
            ),
            trailing: TextButton(
              onPressed: () {},
              child: const Text('更改分支'),
            ),
          ),
          Material(
            child: InkWell(
              child: ListTile(
                leading: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                    color: Colors.grey.shade200,
                  ),
                  child: const Icon(
                    Icons.code,
                    size: 16,
                  ),
                ),
                title: const Text('代码'),
                onTap: () {},
              ),
            ),
          ),
          Material(
            child: InkWell(
              child: ListTile(
                leading: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                    color: Colors.grey.shade200,
                  ),
                  child: const Icon(
                    Icons.commit,
                    size: 16,
                  ),
                ),
                title: const Text('提交'),
                onTap: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReadme() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: const Column(
        children: [
          ListTile(
            title: Row(
              children: [
                Icon(Icons.info_outline),
                Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: Text('README.md'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void reassemble() {
    // TODO: implement reassemble
    super.reassemble();
    fetchInfo(isFirstFetch: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: _widget,
    );
  }
}
