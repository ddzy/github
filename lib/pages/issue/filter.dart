part of 'issue.dart';

enum IssueFilterViaStates {
  all('所有', 'all'),
  open('已激活', 'OPEN'),
  closed('已关闭', 'CLOSED');

  const IssueFilterViaStates(this.label, this.value);

  final String label;
  final String value;
}

enum IssueFilterViaOrderByDirection {
  asc('最早', 'ASC'),
  desc('最新', 'DESC');

  const IssueFilterViaOrderByDirection(this.label, this.value);

  final String label;
  final String value;
}

enum IssueFilterViaOrderByField {
  comments('评论数', 'COMMENTS'),
  createdAt('创建时间', 'CREATED_AT'),
  updatedAt('更新时间', 'UPDATED_AT');

  const IssueFilterViaOrderByField(this.label, this.value);

  final String label;
  final String value;
}

class IssueFilterViaOrderBy {
  const IssueFilterViaOrderBy({
    this.direction,
    this.field,
  });

  final IssueFilterViaOrderByDirection? direction;
  final IssueFilterViaOrderByField? field;

  Map<String, dynamic> toJson() {
    return {
      'direction': direction?.value,
      'field': field?.value,
    };
  }
}

class IssueFilter {
  IssueFilter({
    this.states,
    this.orderBy,
  });

  List<IssueFilterViaStates>? states;
  IssueFilterViaOrderBy? orderBy;

  Map<String, dynamic> toJson() {
    return {
      'states': states?.map((e) => e.value).toList(),
      'orderBy': orderBy?.toJson(),
    };
  }
}
