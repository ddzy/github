import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:github/components/custom_empty/custom_empty.dart';
import 'package:github/models/repository_model/repository_model.dart';
import 'package:github/models/tree_entry_model/tree_entry_model.dart';
import 'package:github/utils/utils.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

part 'gql.dart';

class RepoCodePage extends StatefulWidget {
  RepoCodePage({super.key, required this.id, required this.branch, required this.path})
      : expression = $utils.isExist(path) ? '$branch:$path' : '$branch:';

  final String id;
  final String branch;
  final String? path;
  final String expression;

  @override
  State<StatefulWidget> createState() {
    return _RepoCodeState();
  }
}

class _RepoCodeState extends State<RepoCodePage> {
  final String _title = '文件';
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
          onTap: () {},
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        centerTitle: false,
      ),
      body: Query(
        options: QueryOptions(
          document: gql(getInfo()),
          variables: {
            'id': widget.id,
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
          Map<String, dynamic> parsedData = result.data?['node'] ?? {};
          _repoInfo = RepositoryModel.fromJson(parsedData);
          _tree = _sortTree();
          inspect(_repoInfo);

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
              return Container(
                child: const Text('Blob文件'),
              );
            default:
              return Container();
          }
        },
      ),
    );
  }
}
