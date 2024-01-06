import 'package:github/models/language_model/language_model.dart';
import 'package:github/models/repository_model/repository_owner_interface.dart';
import 'package:json_annotation/json_annotation.dart';

part 'repository_model.g.dart';
 
/// [RepositoryModel] https://docs.github.com/zh/graphql/reference/objects#repository
@JsonSerializable(explicitToJson: true)
class RepositoryModel {
  RepositoryModel({
    this.id = '',
    this.name = '',
    this.description = '',
    this.descriptionHTML = '',
    this.stargazerCount = 0,
    this.owner = const RepositoryOwnerInterface(
    ),
    this.primaryLanguage = const LanguageModel(),
  });

  final String id;
  final String name;
  final String description;
  final String descriptionHTML;
  final int stargazerCount;
  final RepositoryOwnerInterface owner;
  final LanguageModel primaryLanguage;

  factory RepositoryModel.fromJson(json) {
    return _$RepositoryModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$RepositoryModelToJson(this);
  }
}

