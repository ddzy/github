part of 'issue.dart';

enum IssueFilterViaStatesEnum {
  all('所有', 'all'),
  open('已激活', 'OPEN'),
  closed('已关闭', 'CLOSED');

  const IssueFilterViaStatesEnum(this.label, this.value);

  final String label;
  final String value;
}

enum IssueFilterViaOrderByEnum {
  createdAtDesc('最新', 'CREATED_AT.DESC'),
  createdAtAsc('最早', 'CREATED_AT.ASC'),
  commentsDesc('最多评论', 'COMMENTS.DESC'),
  commentsAsc('最少评论', 'COMMENTS.ASC'),
  updatedAtDesc('近期更新内容', 'UPDATED_AT.DESC'),
  updatedAtAsc('最近最少更新', 'UPDATED_AT.ASC'),
  ;

  const IssueFilterViaOrderByEnum(this.label, this.value);

  final String label;
  final String value;
}

enum IssueFilterViaFiltersEnum {
  createdBy('已创建', 'createdBy'),
  assignee('已分配', 'assignee'),
  mentioned('已提及', 'mentioned'),
  viewerSubscribed('相关', 'viewerSubscribed'),
  ;

  const IssueFilterViaFiltersEnum(this.label, this.value);
  final String label;
  final String value;
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
    return _map;
  }
}

class IssueFilterViaOrderBy {
  const IssueFilterViaOrderBy({
    this.direction,
    this.field,
  });

  final String? direction;
  final String? field;

  Map<String, dynamic> toJson() {
    return {
      'direction': direction,
      'field': field,
    };
  }
}

class IssueFilter {
  IssueFilter({
    this.states,
    this.orderBy,
    this.filterBy,
  });

  List<IssueFilterViaStatesEnum>? states;
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
