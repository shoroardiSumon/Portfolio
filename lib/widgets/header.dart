import 'package:flutter/material.dart';
import 'package:portfolio/constants/content.dart';

class Header extends StatelessWidget {
  final Function(String) onScrollTo;

  const Header({
    super.key,
    required this.onScrollTo,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 700;

    if (isMobile) {
      // Compact mobile header: menu button + small center logo
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Row(
            children: [
              // Menu button opens bottom sheet with navigation
              IconButton(
                icon: Icon(Icons.menu, color: Theme.of(context).colorScheme.onSurface),
                onPressed: () => _openMobileMenu(context),
                tooltip: openNavigationTooltip,
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => onScrollTo('home'),
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(color: Theme.of(context).shadowColor.withOpacity(0.25), blurRadius: 6),
                    ],
                  ),
                  child: const Center(child: Icon(Icons.home, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Desktop / wide layout: centered pill nav
    return SafeArea(
      child: Semantics(
        label: 'Navigation Header',
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.55,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(40),
              border: Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.06)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // left nav group (3 before the logo)
                _buildNavButton(navLabels['about'] ?? 'About', 'about', onScrollTo),
                _buildNavButton(navLabels['skills'] ?? 'Skills', 'skills', onScrollTo),
                _buildNavButton(navLabels['projects'] ?? 'Projects', 'projects', onScrollTo),
                const SizedBox(width: 8),
                // logo in middle
                GestureDetector(
                  onTap: () => onScrollTo('home'),
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(color: Theme.of(context).shadowColor.withOpacity(0.25), blurRadius: 6),
                      ],
                    ),
                    child: const Center(
                      // Use Home icon as the center logo
                      child: Icon(Icons.home, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // right nav group
                _buildNavButton(navLabels['experience'] ?? 'Experience', 'experience', onScrollTo),
                _buildNavButton(navLabels['education'] ?? 'Education', 'education', onScrollTo),
                _buildNavButton(navLabels['contact'] ?? 'Contact', 'contact', onScrollTo),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavButton(String label, String tag, Function(String) onScrollTo) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: TextButton(
          onPressed: () => onScrollTo(tag),
          child: Text(label),
        ),
      ),
    );
  }

  void _openMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(navLabels['about'] ?? 'About'),
                onTap: () {
                  Navigator.of(ctx).pop();
                  onScrollTo('about');
                },
              ),
              ListTile(
                title: Text(navLabels['skills'] ?? 'Skills'),
                onTap: () {
                  Navigator.of(ctx).pop();
                  onScrollTo('skills');
                },
              ),
              ListTile(
                title: Text(navLabels['projects'] ?? 'Projects'),
                onTap: () {
                  Navigator.of(ctx).pop();
                  onScrollTo('projects');
                },
              ),
              ListTile(
                title: Text(navLabels['experience'] ?? 'Experience'),
                onTap: () {
                  Navigator.of(ctx).pop();
                  onScrollTo('experience');
                },
              ),
              ListTile(
                title: Text(navLabels['education'] ?? 'Education'),
                onTap: () {
                  Navigator.of(ctx).pop();
                  onScrollTo('education');
                },
              ),
              ListTile(
                title: Text(navLabels['contact'] ?? 'Contact'),
                onTap: () {
                  Navigator.of(ctx).pop();
                  onScrollTo('contact');
                },
              ),
            ],
          ),
        );
      },
    );
  }
}