import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('提交'),
      ),
      body: Container(),
    );
  }
}
