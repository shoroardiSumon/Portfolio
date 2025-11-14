import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_animate/flutter_animate.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:url_launcher/url_launcher.dart';

import '../scroll_controller_inherited.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final projects = <Map<String, dynamic>>[
      {
        'name': 'My Bitcoin Canvas App',
        'description': 'A canvas-based Bitcoin tracking app with real-time updates.',
        'technologies': 'Flutter, Dart, REST API',
        'link': 'https://apps.apple.com/us/app/my-bitcoin-canvas/id6740707716',
        'image': 'assets/images/my-bitcoin-canvas.png',
      },
      {
        'name': 'Be Thankful E-commerce App',
        'description': 'Full-featured e-commerce app with payment integration.',
        'technologies': 'Flutter, Stripe, Firebase',
        'link': 'https://play.google.com/store/apps/details?id=com.tariqdesignloops.bethankful',
        'image': 'assets/images/be-thankful.png',
      },
      {
        'name': 'Be Thankful Driver App',
        'description': 'Full-featured driver app for order delivery management.',
        'technologies': 'Flutter, Firebase',
        'link': 'https://play.google.com/store/apps/details?id=com.tariqdesignloops.bethankfuldriver',
        'image': 'assets/images/be-thankful-driver.png',
      },
      {
        'name': 'BPDB Prepaid App',
        'description': 'Internal app for electricity prepaid metering.',
        'technologies': 'Flutter, Spring Boot',
        'link': null,
        'image': 'assets/images/bpdb-prepaid.png',
      },
      {
        'name': 'BPDB FDM App',
        'description': 'Fault detection and management internal app.',
        'technologies': 'Flutter, REST API',
        'link': null,
        'image': 'assets/images/bpdb-prepaid.png',
      },
      {
        'name': 'AmarBoard App',
        'description': 'E-learning app built with Flutter & Dart.',
        'technologies': 'Flutter, Dart, Firebase',
        'link': 'https://play.google.com/store/apps/details?id=com.bd.amarboard',
        'image': 'assets/images/amarboard.jpg',
      },
      {
        'name': 'HR Management App',
        'description': 'Internal HR system for employee management.',
        'technologies': 'Flutter, Spring Boot',
        'link': null,
        'image': 'assets/images/nexahr.png',
      },
    ];

    final crossAxisCount = MediaQuery.sizeOf(context).width > 1200
        ? 3
        : MediaQuery.sizeOf(context).width > 800
            ? 2
            : 1;

    final scrollController = ScrollControllerInherited.of(context)!;
    return AutoScrollTag(
      key: const ValueKey('projects'),
      controller: scrollController,
      index: 3,
      highlightColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Semantics(
              label: 'Projects Section Title',
              child: Text(
                'Projects',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            FutureBuilder<List<String>>(
              future: _resolveProjectImages(context, projects),
              builder: (context, snap) {
                final resolved = snap.data;
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    childAspectRatio: crossAxisCount == 1 ? 3 / 2 : 4 / 3,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  itemCount: projects.length,
                  itemBuilder: (context, index) => _buildProjectCard(context, projects[index], index, resolved == null ? null : resolved[index]),
                );
              },
            ),
          ],
        ),
      ),
    ).animate().slideY(begin: 0.3, end: 0.0, duration: const Duration(milliseconds: 800), curve: Curves.easeOut);
  }

  Widget _buildProjectCard(BuildContext context, Map<String, dynamic> project, int index, String? resolvedImage) {
    return Animate(
      effects: [FadeEffect(delay: Duration(milliseconds: 200 * index))],
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: project['link'] != null ? () => launchUrl(Uri.parse(project['link'])) : null,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: AssetImage(resolvedImage ?? project['image'] ?? 'assets/images/placeholder.jpg'),
                        fit: BoxFit.fill,
                      ),
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Semantics(
                  label: project['name'],
                  child: Text(
                    project['name'],
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  project['description'],
                  style: Theme.of(context).textTheme.bodySmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                Text(
                  'Technologies: ${project['technologies']}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).primaryColor),
                ),
                if (project['link'] != null) ...[
                  const SizedBox(height: 10),
                  TextButton.icon(
                    onPressed: () => launchUrl(Uri.parse(project['link'])),
                    icon: const Icon(Icons.open_in_new, size: 16),
                    label: const Text('View on Store'),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<List<String>> _resolveProjectImages(BuildContext context, List<Map<String, dynamic>> projects) async {
    // For each project try, in order:
    // 1) explicit project['image'] if provided
    // 2) slugified project name with common extensions (.jpg, .png)
    // 3) fallback to placeholder
    final List<String> results = [];
    for (final p in projects) {
      String? chosen;
      final explicit = (p['image'] as String?);
      if (explicit != null && explicit.isNotEmpty) {
        // Try explicit first
        try {
          await rootBundle.load(explicit);
          chosen = explicit;
        } catch (_) {
          chosen = null;
        }
      }

      if (chosen == null) {
        final name = (p['name'] as String?) ?? '';
        final slug = _slugify(name);
        final candidates = ['assets/images/$slug.jpg', 'assets/images/$slug.png'];
        for (final c in candidates) {
          try {
            await rootBundle.load(c);
            chosen = c;
            break;
          } catch (_) {
            // continue
          }
        }
      }

      chosen ??= 'assets/images/placeholder.jpg';
      results.add(chosen);
    }

    return results;
  }

  String _slugify(String input) {
    final lower = input.toLowerCase();
    // replace non-alphanumeric with underscore
    final replaced = lower.replaceAll(RegExp(r"[^a-z0-9]+"), '_');
    // collapse multiple underscores
    final collapsed = replaced.replaceAll(RegExp(r"_+"), '_');
    // trim leading/trailing underscores
    return collapsed.replaceAll(RegExp(r"^_|_\$"), '');
  }
}