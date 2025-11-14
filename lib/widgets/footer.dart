import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
              '© 2025 Md. Shoroardi Sumon — All Rights Reserved.',
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
                  onPressed: () => onLaunchURL('https://github.com/shoroardiSumon'),
                  icon: FaIcon(FontAwesomeIcons.github, size: 20),
                  tooltip: 'GitHub Profile',
                ),
                IconButton(
                  onPressed: () => onLaunchURL('https://www.linkedin.com/in/md-shoroardi-sumon-a00a1a184/'),
                  icon: FaIcon(FontAwesomeIcons.linkedin, size: 20),
                  tooltip: 'LinkedIn Profile',
                ),
                IconButton(
                  onPressed: () => onLaunchURL('mailto:shoroardi.sumon@gmail.com'),
                  icon: const Icon(Icons.email),
                  tooltip: 'Send Email',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}