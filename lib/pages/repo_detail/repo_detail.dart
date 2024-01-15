import 'dart:developer';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:github/components/custom_empty/custom_empty.dart';
import 'package:github/components/custom_link/custom_link.dart';
import 'package:github/main.dart';
import 'package:github/models/ref_model/ref_model.dart';
import 'package:github/models/repository_model/repository_model.dart';
import 'package:github/utils/debounce.dart';
import 'package:github/utils/utils.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:visibility_detector/visibility_detector.dart';

part 'gql.dart';

class RepoDetailPage extends StatefulWidget {
  const RepoDetailPage({super.key, required this.id});

  final String id;

  @override
  State<StatefulWidget> createState() {
    return _RepoDetailPageState();
  }
}

class _RepoDetailPageState extends State<RepoDetailPage> with TickerProviderStateMixin {
  Widget _widget = Container();
  String _title = '';
  bool _isStarLoading = false;
  String _selectedBranch = '';
  late RepositoryModel _data;
  late List<RefModel> _branches;
  late Refetch? _branchesRefetcher;
  late AnimationController _controller;
  late Animation<Offset> _animation;
  final TextEditingController _searchController = TextEditingController();
  final _searchDebouncer = $Debounce(delay: const Duration(milliseconds: 500));

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 150));
    _animation = Tween<Offset>(begin: const Offset(0, 1.5), end: const Offset(0, 0)).chain(CurveTween(curve: Curves.ease)).animate(_controller);
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
          'expression': "${_selectedBranch.isEmpty ? 'HEAD' : _selectedBranch}:README.md",
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
            child: VisibilityDetector(
              key: UniqueKey(),
              child: Text(
                _data.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              onVisibilityChanged: (VisibilityInfo info) {
                if (info.visibleFraction < 1) {
                  _controller.forward();
                } else {
                  _controller.reverse();
                }
              },
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
      color: Colors.white,
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
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Row(
              children: [
                const Icon(Icons.route_outlined),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 6),
                    child: Text(
                      _selectedBranch.isEmpty ? _data.defaultBranchRef.name : _selectedBranch,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
            trailing: TextButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) {
                    return _buildBranchSheet(context);
                  },
                ).then((value) => _searchController.clear());
              },
              child: const Text('更改分支'),
            ),
          ),
          Material(
            color: Colors.white,
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
            color: Colors.white,
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

  Widget _buildBranchSheet(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, MediaQueryData.fromView(View.of(context)).padding.top, 0, 0),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 12),
                child: Text(
                  '选择分支',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
            child: TextField(
              decoration: InputDecoration(
                icon: const Icon(Icons.search),
                hintText: '搜索分支',
                suffixIcon: IconButton(
                  onPressed: () {
                    _searchController.clear();
                    setState(() {});
                  },
                  icon: const Icon(Icons.close),
                ),
              ),
              controller: _searchController,
              onChanged: (value) {
                _searchDebouncer.run(() {
                  // 搜索分支
                  _branchesRefetcher!();
                });
              },
            ),
          ),
          Expanded(
            child: SizedBox(
              child: Query(
                options: QueryOptions(
                  document: gql(getBranches()),
                  variables: {
                    'id': _data.id,
                    'query': _searchController.text,
                  },
                  fetchPolicy: FetchPolicy.noCache,
                ),
                builder: (
                  QueryResult result, {
                  Refetch? refetch,
                  FetchMore? fetchMore,
                }) {
                  if (result.isLoading) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: _buildPageLoading(),
                    );
                  }
                  if (result.hasException) {
                    inspect(result.exception);
                    return _buildPageException();
                  }
                  var branchData = RepositoryModel.fromJson(result.data?['node']);
                  _branches = branchData.refs.nodes;
                  _branchesRefetcher = refetch;
                  if (_selectedBranch.isEmpty) {
                    _selectedBranch = branchData.defaultBranchRef.name;
                  }
                  inspect(_branches);

                  return ListView.builder(
                    itemCount: _branches.length,
                    itemBuilder: (context, index) {
                      var branch = _branches[index];
                      return Material(
                        color: Colors.transparent,
                        child: InkWell(
                          child: RadioListTile(
                            title: Wrap(
                              children: [
                                Text(
                                  branch.name,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                ),
                                Visibility(
                                  visible: branchData.defaultBranchRef.id == branch.id,
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 12),
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(Radius.circular(100)),
                                      border: Border.all(color: Colors.grey),
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 4),
                                    child: const Text(
                                      '默认',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            value: branch.name,
                            groupValue: _selectedBranch,
                            controlAffinity: ListTileControlAffinity.trailing,
                            onChanged: (value) {
                              _selectedBranch = value!;
                              Navigator.of(context).pop();
                              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                                fetchInfo();
                              });
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
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
      child: Column(
        children: [
          const ListTile(
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
          Container(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
            color: Colors.white,
            child: MarkdownBody(
              data: _data.object.text,
              extensionSet: md.ExtensionSet(
                md.ExtensionSet.gitHubFlavored.blockSyntaxes,
                <md.InlineSyntax>[md.EmojiSyntax(), ...md.ExtensionSet.gitHubFlavored.inlineSyntaxes],
              ),
              imageBuilder: (uri, title, alt) {
                // 如果图片不以[png, jpg, jpeg, svg]结尾，那么就添加[png]后缀
                var url = uri.toString();
                var reg = RegExp(r"(\.png)|(\.jpg)|(\.jpeg)|(\.svg)$");
                if (!reg.hasMatch(url)) {
                  url = '$url.png';
                }

                return FadeInImage(
                  placeholder: MemoryImage(kTransparentImage),
                  image: NetworkImage(url),
                );
              },
              onTapLink: (text, href, title) {
                launchUrl(Uri.parse(href ?? ''));
              },
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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _searchDebouncer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SlideTransition(
          position: _animation,
          child: Text(_title),
        ),
      ),
      body: _widget,
    );
  }
}
