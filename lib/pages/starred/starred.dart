import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:github/components/custom_empty/custom_empty.dart';
import 'package:github/models/user_model.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

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
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
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
          Column(
            children: [
              ...parsedData.lists.nodes.map(
                (e) => Card(
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
    return Container();
  }
}
