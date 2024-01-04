import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:github/components/custom_empty/custom_empty.dart';
import 'package:github/models/user_model.dart';
import 'package:github/service/api.dart';
import 'package:github/utils/utils.dart';
import 'package:go_router/go_router.dart';
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
          '我的',
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
            EmojiParser emojiParser = EmojiParser();
            inspect(parsedUser);

            return ListView(
              scrollDirection: Axis.vertical,
              children: [
                Column(
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
                                Icon(
                                  Icons.business,
                                  color: Colors.grey[600],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 6),
                                  child: Text(parsedUser.company),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Icon(
                                    Icons.location_on_outlined,
                                    color: Colors.grey[600],
                                  ),
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
                                Icon(
                                  Icons.link,
                                  color: Colors.grey[600],
                                ),
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
                                Icon(
                                  Icons.developer_board_sharp,
                                  color: Colors.grey[600],
                                ),
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
                                Icon(
                                  Icons.person_outline,
                                  color: Colors.grey[600],
                                ),
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
                                Icon(
                                  Icons.blender_outlined,
                                  color: Colors.grey[600],
                                ),
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
                    Container(
                      margin: const EdgeInsets.only(top: 12),
                      padding: const EdgeInsets.fromLTRB(12, 20, 12, 20),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                            color: Colors.grey[200]!,
                          )),
                          color: Colors.white),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Transform.rotate(
                                angle: $utils.angleToRadian(45),
                                child: Icon(
                                  Icons.push_pin_outlined,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 6),
                                child: Text(
                                  '已置顶',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                          Container(
                            height: 150,
                            margin: const EdgeInsets.only(top: 12),
                            child: Material(
                              color: Colors.white,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  var item =
                                      parsedUser.pinnedItems.nodes[index];

                                  return Container(
                                    width: 250,
                                    margin: index == 0
                                        ? const EdgeInsets.all(0)
                                        : const EdgeInsets.only(left: 20),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey[200]!)),
                                    child: InkWell(
                                      child: Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                CircleAvatar(
                                                    radius: 10,
                                                    backgroundColor:
                                                        Colors.grey.shade200,
                                                    backgroundImage:
                                                        FadeInImage(
                                                      placeholder: MemoryImage(
                                                          kTransparentImage),
                                                      image: NetworkImage(
                                                          item.owner.avatarUrl),
                                                    ).image),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 6),
                                                  child: Text(item.owner.login),
                                                )
                                              ],
                                            ),
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              margin:
                                                  const EdgeInsets.only(top: 8),
                                              child: Text(
                                                item.name,
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                emojiParser
                                                    .emojify(item.description),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            const Spacer(),
                                            Row(
                                              children: [
                                                Icon(Icons.star,
                                                    color:
                                                        Colors.yellow.shade700),
                                                Text('${item.stargazerCount}'),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 6),
                                                  child: Icon(
                                                    Icons.circle,
                                                    size: 14,
                                                    color: Color(int.parse(item
                                                        .primaryLanguage.color
                                                        .replaceAll(
                                                            '#', '0xff'))),
                                                  ),
                                                ),
                                                Text(item.primaryLanguage.name),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      onTap: () {},
                                    ),
                                  );
                                },
                                itemCount: parsedUser.pinnedItems.nodes.length,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(color: Colors.white),
                      margin: const EdgeInsets.only(bottom: 12),
                      child: Material(
                        color: Colors.white,
                        child: Column(
                          children: [
                            ListTile(
                              leading: Container(
                                alignment: Alignment.center,
                                width: 30,
                                height: 30,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6)),
                                  color: Colors.black,
                                ),
                                child: const Icon(
                                  Icons.storefront,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                              title: const Text(
                                '仓库',
                              ),
                              trailing:
                                  Text('${parsedUser.repositories.totalCount}'),
                              onTap: () {},
                            ),
                            ListTile(
                              leading: Container(
                                alignment: Alignment.center,
                                width: 30,
                                height: 30,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6)),
                                  color: Colors.orange,
                                ),
                                child: const Icon(
                                  Icons.view_comfortable_outlined,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                              title: const Text('组织'),
                              trailing: Text(
                                  '${parsedUser.organizations.totalCount}'),
                              onTap: () {},
                            ),
                            ListTile(
                              leading: Container(
                                alignment: Alignment.center,
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(6)),
                                  color: Colors.yellow.shade700,
                                ),
                                child: const Icon(
                                  Icons.star_border,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                              title: const Text('已加星标'),
                              trailing: Text(
                                  '${parsedUser.starredRepositories.totalCount}'),
                              onTap: () {
                                context.push('/starred');
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            );
          }),
    );
  }
}
