import 'package:github/models/blob_model/blob_model.dart';
import 'package:github/models/commit_model/commit_model.dart';
import 'package:github/models/tag_model/tag_model.dart';
import 'package:github/models/tree_model/tree_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'git_object_interface.g.dart';

/// https://docs.github.com/zh/graphql/reference/interfaces#gitobject
@JsonSerializable(
  explicitToJson: true,
)
class GitObjectInterface {
  const GitObjectInterface({
    this.id = '',
    this.oid = '',
    this.commitUrl = '',

    this.text = '',
    this.byteSize = 0,
  });

  final String id;
  final String oid;
  final String commitUrl;

  /// [BlobModel]

  final String text;
  final int byteSize;

  /// [CommitModel]

  /// [TagModel]

  /// [TreeModel]

  factory GitObjectInterface.fromJson(json) {
    return _$GitObjectInterfaceFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$GitObjectInterfaceToJson(this);
  }
}