part of './repo.dart';

enum RepoFilterEntry {
  all('全部', true),
  isArchived('已存档', true),
  isFork('分支', true),
  visibilityPrivate('私人', RepoFilterVisibility.PRIVATE),
  visibilityPublic('公共', RepoFilterVisibility.PUBLIC),
  ;

  const RepoFilterEntry(this.label, this.value);
  final String label;
  final Object value;

  Map<String, dynamic> format() {
    switch (name) {
      case 'all':
        return {};
      case 'visibilityPrivate' || 'visibilityPublic':
        var name = (value as RepoFilterVisibility).name;
        return {
          'visibility': name,
        };
      default:
        Map<String, dynamic> res = {};
        res[name] = value;
        return res;
    }
  }
}

enum RepoFilterVisibility {
  INTERNAL,
  PRIVATE,
  PUBLIC,
}
