import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:github/utils/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

part 'gql.dart';

class CreateUserListPage extends StatefulWidget {
  const CreateUserListPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CreateUserListPageState();
  }
}

class _CreateUserListPageState extends State<CreateUserListPage> {
  final _ruleForm = _RuleForm(name: '', description: '');
  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('创建列表'),
        actions: [
          Mutation(
            options: MutationOptions(
              document: gql(postUserList()),
            ),
            builder: (RunMutation runMutation, QueryResult? result) {
              if (result!.isLoading) {
                return Container(
                  margin: const EdgeInsets.only(right: 20),
                  child: const Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                        ),
                      ),
                    ),
                  ),
                );
              }
              if (result.hasException) {
                inspect(result.exception);
                WidgetsBinding.instance.addPostFrameCallback(
                  (timeStamp) {
                    var message = result.exception?.graphqlErrors[0].message;
                    $utils.clearSnackBar(context);
                    $utils.showSnackBar(context, Text(message ?? ''));
                  },
                );
              }
              if (result.data != null) {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  if (GoRouter.of(context).canPop()) {
                    GoRouter.of(context).pop();
                  }
                });
              }
              return TextButton(
                onPressed: () {
                  if (_form.currentState!.validate()) {
                    runMutation(_ruleForm.toJson());
                  }
                },
                child: const Text(
                  "创建",
                ),
              );
            },
          ),
        ],
      ),
      body: Form(
        key: _form,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: '列表名称',
              ),
              onTapOutside: (event) {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '列表名称不能为空';
                }
                return null;
              },
              onChanged: (value) {
                _ruleForm.name = value;
              },
            ),
            TextFormField(
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: '描述',
              ),
              onTapOutside: (event) {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              onChanged: (value) {
                _ruleForm.description = value;
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _RuleForm {
  _RuleForm({
    required this.name,
    required this.description,
  });

  String name;
  String description;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      description: description,
    };
  }
}
