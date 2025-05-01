/// Core library for the Assist package
library;

import 'package:assist_core/services/service.secure_storage.dart';
import 'package:github/github.dart';

export 'package:github/github.dart' show CurrentUser;
export 'package:pub_semver/pub_semver.dart' show Version;
export 'package:pubspec_parse/pubspec_parse.dart';

GitHub get github {
  final token = SecureStorageManager.getToken();
  return GitHub(auth: Authentication.withToken(token));
}
