import 'package:github/interfaces/git_object_interface.dart';
import 'package:github/models/language_model/language_model.dart';
import 'package:github/models/submodule_model/submodule_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tree_entry_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
)
class TreeEntryModel {
  const TreeEntryModel({
    this.oid = '',
    this.name = '',
    this.path = '',
    this.type = '',
    this.extension = '',
    this.size = 0,
    this.language = const LanguageModel(),
    this.submodule = const SubmoduleModel(),
    this.object = const GitObjectInterface(),
  });

  final String oid;
  final String name;
  final String path;
  /// [type] 文件类型
  /// [type] = tree(目录)
  /// [type] = blob(普通文件)
  final String type;
  final String extension;
  final int size;
  final LanguageModel language;
  final SubmoduleModel submodule;
  final GitObjectInterface object;

  factory TreeEntryModel.fromJson(json) {
    return _$TreeEntryModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$TreeEntryModelToJson(this);
  }
}
