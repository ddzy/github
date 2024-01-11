import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:github/components/custom_empty/custom_empty.dart';
import 'package:github/components/custom_link/custom_link.dart';
import 'package:github/main.dart';
import 'package:github/models/repository_model/repository_model.dart';
import 'package:github/utils/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:transparent_image/transparent_image.dart';

part 'gql.dart';

class RepoDetailPage extends StatefulWidget {
  const RepoDetailPage({super.key, required this.id});

  final String id;

  @override
  State<StatefulWidget> createState() {
    return _RepoDetailPageState();
  }
}

class _RepoDetailPageState extends State<RepoDetailPage> {
  String _title = '';
  Widget _widget = Container();
  late RepositoryModel _data;

  @override
  void initState() {
    super.initState();
    fetchInfo(isFirstFetch: true);
  }

  void fetchInfo({isFirstFetch = false}) async {
    if (isFirstFetch) {
      setState(() {
        _widget = _buildPageLoading();
      });
    }

    var result = await $client.value.query(
      QueryOptions(
        document: gql(getInfo()),
        variables: {
          'id': widget.id,
        },
      ),
    );
    if (result.hasException) {
      inspect(result.exception);
      setState(() {
        _widget = _buildPageException();
      });
    } else {
      var data = RepositoryModel.fromJson(result.data?['node']);
      _data = data;
      inspect(data);

      setState(() {
        _title = data.name;
        _widget = _buildPageContent();
      });
    }
  }

  Widget _buildPageLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildPageException() {
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

  Widget _buildPageContent() {
    return RefreshIndicator(
      onRefresh: () async {},
      child: ListView(
        children: [
          _buildProfile(),
        ],
      ),
    );
  }

  Widget _buildProfile() {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: FadeInImage(placeholder: MemoryImage(kTransparentImage), image: NetworkImage(_data.owner.avatarUrl)).image,
                radius: 15,
                backgroundColor: Colors.grey.shade200,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(_data.owner.name),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Text(
              _data.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Text(_data.description),
          ),
          Visibility(
            visible: _data.homepageUrl.isNotEmpty,
            child: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Row(
                children: [
                  Transform.rotate(
                    angle: $utils.angleToRadian(-45),
                    child: const Icon(Icons.link),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 6),
                    child: CustomLink(url: _data.homepageUrl),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Row(
              children: [
                const Icon(Icons.star_border),
                Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: RichText(
                    text: TextSpan(
                      text: '${_data.stargazerCount}',
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                      children: const [
                        TextSpan(text: ' 个星标', style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal)),
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(12, 0, 6, 0),
                  child: Icon(Icons.call_split),
                ),
                RichText(
                  text: TextSpan(
                    text: '${_data.forkCount}',
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                    children: const [
                      TextSpan(text: ' 个复刻', style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Visibility(
                        visible: _data.viewerHasStarred,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: IconButton.filledTonal(
                            onPressed: () {
                              GoRouter.of(context).go('/my');
                            },
                            icon: const Icon(
                              Icons.star,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.add),
                            label: const Text('添加到列表'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton.filledTonal(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications_none),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void reassemble() {
    // TODO: implement reassemble
    super.reassemble();
    fetchInfo(isFirstFetch: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: _widget,
    );
  }
}
