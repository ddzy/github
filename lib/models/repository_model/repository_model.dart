import 'package:github/interfaces/git_object_interface.dart';
import 'package:github/models/language_model/language_model.dart';
import 'package:github/models/ref_model/ref_model.dart';
import 'package:github/models/repository_model/repository_discussions_connection.dart';
import 'package:github/models/repository_model/repository_issues_connection.dart';
import 'package:github/models/repository_model/repository_owner_interface.dart';
import 'package:github/models/repository_model/repository_prs_connection.dart';
import 'package:github/models/repository_model/repository_refs_connection.dart';
import 'package:json_annotation/json_annotation.dart';

part 'repository_model.g.dart';
 
/// [RepositoryModel] https://docs.github.com/zh/graphql/reference/objects#repository
@JsonSerializable(explicitToJson: true)
class RepositoryModel {
  const RepositoryModel({
    this.id = '',
    this.name = '',
    this.description = '',
    this.descriptionHTML = '',
    this.stargazerCount = 0,
    this.forkCount = 0,
    this.homepageUrl = '',
    this.viewerHasStarred = false,
    this.owner = const RepositoryOwnerInterface(
    ),
    this.object = const GitObjectInterface(),
    this.primaryLanguage = const LanguageModel(),
    this.defaultBranchRef = const RefModel(),
    this.ref = const RefModel(),
    this.issues = const RepositoryIssuesConnection(),
    this.pullRequests = const RepositoryPrsConnection(),
    this.discussions = const RepositoryDiscussionsConnection(),
    this.refs = const RepositoryRefsConnection(),
  });

  final String id;
  final String name;
  final String description;
  final String descriptionHTML;
  final int stargazerCount;
  final int forkCount;
  final String homepageUrl;
  final bool viewerHasStarred;
  final RepositoryOwnerInterface owner;
  final GitObjectInterface object;
  final LanguageModel primaryLanguage;
  final RefModel defaultBranchRef;
  final RefModel ref;
  final RepositoryIssuesConnection issues;
  final RepositoryPrsConnection pullRequests;
  final RepositoryDiscussionsConnection discussions;
  final RepositoryRefsConnection refs;

  factory RepositoryModel.fromJson(json) {
    return _$RepositoryModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$RepositoryModelToJson(this);
  }
}

