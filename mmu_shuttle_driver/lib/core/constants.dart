import 'package:flutter_dotenv/flutter_dotenv.dart';

const DEFAULT_ERROR_MESSAGE = "Error Occured";
final API_URL = dotenv.env['API_URL'] ?? '';
final WEB_SOCKET_URL = dotenv.env['WEB_SOCKET_URL'] ?? '';
const CACHED_ACCESS_TOKEN_KEY = "cached_access_token";
const CACHED_EMAIL = "cached_email";
const CACHED_PASSWORD = "cached_password";
const SESSION_EXPIRED_MESSAGE = 'Your session has expired. Please sign in again.';