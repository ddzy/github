import 'dart:collection';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:github/components/common_select_lists_sheet/gql.dart';
import 'package:github/components/custom_empty/custom_empty.dart';
import 'package:github/models/user_list_model/user_list_model.dart';
import 'package:github/utils/utils.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class CommonSelectListsSheet extends StatefulWidget {
  const CommonSelectListsSheet({super.key, required this.itemId, this.maxHeight = 350});

  final String itemId;
  final double maxHeight;

  @override
  State<StatefulWidget> createState() {
    return _CommonSelectListsSheetState();
  }
}

class _CommonSelectListsSheetState extends State<CommonSelectListsSheet> {
  _CommonSelectListsSheetState();

  List<UserListModel> _lists = [];
  final bool _isFirstlyFetch = true;
  final HashSet<String> _selectedSet = HashSet();

  Widget _buildPageLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildPageException() {
    return const Center(
      child: CustomEmpty(
        description: '出错了...',
      ),
    );
  }

  Widget _buildListItem(UserListModel data) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        child: CheckboxListTile(
          title: Text(data.name),
          value: _selectedSet.contains(data.id),
          onChanged: (value) {
            setState(() {
              if (!$utils.isExist(value)) {
                _selectedSet.remove(data.id);
              } else {
                _selectedSet.add(data.id);
              }
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: widget.maxHeight,
      ),
      child: Scaffold(
        body: Query(
          options: QueryOptions(
            document: gql(getLists()),
            fetchPolicy: FetchPolicy.noCache,
            onComplete: (data) {
              if ($utils.isExist(data)) {
                var newLists = data?['viewer']?['lists']?['nodes'] as List;
                _lists = newLists.map((v) => UserListModel.fromJson(v)).toList();
                for (var element in _lists) {
                  if (element.items.nodes.indexWhere((element) => element.id == widget.itemId) != -1) {
                    _selectedSet.add(element.id);
                  }
                }
              }
            },
          ),
          builder: (
            QueryResult result, {
            Refetch? refetch,
            FetchMore? fetchMore,
          }) {
            if (result.isLoading && _isFirstlyFetch) {
              return _buildPageLoading();
            }
            if (result.hasException) {
              return _buildPageException();
            }

            return SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 12, 20, 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.add),
                          label: const Text('创建列表'),
                        ),
                        Mutation(
                          options: MutationOptions(
                            document: gql(addIntoLists()),
                            onCompleted: (data) {
                              if ($utils.isExist(data)) {
                                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                                  $utils.showSnackBar(context, const Text('保存成功'));
                                });
                              }
                            },
                            onError: (error) {
                              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                                var errorMessage = error?.graphqlErrors[0].message;
                                $utils.showSnackBar(context, Text(errorMessage ?? ''));
                              });
                            },
                          ),
                          builder: (
                            RunMutation runMutation,
                            QueryResult? result,
                          ) {
                            if (!$utils.isExist(result)) {
                              return Container();
                            }
                            return TextButton.icon(
                              onPressed: result!.isLoading
                                  ? null
                                  : () {
                                      runMutation(
                                        {
                                          'itemId': widget.itemId,
                                          'listIds': _selectedSet.toList(),
                                          'suggestListIds': const [],
                                        },
                                      );
                                    },
                              icon: const Icon(Icons.check),
                              label: const Text('保存'),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _lists.length,
                      itemBuilder: (context, index) {
                        var item = _lists[index];
                        return _buildListItem(item);
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
