class IGithubConfigInterface {
  final String clientId = '718ba9b0d30af49ef1f1';

  /// Github OAuth 生成
  final String clientSecret = 'd032c71124efc81ce1c3d0d548ae1e68db3c2045';

  /// personal access token
  final String accessToken = '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';

  final String baseApiUrl = 'https://api.github.com';

  final String apiVersion = '2022-11-28';
}

class IStorageTokenInterface {
  final String githubAccessToken = '__github_access_token__';
}

class $IConstantsInterface {
  final IGithubConfigInterface githubConfig = IGithubConfigInterface();
  final IStorageTokenInterface storageToken = IStorageTokenInterface();
}

var $constants = $IConstantsInterface();
