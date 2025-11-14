import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/constants/content.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../scroll_controller_inherited.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
  // Use centralized skills groups from constants (`skillsGroups` in content.dart)
  // top-level `skillsGroups` will be referenced directly below

    final scrollController = ScrollControllerInherited.of(context)!;

    return AutoScrollTag(
      key: const ValueKey('skills'),
      controller: scrollController,
      index: 2,
      highlightColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Semantics(
              label: skillsTitle,
              child: Text(
                skillsTitle,
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            ...skillsGroups.entries.map(
              (group) => _buildSkillGroup(context, group.key, group.value),
            ),
          ],
        ),
      ),
    ).animate().slideX(begin: 0.3, end: 0.0, duration: const Duration(milliseconds: 800), curve: Curves.easeOut);
  }

  Widget _buildSkillGroup(BuildContext context, String title, List<String> skills) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).primaryColor,
                ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 5,
            children: skills
                .map(
                  (skill) => _buildSkillChip(context, skill),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillChip(BuildContext context, String skill) {
    return Animate(
      effects: const [FadeEffect(delay: Duration(milliseconds: 200))],
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {}, // Placeholder for skill detail
          child: Chip(
            label: Text(skill),
            backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
            side: BorderSide(color: Theme.of(context).primaryColor.withOpacity(0.3)),
          ),
        ),
      ),
    );
  }
}