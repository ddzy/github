import 'package:flutter/material.dart';
import 'package:github/components/custom_language_viewbox/custom_language_viewbox.dart';
import 'package:github/components/custom_empty/custom_empty.dart';
import 'package:github/components/custom_markdown_viewbox/custom_markdown_viewbox.dart';
import 'package:github/models/repository_model/repository_model.dart';
import 'package:github/models/tree_entry_model/tree_entry_model.dart';
import 'package:github/utils/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

part 'gql.dart';

class RepoCodePage extends StatefulWidget {
  RepoCodePage({super.key, required this.user, required this.repoName, required this.type, required this.branch, this.path, this.language})
      : expression = $utils.isExist(path) ? '$branch:$path' : '$branch:',
        title = $utils.isExist(path) ? path! : '文件';

  final String user;
  final String repoName;
  final String branch;
  final String type;
  final String? path;
  final String? language;
  final String expression;
  final String title;

  @override
  State<StatefulWidget> createState() {
    return _RepoCodeState();
  }
}

class _RepoCodeState extends State<RepoCodePage> {
  RepositoryModel _repoInfo = RepositoryModel();
  List<TreeEntryModel> _tree = [];

  List<TreeEntryModel> _sortTree() {
    List<TreeEntryModel> oldTree = _repoInfo.object.entries;
    var order1 = [];
    var order2 = [];
    for (var element in oldTree) {
      if (element.type == 'tree') {
        order1.add(element);
      } else if (element.type == 'blob') {
        order2.add(element);
      }
    }
    return [...order1, ...order2];
  }

  Widget _buildPageLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildPageError(String errorMsg) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomEmpty(
            description: errorMsg,
          ),
        ],
      ),
    );
  }

  Widget _buildTreeItem(TreeEntryModel data) {
    var icon = data.type == 'tree'
        ? const Icon(Icons.folder)
        : data.type == 'blob'
            ? const Icon(Icons.insert_drive_file_outlined)
            : const Icon(Icons.question_mark_outlined);
    return Material(
      color: Colors.white,
      child: InkWell(
        child: ListTile(
          leading: icon,
          title: Text(data.name),
          onTap: () {
            context.push(
              '/user/${widget.user}/repository/${widget.repoName}/${data.type}/${widget.branch}/${Uri.encodeComponent(data.path)}?language=${data.language.name.toLowerCase()}',
            );
          },
        ),
      ),
    );
  }

  Widget _buildBlob() {
    var language = $utils.isExist(widget.language) ? widget.language! : '';

    if (language == 'markdown') {
      return CustomMarkdownViewbox(data: _repoInfo.object.text);
    } else {
      return CustomLanguageViewbox(code: _repoInfo.object.text, language: language);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: false,
      ),
      body: Query(
        options: QueryOptions(
          document: gql(getInfo()),
          variables: {
            'name': widget.repoName,
            'owner': widget.user,
            'expression': widget.expression,
          },
          fetchPolicy: FetchPolicy.noCache,
          onComplete: (data) {},
          onError: (error) {},
        ),
        builder: (result, {fetchMore, refetch}) {
          if (result.isLoading) {
            return _buildPageLoading();
          }
          if (result.hasException) {
            var errMsg = 'Exception';
            if ($utils.isExist(result.exception?.graphqlErrors.isNotEmpty)) {
              errMsg = result.exception?.graphqlErrors[0].message ?? '';
            }
            return _buildPageError(errMsg);
          }
          Map<String, dynamic> parsedData = result.data?['repository'] ?? {};
          _repoInfo = RepositoryModel.fromJson(parsedData);
          _tree = _sortTree();

          switch (_repoInfo.object.typeName) {
            case 'Tree':
              return ListView.builder(
                itemCount: _tree.length,
                itemBuilder: (context, index) {
                  var item = _tree[index];
                  return _buildTreeItem(item);
                },
              );
            case 'Blob':
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: _buildBlob(),
              );
            default:
              return Container();
          }
        },
      ),
    );
  }
}
