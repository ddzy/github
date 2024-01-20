import 'package:flutter/material.dart';

class CommitDetailPage extends StatefulWidget {
  const CommitDetailPage({super.key});

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
