import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/constants/content.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../scroll_controller_inherited.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
  // Use centralized experiences from constants (top-level `experiences`)

    final scrollController = ScrollControllerInherited.of(context)!;

    return AutoScrollTag(
      key: const ValueKey('experience'),
      controller: scrollController,
      index: 4,
      highlightColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Semantics(
              label: experienceTitle,
              child: Text(
                experienceTitle,
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            ...experiences.map((exp) => _buildExperienceCard(context, exp)),
          ],
        ),
      ),
    ).animate().slideX(begin: -0.3, end: 0.0, duration: const Duration(milliseconds: 800), curve: Curves.easeOut);
  }

  Widget _buildExperienceCard(BuildContext context, Map<String, dynamic> exp) {
    return Animate(
      effects: const [FadeEffect()],
      child: Card(
        margin: const EdgeInsets.only(bottom: 20),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      exp['company'],
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    exp['duration'],
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Semantics(
                label: exp['role'],
                child: Text(
                  exp['role'],
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              const SizedBox(height: 10),
              ...exp['description'].map<Widget>(
                (desc) => Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.arrow_right, size: 16, color: Theme.of(context).primaryColor),
                      const SizedBox(width: 10),
                      Expanded(child: Text(desc)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}