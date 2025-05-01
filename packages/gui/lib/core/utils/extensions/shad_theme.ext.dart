import 'package:shadcn_ui/shadcn_ui.dart';

extension ShadThemeExt on ShadThemeData {
  T? extension<T>() => extensions?.whereType<T>().firstOrNull;
}
