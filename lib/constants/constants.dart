class IGithubConfigInterface {
  /// personal access token
  final String accessToken = '';

  final String baseApiUrl = 'https://api.github.com';

  final String apiVersion = '2022-11-28';
}

class IStorageTokenInterface {
  final String githubAccessToken = '__github_access_token__';
  final String userLoginToken = '__user_login__';
  final String userAvatarUrlToken = '__user_avatar_url__';
  final String userIdToken = '__user_id__';
}

class $IConstantsInterface {
  final IGithubConfigInterface githubConfig = IGithubConfigInterface();
  final IStorageTokenInterface storageToken = IStorageTokenInterface();
}

var $constants = $IConstantsInterface();
