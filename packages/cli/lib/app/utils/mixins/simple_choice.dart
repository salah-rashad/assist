// import 'package:assist/app/utils/extensions.dart';
//
// mixin SimpleChoice<T> on Enum {
//   String get name => toString().split('.').last;
//   String? get description => null;
//   T get value;
//
//   SimpleChoice? get defaultChoice;
//
//   bool get isDefault => defaultChoice == this;
//
//   String toChoice() => generateChoice(name, description, isDefault);
//
//   static String generateChoice(
//     String name, [
//     String? description,
//     bool isDefault = false,
//   ]) {
//     final sb = StringBuffer();
//     final star = (isDefault ? ' * ' : '');
//     String choice = (name + star);
//     if (description != null) {
//       choice = choice.padRight(20);
//     }
//     sb.write(choice);
//     if (description != null) {
//       sb.write(description);
//     }
//     final line = sb.toString();
//     return line.truncateChoice();
//   }
// }
