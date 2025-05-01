/// Core library for the Assist package
library;

import 'package:assist_core/services/service.secure_storage.dart';
import 'package:github/github.dart';

export 'package:github/github.dart' show CurrentUser;

GitHub get github {
  final token = SecureStorageManager.getToken();
  return GitHub(auth: Authentication.withToken(token));
}
