import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:github/components/custom_empty/custom_empty.dart';
import 'package:github/models/user_model.dart';
import 'package:github/service/api.dart';
import 'package:transparent_image/transparent_image.dart';

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

  Future<UserModel> _getUser() async {
    var res = await $api.getUser();
    inspect(res.data);
    var data = UserModel.fromJson(res.data);
    return data;
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
      body: FutureBuilder<UserModel>(
          future: _getUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              var data = snapshot.data!;
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.fromLTRB(12, 20, 12, 20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.grey.shade200,
                              backgroundImage: FadeInImage(
                                placeholder: MemoryImage(kTransparentImage),
                                image: NetworkImage(data.avatar_url),
                              ).image,
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                    ),
                                  ),
                                  Text(
                                    data.login,
                                    style: const TextStyle(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: Text(data.bio),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: Row(
                            children: [
                              const Icon(Icons.business),
                              Padding(
                                padding: const EdgeInsets.only(left: 6),
                                child: Text(data.company),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 12),
                                child: Icon(Icons.location_on_outlined),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 6),
                                child: Text(data.location),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: Row(
                            children: [
                              const Icon(Icons.link),
                              Padding(
                                padding: const EdgeInsets.only(left: 6),
                                child: Text(
                                  data.blog,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: Row(
                            children: [
                              const Icon(Icons.developer_board_sharp),
                              Padding(
                                padding: const EdgeInsets.only(left: 6),
                                child: Text(
                                  data.plan.name.isNotEmpty ? '开发者计划成员' : '',
                                  style: const TextStyle(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: Row(
                            children: [
                              const Icon(Icons.person_outline),
                              Padding(
                                padding: const EdgeInsets.only(left: 6),
                                child: RichText(
                                    text: TextSpan(
                                  style: const TextStyle(color: Colors.black),
                                  children: [
                                    TextSpan(
                                        text: '${data.followers}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    const TextSpan(text: ' 个关注者 '),
                                    const TextSpan(text: ' · '),
                                    TextSpan(
                                        text: '${data.following}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    const TextSpan(text: ' 关注')
                                  ],
                                )),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return const Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [CustomEmpty()],
              ));
            }
          }),
    );
  }
}
