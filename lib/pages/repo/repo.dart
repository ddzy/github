import 'dart:developer';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:github/components/custom_empty/custom_empty.dart';
import 'package:github/models/repository_model/repository_model.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

part 'gql.dart';
part 'filter.dart';

enum ColorLabel {
  blue('Blue', Colors.blue),
  pink('Pink', Colors.pink),
  green('Green', Colors.green),
  yellow('Orange', Colors.orange),
  grey('Grey', Colors.grey);

  const ColorLabel(this.label, this.color);
  final String label;
  final Color color;
}

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

  List<RepositoryModel> _list = [];
  Refetch? _refetch;
  FetchMore? _fetchMore;
  late final Map<String, dynamic> _baseVariables = {
    'user': widget.user,
  };
  late Map<String, dynamic> _variables = _baseVariables;

  Widget _buildPageLoading() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
        ],
      ),
    );
  }

  Widget _buildPageException(String errorMessage) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomEmpty(
            description: errorMessage,
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildPageFilter() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(40),
      child: Container(
        decoration: const BoxDecoration(),
        child: Row(
          children: [
            DropdownMenu<RepoFilterEntry>(
              initialSelection: RepoFilterEntry.all,
              inputDecorationTheme: const InputDecorationTheme().copyWith(
                border: const UnderlineInputBorder(),
                constraints: const BoxConstraints(minHeight: 60, maxHeight: 60),
              ),
              onSelected: (RepoFilterEntry? value) async {
                setState(() {
                  var res = value!.format();
                  _variables = {
                    ..._baseVariables,
                    ...res,
                  };
                  _refetch!();
                });
              },
              dropdownMenuEntries: RepoFilterEntry.values.map<DropdownMenuEntry<RepoFilterEntry>>((RepoFilterEntry e) {
                return DropdownMenuEntry<RepoFilterEntry>(
                  value: e,
                  label: e.label,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageContent() {
    return ListView(
      children: _list.map((e) => _buildListItem(e)).toList(),
    );
  }

  Widget _buildListItem(RepositoryModel item) {
    return Material(
      color: Colors.white,
      child: InkWell(
        child: ListTile(
          leading: CircleAvatar(
            radius: 15,
            backgroundImage: ExtendedImage.network(item.owner.avatarUrl).image,
          ),
          title: Text(
            item.name,
            style: const TextStyle(
              fontSize: 17,
            ),
          ),
          subtitle: Text(item.owner.name),
          onTap: () {},
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('仓库'),
        bottom: _buildPageFilter(),
      ),
      body: Query(
        options: QueryOptions(
          document: gql(getInfo()),
          variables: _variables,
        ),
        builder: (result, {fetchMore, refetch}) {
          if (result.isLoading) {
            debugPrint('1');
            return _buildPageLoading();
          }
          if (result.hasException) {
            var errorMessage = result.exception?.graphqlErrors.firstOrNull?.message ?? '';
            return _buildPageException(errorMessage);
          }
          _refetch = refetch;
          _fetchMore = _fetchMore;
          var data = result.data?['user']?['repositories']['nodes'] as List;
          _list = data
              .map(
                (e) => RepositoryModel.fromJson(e),
              )
              .toList();
          if (_list.isEmpty) {
            return _buildPageException('无数据');
          }

          return _buildPageContent();
        },
      ),
    );
  }
}
