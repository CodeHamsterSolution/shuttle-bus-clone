class TokenManager {
  static String? _accessToken;

  static void updateToken(String? accessToken) {
    _accessToken = accessToken;
  }

  static String? get accessToken => _accessToken;
}
