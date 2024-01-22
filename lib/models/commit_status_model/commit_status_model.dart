import 'package:json_annotation/json_annotation.dart';

part 'commit_status_model.g.dart';

enum ICommitStatusState {
  ERROR,
  EXPECTED,
  FAILURE,
  PENDING,
  SUCCESS,
}

@JsonSerializable(
  explicitToJson: true,
)
class CommitStatusModel {
  const CommitStatusModel({
    this.id = '',
    this.state = ICommitStatusState.EXPECTED,
  });

  final String id;
  final ICommitStatusState state;

  factory CommitStatusModel.fromJson(json) {
    return _$CommitStatusModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CommitStatusModelToJson(this);
  }
}
