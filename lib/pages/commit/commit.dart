import 'dart:developer';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:github/components/custom_empty/custom_empty.dart';
import 'package:github/interfaces/git_object_interface.dart';
import 'package:github/models/commit_model/commit_model.dart';
import 'package:github/models/commit_status_model/commit_status_model.dart';
import 'package:github/utils/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

part 'gql.dart';

class CommitPage extends StatefulWidget {
  const CommitPage({super.key, required this.user, required this.repoName, required this.branch});

  final String user;
  final String repoName;
  final String branch;

  @override
  State<StatefulWidget> createState() {
    return _CommitPageState();
  }
}

class _CommitPageState extends State<CommitPage> {
  _CommitPageState();

  List<CommitModel> _commits = [];
  late FetchMore? _fetchMore;
  bool _isFetchMoreLoading = false;
  String _endCursor = '';
  final ScrollController _scrollController = ScrollController();

  Widget _buildPageLoading() {
    return const Center(
      child: CircularProgressIndicator(),
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
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: ListView(
            controller: _scrollController,
            scrollDirection: Axis.vertical,
            children: [
              ..._commits.map((e) => _buildListItem(e)),
              _buildListLoading(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildListItem(CommitModel item) {
    return Material(
      color: Colors.white,
      child: InkWell(
        child: ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Text(
                  item.message,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Visibility(
                    visible: [ICommitStatusState.ERROR.name, ICommitStatusState.SUCCESS.name].contains(item.status.state.name),
                    child: item.status.state.name == 'ERROR'
                        ? const Icon(Icons.close, color: Colors.red)
                        : const Icon(
                            Icons.done,
                            color: Colors.green,
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Text(
                      $utils.formatTimesAgo(DateTime.parse(item.committer.date), DateTime.now()),
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          subtitle: Row(
            children: [
              CircleAvatar(
                radius: 10,
                backgroundImage: ExtendedImage.network(
                  item.committer.avatarUrl,
                  fit: BoxFit.fill,
                  cache: true,
                ).image,
              ),
              Text(
                ' ${item.committer.name} ',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const Text('撰写'),
            ],
          ),
          minVerticalPadding: 12,
          onTap: () {
            context.push('/user/${widget.user}/repository/${widget.repoName}/commit/${item.id}?detail=true');
          },
        ),
      ),
    );
  }

  Widget _buildListLoading() {
    return Visibility(
      visible: _isFetchMoreLoading,
      child: Container(
        height: 60,
        color: Colors.white,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  @override
  void initState() {
    _scrollController.addListener(() async {
      if (_scrollController.position.extentAfter == 0) {
        if (_endCursor == '') {
          _isFetchMoreLoading = false;
        } else if (!_isFetchMoreLoading) {
          _isFetchMoreLoading = true;
          await _fetchMore!(
            FetchMoreOptions(
              updateQuery: (previousResultData, fetchMoreResultData) {
                if (previousResultData == null) {
                  return fetchMoreResultData;
                }
                if (fetchMoreResultData == null) {
                  return fetchMoreResultData;
                }
                fetchMoreResultData["repository"]?['ref']?["target"]?['history']?['nodes'] = [
                  ...previousResultData["repository"]?['ref']?["target"]?['history']?['nodes'],
                  ...fetchMoreResultData["repository"]?['ref']?["target"]?['history']?['nodes'],
                ];
                return fetchMoreResultData;
              },
              variables: {
                'after': _endCursor,
                'name': widget.repoName,
                'owner': widget.user,
                'branch': widget.branch,
              },
            ),
          );
          _isFetchMoreLoading = false;
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('提交'),
      ),
      body: Query(
        options: QueryOptions(
          document: gql(getInfo()),
          fetchPolicy: FetchPolicy.noCache,
          variables: {
            'name': widget.repoName,
            'owner': widget.user,
            'branch': widget.branch,
          },
        ),
        builder: (result, {fetchMore, refetch}) {
          if (result.isLoading && !_isFetchMoreLoading) {
            return _buildPageLoading();
          }
          if (result.hasException) {
            var errorMessage = result.exception?.graphqlErrors.firstOrNull?.message ?? '';
            return _buildPageException(errorMessage);
          }

          GitObjectInterface parsedData = GitObjectInterface.fromJson(result.data?['repository']['ref']['target']);
          _commits = parsedData.history.nodes;
          _fetchMore = fetchMore;
          _endCursor = parsedData.history.pageInfo.endCursor;

          return _buildPageContent();
        },
      ),
    );
  }
}
