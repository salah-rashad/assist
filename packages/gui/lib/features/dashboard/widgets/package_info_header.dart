import 'package:assist_core/assist_core.dart';
import 'package:assist_gui/core/utils/extensions.dart';
import 'package:assist_gui/shared/widgets/link_text/link_text.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../shared/widgets/version_badge.dart';

class PackageInfoHeader extends StatelessWidget {
  const PackageInfoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final path = context.project.path;
    final pubspec = context.pubspec;
    return Column(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildNameWithVersion(pubspec, context),
        buildPathLink(path, context),
      ],
    );
  }

  Text buildNameWithVersion(Pubspec pubspec, BuildContext context) {
    return Text.rich(
      TextSpan(
        text: pubspec.name,
        style: context.textTheme.h2,
        children: [
          WidgetSpan(
            child: Padding(
              padding: const EdgeInsetsDirectional.only(start: 8.0),
              child: Builder(
                builder: (_) {
                  final version = pubspec.version;
                  if (version == null) return SizedBox.shrink();
                  return VersionBadge(version: version);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  LinkText buildPathLink(String path, BuildContext context) {
    return LinkText(
      path,
      icon: Icon(LucideIcons.folderUp),
      onTap: () => launchUrlString("file://$path"),
      style: context.textTheme.muted,
    );
  }
}
