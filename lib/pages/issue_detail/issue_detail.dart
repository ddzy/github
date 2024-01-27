import 'dart:developer';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:github/components/custom_empty/custom_empty.dart';
import 'package:github/components/custom_markdown_viewbox/custom_markdown_viewbox.dart';
import 'package:github/enums/issue_state_enum.dart';
import 'package:github/enums/reaction_content_enum.dart';
import 'package:github/main.dart';
import 'package:github/models/issue_comment_model/issue_comment_model.dart';
import 'package:github/models/issue_model/issue_model.dart';
import 'package:github/models/reaction_group_model/reaction_group_model.dart';
import 'package:github/utils/utils.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

part 'gql.dart';

class IssueDetailPage extends StatefulWidget {
  const IssueDetailPage({super.key, required this.user, required this.repoName, required this.issueNumber});

  final String user;
  final String repoName;
  final int issueNumber;

  @override
  State<StatefulWidget> createState() {
    return _IssueDetailPageState();
  }
}

class _IssueDetailPageState extends State<IssueDetailPage> {
  IssueModel _issueInfo = const IssueModel();
  bool _isFirstlyFetch = true;
  bool _isUpdatingReaction = false;
  Refetch? _refetch;
  final EmojiParser emojiParser = EmojiParser();

  void updateReaction(bool isAddReaction, String id, String content) async {
    if (!_isUpdatingReaction) {
      _isUpdatingReaction = true;
      _isFirstlyFetch = false;
    }
    var res = await $client.value.mutate(
      MutationOptions(
        document: gql(isAddReaction ? addReaction() : removeReaction()),
        variables: {
          'id': id,
          'content': content,
        },
      ),
    );
    _isUpdatingReaction = false;

    if ($utils.isExist(res.data)) {
      _refetch!();
    }
  }

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

  Widget _buildPageException(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomEmpty(
            description: message,
          ),
        ],
      ),
    );
  }

  Widget _buildPageContent() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildIssueProfile(),
            _buildIssueComments(),
          ],
        ),
      ),
    );
  }

  Widget _buildIssueProfile() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 10,
                backgroundImage: ExtendedImage.network(_issueInfo.repository.owner.avatarUrl).image,
              ),
              Text(' ${widget.user}'),
              const Text(' /'),
              Text(' ${widget.repoName}'),
              Text(' #${widget.issueNumber}'),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(
              _issueInfo.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Builder(
            builder: (context) {
              Color color = Colors.transparent;
              String label = '';
              switch (_issueInfo.state) {
                case IssueStateEnum.open:
                  color = Colors.green;
                  label = '已激活';
                  break;
                case IssueStateEnum.closed:
                  color = Colors.red;
                  label = '已关闭';
                  break;
                default:
                  break;
              }
              return Chip(
                padding: const EdgeInsets.all(0),
                backgroundColor: color.withAlpha(30),
                avatar: Icon(
                  Icons.adjust,
                  color: color,
                ),
                label: Text(
                  label,
                  style: TextStyle(color: color),
                ),
                shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(2)), side: BorderSide(color: Colors.transparent)),
                visualDensity: VisualDensity.compact,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildIssueComments() {
    return Column(
      children: [
        ..._issueInfo.comments.nodes.map((e) => _buildIssueCommentItem(e)),
      ],
    );
  }

  Widget _buildIssueCommentItem(IssueCommentModel item) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Card(
        shape: const BeveledRectangleBorder(),
        margin: const EdgeInsets.only(top: 16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: ExtendedImage.network(item.author.avatarUrl).image,
                        ),
                        Text(
                          '  ${item.author.login}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(' ·'),
                        Text(' ${$utils.formatTimesAgo(DateTime.parse(item.createdAt), DateTime.now())}'),
                      ],
                    ),
                  ),
                  PopupMenuButton(
                    itemBuilder: (context) {
                      return [const PopupMenuItem(child: Text('111'))];
                    },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(0),
                child: CustomMarkdownViewbox(data: item.body),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () async {
                      var prevReactions = item.reactionGroups.where((element) => element.viewerHasReacted).map((e) => e.content).toList();
                      ReactionContentEnum? newReaction = await showDialog(
                        context: context,
                        builder: (context) {
                          return _buildSelectEmojiDialog(context, prevReactions);
                        },
                      );
                      if (newReaction != null) {
                        var isAddReaction = !prevReactions.contains(newReaction);
                        updateReaction(isAddReaction, item.id, newReaction.content);
                      }
                    },
                    icon: const Icon(Icons.emoji_emotions_outlined),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ...item.reactionGroups.map((e) => _buildEmojiGroupItem(e, item.id)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmojiGroupItem(ReactionGroupModel group, String commentId) {
    return Visibility(
      visible: group.reactors.totalCount > 0,
      child: Padding(
        padding: const EdgeInsets.only(right: 4),
        child: GestureDetector(
          child: Chip(
            label: Text(
              '${group.reactors.totalCount}',
              style: TextStyle(color: group.viewerHasReacted ? Colors.purple : null, fontSize: 15),
            ),
            avatar: Text(
              emojiParser.emojify(':${group.content.name}:'),
              style: const TextStyle(
                fontSize: 17,
              ),
            ),
            labelPadding: const EdgeInsets.only(right: 8),
            shape: const StadiumBorder(side: BorderSide(color: Colors.transparent)),
            visualDensity: VisualDensity.compact,
            padding: const EdgeInsets.all(0),
            backgroundColor: group.viewerHasReacted ? Colors.purple.shade50.withOpacity(0.6) : Colors.grey.shade100,
          ),
          onTap: () {
            var nextReacted = !group.viewerHasReacted;
            updateReaction(nextReacted, commentId, group.content.content);
          },
        ),
      ),
    );
  }

  Widget _buildSelectEmojiDialog(BuildContext context, List<ReactionContentEnum> prevReactions) {
    return SimpleDialog(
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      children: [
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          children: [
            ...ReactionContentEnum.values.map((e) {
              var hasReacted = prevReactions.indexWhere((element) => element == e);
              return _buildEmojiSelectorItem(context, e, hasReacted != -1);
            }),
          ],
        ),
      ],
    );
  }

  Widget _buildEmojiSelectorItem(BuildContext context, ReactionContentEnum reaction, bool viewerHasReacted) {
    return SimpleDialogOption(
      padding: const EdgeInsets.all(0),
      child: GestureDetector(
        child: Chip(
          label: Text(
            emojiParser.emojify(emojiParser.emojify(':${reaction.name}:')),
            style: const TextStyle(
              fontSize: 30,
            ),
          ),
          shape: const StadiumBorder(side: BorderSide(color: Colors.transparent)),
          backgroundColor: viewerHasReacted ? Colors.purple.shade50 : Colors.white,
        ),
        onTap: () {
          Navigator.of(context).pop(reaction);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('issue详情'),
      ),
      body: Query(
        options: QueryOptions(
          document: gql(getInfo()),
          variables: {
            'owner': widget.user,
            'name': widget.repoName,
            'number': widget.issueNumber,
          },
          parserFn: (data) {
            var parsedData = IssueModel.fromJson(data['repository']['issue']);
            return parsedData;
          },
        ),
        builder: (result, {fetchMore, refetch}) {
          if (result.isLoading && _isFirstlyFetch) {
            return _buildPageLoading();
          }
          if (result.hasException) {
            var message = result.exception?.graphqlErrors.firstOrNull?.message ?? '';
            return _buildPageException(message);
          }
          _refetch = refetch;
          _issueInfo = result.parsedData!;

          return _buildPageContent();
        },
      ),
    );
  }
}
