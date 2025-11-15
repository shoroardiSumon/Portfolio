import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:portfolio/constants/content.dart';

// Footer uses centralized content constants for texts and social links

class Footer extends StatefulWidget {
  final Function(String) onLaunchURL;

  const Footer({super.key, required this.onLaunchURL});

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  String _version = '';

  @override
  void initState() {
    super.initState();
    _loadVersion();
  }

  Future<void> _loadVersion() async {
    try {
      final info = await PackageInfo.fromPlatform();
      setState(() {
        _version = '${info.version}+${info.buildNumber}';
      });
    } catch (_) {
      // ignore and leave version empty
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withOpacity(0.04),
        border: Border(
          top: BorderSide(color: Theme.of(context).colorScheme.primary.withOpacity(0.06)),
        ),
      ),
      child: Column(
        children: [
          Semantics(
            label: 'Copyright Notice',
            child: Text(
              footerCopyright,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          if (_version.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text('Version: $_version', style: Theme.of(context).textTheme.bodySmall),
          ],
          const SizedBox(height: 10),
          Semantics(
            label: 'Social Links',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => widget.onLaunchURL(socialLinks['github'] ?? ''),
                  icon: FaIcon(FontAwesomeIcons.github, size: 20),
                  tooltip: githubTooltip,
                ),
                IconButton(
                  onPressed: () => widget.onLaunchURL(socialLinks['linkedin'] ?? ''),
                  icon: FaIcon(FontAwesomeIcons.linkedin, size: 20),
                  tooltip: linkedinTooltip,
                ),
                IconButton(
                  onPressed: () => widget.onLaunchURL(socialLinks['email'] ?? ''),
                  icon: const Icon(Icons.email),
                  tooltip: sendEmailTooltip,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}