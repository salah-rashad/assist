import 'package:assist_gui/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:url_launcher/url_launcher.dart';

class PackageLinksBar extends StatelessWidget {
  const PackageLinksBar({super.key});

  @override
  Widget build(BuildContext context) {
    final project = context.project;
    final name = project.pubspec.name;
    final repository = project.pubspec.repository;
    final homepage = Uri.tryParse(project.pubspec.homepage?.trim() ?? "");
    final documentation = Uri.tryParse(
      project.pubspec.documentation?.trim() ?? "",
    );
    final pubDev =
        name.trim().isEmpty
            ? null
            : Uri(
              scheme: "https",
              host: "pub.dev",
              path: "/packages/${project.pubspec.name}",
            );

    final repositoryData = switch (homepage?.host) {
      "github.com" => (LucideIcons.github, 'GitHub'),
      "gitlab.com" => (LucideIcons.gitlab, 'GitLab'),
      _ => (LucideIcons.box, 'Repository'),
    };
    return Wrap(
      spacing: 0.0,
      runSpacing: 0.0,
      children: [
        _buildLinkItem(
          icon: repositoryData.$1,
          label: repositoryData.$2,
          uri: repository,
        ),
        _buildLinkItem(
          icon: LucideIcons.globe,
          label: "Homepage",
          uri: homepage,
        ),
        _buildLinkItem(
          icon: LucideIcons.book,
          label: "Documentation",
          uri: documentation,
        ),
        _buildLinkItem(
          icon: LucideIcons.package,
          label: "Pub.dev",
          uri: pubDev,
        ),
      ],
    );
  }

  Widget _buildLinkItem({
    required IconData icon,
    required String label,
    required Uri? uri,
  }) {
    if (uri == null || uri.toString().isEmpty) {
      return SizedBox.shrink();
    }
    return FutureBuilder(
      future: canLaunchUrl(uri),
      builder: (context, snapshot) {
        return ShadButton.outline(
          enabled: snapshot.data == true,
          leading: Icon(icon),
          padding: EdgeInsets.symmetric(horizontal: 8),
          size: ShadButtonSize.sm,
          child: Text(label),
          onPressed: () => launchUrl(uri),
        );
      },
    );
  }
}
