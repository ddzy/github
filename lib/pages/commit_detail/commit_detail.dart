import 'dart:developer';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:github/components/custom_empty/custom_empty.dart';
import 'package:github/models/commit_model/commit_model.dart';
import 'package:github/models/commit_status_model/commit_status_model.dart';
import 'package:github/utils/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

part './gql.dart';

class CommitDetailPage extends StatefulWidget {
  const CommitDetailPage({super.key, required this.user, required this.repoName, required this.commitId});

  final String user;
  final String repoName;
  final String commitId;

  @override
  State<StatefulWidget> createState() {
    return _CommitDetailPageState();
  }
}

class _CommitDetailPageState extends State<CommitDetailPage> {
  _CommitDetailPageState();

  CommitModel _commitModel = const CommitModel();
  final WebViewController _webViewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {
          inspect(error);
        },
        onNavigationRequest: (NavigationRequest request) {
          return NavigationDecision.navigate;
        },
      ),
    );

  Widget _buildPageLoading() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
        ],
      ),
    );
  }

  Widget _buildPageException(String errorMessage) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomEmpty(
            description: errorMessage,
          ),
        ],
      ),
    );
  }

  Widget _buildPageContent() {
    return TabBarView(
      children: [
        _buildChangesSection(),
        _buildDetailsSection(),
      ],
    );
  }

  Widget _buildChangesSection() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Material(
            color: Colors.white,
            child: InkWell(
              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 15,
                            backgroundImage: ExtendedImage.network(_commitModel.committer.avatarUrl).image,
                          ),
                          Padding(padding: const EdgeInsets.only(left: 12), child: Text(_commitModel.committer.name)),
                          Text(
                            ' 撰写',
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Visibility(
                          visible: [ICommitStatusState.ERROR.name, ICommitStatusState.SUCCESS.name].contains(_commitModel.status.state.name),
                          child: _commitModel.status.state.name == 'ERROR'
                              ? const Icon(Icons.close, color: Colors.red)
                              : const Icon(
                                  Icons.done,
                                  color: Colors.green,
                                ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Text(
                            $utils.formatTimesAgo(DateTime.parse(_commitModel.committer.date), DateTime.now()),
                            style: TextStyle(
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                    _commitModel.message,
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
                minVerticalPadding: 12,
                onTap: () {},
              ),
            ),
          ),
          Container(
            color: Colors.white,
            margin: const EdgeInsets.only(top: 20),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${_commitModel.changedFilesIfAvailable}个文件已更改',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            '${_commitModel.additions} 个添加',
                            style: const TextStyle(color: Colors.green),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Text(
                              '${_commitModel.deletions} 个删除',
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 200000,
                        child: WebViewWidget(controller: _webViewController),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsSection() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailsCopy(),
          _buildDetailsContributor(),
          _buildDetailsParentCommit(),
        ],
      ),
    );
  }

  Widget _buildDetailsCopy() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '提交',
            style: TextStyle(color: Colors.grey.shade600),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 5,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.commit),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Text(
                            _commitModel.oid,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: TextButton(onPressed: () {}, child: const Text('复制')),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsContributor() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '贡献者',
            style: TextStyle(color: Colors.grey.shade600),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundImage: ExtendedImage.network(_commitModel.committer.avatarUrl).image,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Text(
                      _commitModel.committer.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
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

  Widget _buildDetailsParentCommit() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '其它',
            style: TextStyle(color: Colors.grey.shade600),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  onPressed: () {
                    var prevCommitId = _commitModel.parents.nodes.firstOrNull?.id ?? '';
                    if ($utils.isExist(prevCommitId)) {
                      context.push('/user/${widget.user}/repository/${widget.repoName}/commit/$prevCommitId?detail=true');
                    }
                  },
                  icon: const Icon(Icons.arrow_back_sharp),
                  label: const Text('上一个'),
                ),
                TextButton.icon(
                  onPressed: () {
                    var nextCommitId = _commitModel.history.nodes.lastOrNull?.id ?? '';
                    if ($utils.isExist(nextCommitId)) {
                      context.push('/user/${widget.user}/repository/${widget.repoName}/commit/$nextCommitId?detail=true');
                    }
                  },
                  icon: const Icon(Icons.arrow_forward_sharp),
                  label: const Text('下一个'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('提交'),
          bottom: const TabBar(
            tabs: [
              Tab(
                text: '更改',
              ),
              Tab(
                text: '详细信息',
              ),
            ],
          ),
        ),
        body: Query(
          options: QueryOptions(
            document: gql(getInfo()),
            variables: {
              'id': widget.commitId,
            },
          ),
          builder: (result, {fetchMore, refetch}) {
            if (result.isLoading) {
              return _buildPageLoading();
            }
            if (result.hasException) {
              var errorMessage = result.exception?.graphqlErrors.firstOrNull?.message ?? '';
              return _buildPageException(errorMessage);
            }

            var parsedData = result.data?['node'];
            _commitModel = CommitModel.fromJson(parsedData);
            _webViewController.loadRequest(Uri.parse(_commitModel.commitUrl));

            return _buildPageContent();
          },
        ),
      ),
    );
  }
}
