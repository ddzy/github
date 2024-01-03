import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:github/components/custom_empty/custom_empty.dart';
import 'package:github/models/user_model.dart';
import 'package:github/service/api.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
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
    super.initState();
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
      body: Query(
          options:
              QueryOptions(document: gql($api.getUser()), variables: const {}),
          builder: (QueryResult result,
              {VoidCallback? refetch, FetchMore? fetchMore}) {
            if (result.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (result.hasException) {
              inspect(result.exception);
              return const Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomEmpty(
                    description: 'Exception...',
                  )
                ],
              ));
            }

            var user = result.data?['viewer'];
            inspect(user);
            if (user == null) {
              return const Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [CustomEmpty()],
              ));
            }
            UserModel parsedUser = UserModel.fromJson(user);

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
                              image: NetworkImage(parsedUser.avatarUrl),
                            ).image,
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  parsedUser.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                  ),
                                ),
                                Text(
                                  parsedUser.login,
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
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(6)),
                          color: Colors.grey[100],
                        ),
                        child: Html(
                            data:
                                '${parsedUser.status.emojiHTML.replaceAll('<div>', '').replaceAll('</div>', '')}${parsedUser.status.message}'),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: Text(parsedUser.bio),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          children: [
                            const Icon(Icons.business),
                            Padding(
                              padding: const EdgeInsets.only(left: 6),
                              child: Text(parsedUser.company),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 12),
                              child: Icon(Icons.location_on_outlined),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 6),
                              child: Text(parsedUser.location),
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
                                parsedUser.websiteUrl,
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
                                parsedUser.isDeveloperProgramMember
                                    ? '开发者计划成员'
                                    : '',
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
                                      text:
                                          '${parsedUser.followers.totalCount}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  const TextSpan(text: ' 个关注者 '),
                                  const TextSpan(text: ' · '),
                                  TextSpan(
                                      text:
                                          '${parsedUser.following.totalCount}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  const TextSpan(text: ' 关注')
                                ],
                              )),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          children: [
                            const Icon(Icons.blender_outlined),
                            Padding(
                              padding: const EdgeInsets.only(left: 6),
                              child: Container(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}
