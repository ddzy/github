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

enum IssueFilterViaFiltersKey {
  createdBy('已创建', 'createdBy'),
  assignee('已分配', 'assignee'),
  mentioned('已提及', 'mentioned'),
  viewerSubscribed('相关', 'viewerSubscribed'),
  ;

  const IssueFilterViaFiltersKey(this.label, this.value);
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

class IssueFilterViaFilters {
  IssueFilterViaFilters();

  final Map<String, dynamic> _map = {
    'assignee': null,
    'createdBy': null,
    'mentioned': null,
    'viewerSubscribed': null,
  };

  IssueFilterViaFilters setValue(String key, dynamic value) {
    _map[key] = value;
    return this;
  }

  Map<String, dynamic> toJson() {
    inspect(_map.keys);
    return _map;
  }
}

class IssueFilter {
  IssueFilter({
    this.states,
    this.orderBy,
    this.filterBy,
  });

  List<IssueFilterViaStates>? states;
  IssueFilterViaOrderBy? orderBy;
  IssueFilterViaFilters? filterBy;

  Map<String, dynamic> toJson() {
    return {
      'states': states?.map((e) => e.value).toList(),
      'orderBy': orderBy?.toJson(),
      'filterBy': filterBy?.toJson(),
    };
  }
}
