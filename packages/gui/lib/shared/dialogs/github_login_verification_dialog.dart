import 'package:assist_gui/core/utils/extensions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:url_launcher/url_launcher.dart';

class GithubLoginVerificationDialog extends StatelessWidget {
  const GithubLoginVerificationDialog({
    super.key,
    required this.code,
    required this.verificationUri,
  });

  final String code;
  final String verificationUri;

  @override
  Widget build(BuildContext context) {
    return ShadDialog(
      title: const Text('Login with GitHub'),
      description: const Text(
        'Please visit the following URL and enter the code to complete the login process.',
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 16,
        children: [
          // clickable verification uri
          Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              SelectableText(
                code,
                style: context.textTheme.h1.apply(
                  color: context.colorScheme.secondaryForeground,
                ),
              ),
              ShadTooltip(
                builder: (context) => Text('Copy'),
                child: ShadIconButton.secondary(
                  icon: Icon(LucideIcons.copy),
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(text: code));
                    if (context.mounted) {
                      ShadToaster.of(
                        context,
                      ).show(ShadToast(title: Text('Copied to clipboard')));
                    }
                  },
                ),
              ),
            ],
          ),
          Text.rich(
            TextSpan(
              text: verificationUri,
              style: context.textTheme.large.apply(
                color: context.colorScheme.primary,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () => launchUrl(Uri.parse(verificationUri)),
            ),
          ),
        ],
      ),
    );
  }
}
