import 'package:github/models/language_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'repository_model.g.dart';
 
/// [RepositoryModel] https://docs.github.com/zh/graphql/reference/objects#repository
@JsonSerializable(explicitToJson: true)
class RepositoryModel {
  RepositoryModel({
    this.id = '',
    this.name = '',
    this.description = '',
    this.stargazerCount = 0,
    this.owner = const RepositoryOwnerModel(
    ),
    this.primaryLanguage = const LanguageModel(),
  });

  final String id;
  final String name;
  final String description;
  final int stargazerCount;
  final RepositoryOwnerModel owner;
  final LanguageModel primaryLanguage;

  factory RepositoryModel.fromJson(json) {
    return _$RepositoryModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$RepositoryModelToJson(this);
  }
}

@JsonSerializable(
  explicitToJson: true,
)
class RepositoryOwnerModel {
  const RepositoryOwnerModel({
    this.id = '',
    this.name = '',
    this.avatarUrl = '',
    this.login = '',
  });

  final String id;
  final String name;
  final String avatarUrl;
  final String login;

  factory RepositoryOwnerModel.fromJson(json) {
    return _$RepositoryOwnerModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$RepositoryOwnerModelToJson(this);
  }
}
