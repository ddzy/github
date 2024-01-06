import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:github/components/custom_empty/custom_empty.dart';
import 'package:github/models/repository_model/repository_model.dart';
import 'package:github/models/user_model/user_model.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:transparent_image/transparent_image.dart';

part 'gql.dart';

class StarredPage extends StatefulWidget {
  const StarredPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _StarredPageState();
  }
}

class _StarredPageState extends State<StarredPage> {
  @override
  void initState() {
    super.initState();
  }

  final EmojiParser emojiParser = EmojiParser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('我赞过的'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        ],
      ),
      body: Query(
        options: QueryOptions(document: gql(getInfo())),
        builder: (
          QueryResult result, {
          VoidCallback? refetch,
          FetchMore? fetchMore,
        }) {
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
                  ),
                ],
              ),
            );
          }
          var data = result.data?['viewer'];
          inspect(data);
          if (data == null) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [CustomEmpty()],
              ),
            );
          }
          var parsedData = UserModel.fromJson(data);

          return ListView(
            scrollDirection: Axis.vertical,
            children: [
              _buildListsSection(parsedData),
              _buildReposSection(parsedData),
            ],
          );
        },
      ),
    );
  }

  Widget _buildListsSection(UserModel parsedData) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
            child: Row(
              children: [
                const Icon(
                  Icons.list,
                  color: Colors.grey,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: Text('我的列表'),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add, color: Colors.blue),
                  label: const Text('新', style: TextStyle(color: Colors.blue)),
                ),
              ],
            ),
          ),
          Column(
            children: [
              ...parsedData.lists.nodes.map(
                (e) => Card(
                  margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                  child: ListTile(
                    title: Text(e.name),
                    trailing: Text('${e.items.totalCount}'),
                    onTap: () {},
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReposSection(UserModel parsedData) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      color: Colors.white,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              children: [
                Icon(
                  Icons.star_border,
                  color: Colors.grey,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: Text('已加星标'),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                ...parsedData.starredRepositories.nodes.map((e) => _buildRepo(e)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRepo(RepositoryModel data) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Card(
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: Column(
            children: [
              ListTile(
                dense: true,
                visualDensity: const VisualDensity(vertical: -2),
                minVerticalPadding: -1,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.grey.shade200,
                      backgroundImage: FadeInImage(
                        placeholder: MemoryImage(kTransparentImage),
                        image: NetworkImage(data.owner.avatarUrl),
                      ).image,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: Text(
                        data.owner.name,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                subtitle: Text(
                  data.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_horiz,
                    color: Colors.grey,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                child: Text(
                  emojiParser.emojify(data.description),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.yellow.shade700,
                      size: 18,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Text('${data.stargazerCount}'),
                    ),
                    Icon(
                      Icons.circle,
                      color: Color(
                        int.tryParse(
                              data.primaryLanguage.color.replaceAll(
                                '#',
                                '0xff',
                              ),
                            ) ??
                            0xffcccccc,
                      ),
                      size: 14,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Text(data.primaryLanguage.name),
                    ),
                  ],
                ),
              ),
            ],
          ),
          onTap: () {},
        ),
      ),
    );
  }
}
