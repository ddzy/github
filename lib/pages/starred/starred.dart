import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:github/components/custom_empty/custom_empty.dart';
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
        title: Text('我赞过的'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
        ],
      ),
      body: Query(
          options: QueryOptions(
              document: gql(genGql()), operationName: 'getRepositories'),
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
              ));
            }

            return ListView(
              scrollDirection: Axis.vertical,
              children: [
                Container(),
              ],
            );
          }),
    );
  }
}
