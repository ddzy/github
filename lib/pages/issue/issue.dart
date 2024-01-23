import 'package:flutter/material.dart';
import 'package:github/components/custom_empty/custom_empty.dart';

part 'gql.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('议题'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        ],
      ),
    );
  }
}
