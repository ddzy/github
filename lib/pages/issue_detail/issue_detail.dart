import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:github/components/custom_empty/custom_empty.dart';
import 'package:github/models/issue_model/issue_model.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

part 'gql.dart';

class IssueDetailPage extends StatefulWidget {
  const IssueDetailPage({super.key, required this.user, required this.repoName, required this.issueNumber});

  final String user;
  final String repoName;
  final int issueNumber;

  @override
  State<StatefulWidget> createState() {
    return _IssueDetailPageState();
  }
}

class _IssueDetailPageState extends State<IssueDetailPage> {
  IssueModel _issueInfo = const IssueModel();

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
    return const SingleChildScrollView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('issue详情'),
      ),
      body: Query(
        options: QueryOptions(
          document: gql(getInfo()),
          variables: {
            'owner': widget.user,
            'name': widget.repoName,
            'number': widget.issueNumber,
          },
          parserFn: (data) {
            var parsedData = IssueModel.fromJson(data['repository']['issue']);
            return parsedData;
          },
        ),
        builder: (result, {fetchMore, refetch}) {
          if (result.isLoading) {
            return _buildPageLoading();
          }
          if (result.hasException) {
            var message = result.exception?.graphqlErrors.firstOrNull?.message ?? '';
            return _buildPageException(message);
          }

          _issueInfo = result.parsedData!;
          inspect(_issueInfo);

          return _buildPageContent();
        },
      ),
    );
  }
}
