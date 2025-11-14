import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/constants/content.dart';

// Footer uses centralized content constants for texts and social links

class Footer extends StatelessWidget {
  final Function(String) onLaunchURL;

  const Footer({super.key, required this.onLaunchURL});

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
          const SizedBox(height: 10),
          Semantics(
            label: 'Social Links',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => onLaunchURL(socialLinks['github'] ?? ''),
                  icon: FaIcon(FontAwesomeIcons.github, size: 20),
                  tooltip: githubTooltip,
                ),
                IconButton(
                  onPressed: () => onLaunchURL(socialLinks['linkedin'] ?? ''),
                  icon: FaIcon(FontAwesomeIcons.linkedin, size: 20),
                  tooltip: linkedinTooltip,
                ),
                IconButton(
                  onPressed: () => onLaunchURL(socialLinks['email'] ?? ''),
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