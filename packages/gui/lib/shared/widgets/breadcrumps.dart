import 'package:assist_gui/app/routing/route_names.dart';
import 'package:assist_gui/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart' as p;

class Breadcrumbs extends StatelessWidget {
  const Breadcrumbs({super.key});

  @override
  Widget build(BuildContext context) {
    final currentLocation = GoRouterState.of(context).fullPath ?? '/';
    final segments = p.split(currentLocation)..removeAt(0);
    return BreadCrumb.builder(
      itemCount: segments.length,
      builder: (i) {
        // final isFirst = i == 0;
        final isLast = i == segments.length - 1;

        final path = '/${segments.sublist(0, i + 1).join('/')}';

        return BreadCrumbItem(
          onTap: isLast ? null : () => context.go(path),
          color: Colors.transparent,
          textColor: context.colorScheme.primary,
          disabledTextColor: context.colorScheme.mutedForeground,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          splashColor: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(99)),
          content: Text(RouteNames.toTitleCase(segments[i])),
        );
      },
      divider: Text(
        '   ›   ',
        style: TextStyle(
          color: context.colorScheme.mutedForeground.withValues(alpha: 0.5),
        ),
      ),
    );
  }
}
