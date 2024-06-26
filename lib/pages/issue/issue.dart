import 'package:flutter/material.dart';
import 'package:github/components/custom_empty/custom_empty.dart';
import 'package:github/enums/issue_state_enum.dart';
import 'package:github/models/issue_model/issue_model.dart';
import 'package:github/pages/issue/issue_filter.dart';
import 'package:github/utils/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

part 'gql.dart';
part 'filter.dart';

class IssuePage extends StatefulWidget {
  const IssuePage({super.key, required this.user, this.repoName});

  final String user;
  final String? repoName;

  @override
  State<StatefulWidget> createState() {
    return _IssuePageState();
  }
}

class _IssuePageState extends State<IssuePage> {
  _IssuePageState();

  Refetch? _refetch;
  FetchMore? _fetchMore;
  String? _endCursor;
  bool _isFetchMoreing = false;
  bool _isRepoIssues = false;
  final IssueFilter _filterVariables = IssueFilter();
  List<IssueModel> _issues = [];
  final ScrollController _controller = ScrollController();

  handleRefetch() async {
    setState(() {
      _refetch!();
    });
  }

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

  Widget _buildPageException(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomEmpty(
            description: message,
          ),
        ],
      ),
    );
  }

  Widget _buildPageContent() {
    return ListView(
      controller: _controller,
      children: [
        ..._issues.map((e) => _buildListItem(e)),
        _buildListFetchMore(),
      ],
    );
  }

  Widget _buildListItem(IssueModel item) {
    return Material(
      color: Colors.white,
      child: InkWell(
        child: ListTile(
          leading: Builder(
            builder: (context) {
              switch (item.state) {
                case IssueStateEnum.open:
                  return const Icon(
                    Icons.adjust,
                    color: Colors.green,
                  );
                case IssueStateEnum.closed:
                  return const Icon(
                    Icons.adjust,
                    color: Colors.red,
                  );
                default:
                  return Container();
              }
            },
          ),
          title: Text(item.title),
          subtitle: Text('${item.repository.owner.login} / ${item.repository.name} #${item.number}'),
          trailing: Text(
            $utils.formatTimesAgo(
              DateTime.parse(item.createdAt),
              DateTime.now(),
            ),
          ),
          onTap: () {
            context.push('/user/${item.repository.owner.login}/repository/${item.repository.name}/issue/${item.number}');
          },
        ),
      ),
    );
  }

  Widget _buildListFetchMore() {
    return Visibility(
      visible: _isFetchMoreing,
      child: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _isRepoIssues = $utils.isExist(widget.repoName);
    _controller.addListener(() async {
      // 滚动到底部
      if (_controller.position.extentAfter == 0) {
        if (!_isFetchMoreing && $utils.isExist(_endCursor)) {
          _isFetchMoreing = true;
          await _fetchMore!(
            FetchMoreOptions(
              updateQuery: (previousResultData, fetchMoreResultData) {
                if (previousResultData == null) {
                  return fetchMoreResultData;
                }
                if (fetchMoreResultData == null) {
                  return fetchMoreResultData;
                }
                if (_isRepoIssues) {
                  fetchMoreResultData["repository"]?['issues']?["nodes"] = [
                    ...previousResultData["repository"]?['issues']?["nodes"],
                    ...fetchMoreResultData["repository"]?['issues']?["nodes"],
                  ];
                } else {
                  fetchMoreResultData["user"]?['issues']?["nodes"] = [
                    ...previousResultData["user"]?['issues']?["nodes"],
                    ...fetchMoreResultData["user"]?['issues']?["nodes"],
                  ];
                }
                return fetchMoreResultData;
              },
              variables: {
                'after': _endCursor,
              },
            ),
          );
          _isFetchMoreing = false;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('议题'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: IssuePageFilter(
            user: widget.user,
            onRefetch: handleRefetch,
            variables: _filterVariables,
          ),
        ),
      ),
      body: Query(
        options: QueryOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: gql(_isRepoIssues ? getIssuesByRepo() : getIssuesByUser()),
          variables: _isRepoIssues
              ? {
                  'login': widget.user,
                  'name': widget.repoName,
                  ..._filterVariables.toJson(),
                }
              : {
                  'login': widget.user,
                  ..._filterVariables.toJson(),
                },
        ),
        builder: (result, {fetchMore, refetch}) {
          _refetch = refetch;
          _fetchMore = fetchMore;
          if (result.isLoading && !_isFetchMoreing) {
            return _buildPageLoading();
          }
          if (result.hasException) {
            var message = result.exception?.graphqlErrors.firstOrNull?.message ?? '';
            return _buildPageException(message);
          }

          var data = _isRepoIssues ? (result.data?['repository']?['issues']) : result.data?['user']?['issues'];
          var nodes = data?['nodes'] as List;
          _issues = nodes.map((e) => IssueModel.fromJson(e)).toList();
          _endCursor = data?['pageInfo']?['endCursor'];

          if (_issues.isEmpty) {
            return _buildPageException('无数据');
          }

          return _buildPageContent();
        },
      ),
    );
  }
}
