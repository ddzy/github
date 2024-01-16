import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:github/components/common_select_lists_sheet/gql.dart';
import 'package:github/components/custom_empty/custom_empty.dart';
import 'package:github/models/user_list_model/user_list_model.dart';
import 'package:github/utils/utils.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class CommonSelectListsSheet extends StatefulWidget {
  const CommonSelectListsSheet({super.key, required this.itemId});

  final String itemId;

  @override
  State<StatefulWidget> createState() {
    return _CommonSelectListsSheetState();
  }
}

class _CommonSelectListsSheetState extends State<CommonSelectListsSheet> {
  _CommonSelectListsSheetState();

  List<UserListModel> _lists = [];
  final bool _isFirstlyFetch = true;
  final List<String> _selectedList = [];

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
          value: _selectedList.contains(data.id),
          onChanged: (value) {
            setState(() {
              if (!$utils.isExist(value)) {
                _selectedList.remove(data.id);
              } else {
                _selectedList.add(data.id);
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
      constraints: const BoxConstraints(
        maxHeight: 400,
      ),
      child: Scaffold(
        body: Query(
          options: QueryOptions(document: gql(getLists()), fetchPolicy: FetchPolicy.noCache),
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

            var newLists = result.data?['viewer']?['lists']?['nodes'] as List;
            _lists = newLists.map((v) => UserListModel.fromJson(v)).toList();

            return SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    trailing: Mutation(
                      options: MutationOptions(
                        document: gql(addIntoLists()),
                      ),
                      builder: (
                        RunMutation runMutation,
                        QueryResult? result,
                      ) {
                        if (result!.hasException) {
                          inspect(result.exception);
                          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                            var errorMessage = result.exception?.graphqlErrors[0].message;
                            $utils.clearSnackBar(context);
                            $utils.showSnackBar(context, Text(errorMessage ?? ''));
                          });
                        }
                        if ($utils.isExist(result.data)) {
                          Navigator.of(context).pop();
                        }

                        return TextButton.icon(
                          onPressed: () {
                            if (result.isLoading) {
                              return;
                            }
                            runMutation(
                              {
                                // 'itemId': widget.itemId,
                                'listIds': _selectedList,
                                'suggestListIds': const [],
                              },
                            );
                          },
                          icon: result.isLoading
                              ? const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const SizedBox(),
                          label: const Text('保存'),
                        );
                      },
                    ),
                  ),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 300),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _lists.length,
                      itemBuilder: (context, index) {
                        var item = _lists[index];
                        return _buildListItem(item);
                      },
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      child: ListTile(
                        title: Row(
                          children: [
                            Icon(
                              Icons.add,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 12),
                              child: Text(
                                '创建列表',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
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
