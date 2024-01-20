import 'package:flutter/material.dart';

class RepoPage extends StatefulWidget {
  const RepoPage({super.key, required this.user});

  final String user;

  @override
  State<StatefulWidget> createState() {
    return _RepoPageState();
  }
}

class _RepoPageState extends State<RepoPage> {
  _RepoPageState();

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
