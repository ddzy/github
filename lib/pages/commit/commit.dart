import 'package:flutter/material.dart';

class CommitPage extends StatefulWidget {
  const CommitPage({super.key, required this.user, required this.repoId});

  final String user;
  final String repoId;

  @override
  State<StatefulWidget> createState() {
    return _CommitPageState();
  }
}

class _CommitPageState extends State<CommitPage> {
  _CommitPageState();

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
