import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:github/service/api.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyPageState();
  }
}

class _MyPageState extends State<MyPage> {
  @override
  void initState() {
    _getUser();
    super.initState();
  }

  _getUser() async {
    try {
      var res = await $api.getUser();
      inspect(jsonEncode(res.data));
    } catch (e) {
      VoidCallbackAction();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'My',
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Icon(Icons.share),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Icon(Icons.settings),
          )
        ],
      ),
      body: Text('My'),
    );
  }
}
