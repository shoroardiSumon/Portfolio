import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/constants/content.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:url_launcher/url_launcher.dart';

import '../scroll_controller_inherited.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollControllerInherited.of(context)!;
    final isMobile = MediaQuery.sizeOf(context).width < 600;

    return AutoScrollTag(
      key: const ValueKey('about'),
      controller: scrollController,
      index: 1,
      highlightColor: Colors.transparent,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                    Semantics(
                      label: aboutTitle,
                      child: Text(
                        aboutTitle,
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                const SizedBox(height: 20),
                isMobile ? _buildMobileContent(context) : _buildDesktopContent(context),
              ],
            ),
          );
        },
      ),
    ).animate().slideX(begin: -0.3, end: 0.0, duration: const Duration(milliseconds: 800), curve: Curves.easeOut);
  }

  Widget _buildMobileContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: _buildSummaryText(context),
        ),
        const SizedBox(height: 20),
        _buildContactInfo(context),
        const SizedBox(height: 12),
        _buildSocialIcons(context),
      ],
    );
  }

  Widget _buildDesktopContent(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSummaryText(context),
              const SizedBox(height: 20),
              _buildContactInfo(context),
              const SizedBox(height: 12),
              _buildSocialIcons(context),
            ],
          ),
        ),
        const SizedBox(width: 40),
        Expanded(flex: 1, child: _buildInfoCards(context)),
      ],
    );
  }

  // removed profile photo here (moved to Home section). Provide info cards instead.
  Widget _buildInfoCards(BuildContext context) {
    return Column(
      children: [
        _buildCard(context, 'Experience', stats['experience'] as String, Icons.work),
        const SizedBox(height: 14),
        _buildCard(context, 'Projects', stats['projects'] as String, Icons.folder),
        const SizedBox(height: 14),
        _buildCard(context, 'Primary', stats['primary'] as String, Icons.code),
        const SizedBox(height: 14),
        _buildCard(context, 'Secondary', stats['secondary'] as String, Icons.code),
      ],
    );
  }

  Widget _buildCard(BuildContext context, String title, String subtitle, IconData icon) {
    final bg = Theme.of(context).colorScheme.onSurface.withOpacity(0.06);
    final titleStyle = Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700);
    final subStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.9));

    return Material(
      color: Colors.transparent,
      child: Ink(
        width: 200,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(14),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: null,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: Theme.of(context).colorScheme.primary),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: titleStyle),
                      const SizedBox(height: 6),
                      Text(subtitle, style: subStyle),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryText(BuildContext context) {
    return Semantics(
      label: 'Professional Summary',
      child: Container(
        constraints: const BoxConstraints(maxWidth: 900),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: aboutParagraphs
              .map((p) => Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Text(p, style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.6, fontSize: 16), textAlign: TextAlign.justify),
                  ))
              .toList(),
        ),
      ),
    );
  }

  Widget _buildContactInfo(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyMedium;
    final iconColor = Theme.of(context).colorScheme.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
            Text(contactInfoTitle, textAlign: TextAlign.left, style: textStyle),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.location_on, size: 18, color: iconColor),
                  const SizedBox(width: 8),
                  Expanded(
                        child: Text(contactInfo['address'] ?? '', style: textStyle),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.phone, size: 18, color: iconColor),
                  const SizedBox(width: 8),
                      SelectableText(contactInfo['phone'] ?? '', style: textStyle),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.email, size: 18, color: iconColor),
                  const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () => launchUrl(Uri.parse(socialLinks['email'] ?? 'mailto:')),
                        child: SelectableText(contactInfo['email'] ?? '', style: textStyle),
                      ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSocialIcons(BuildContext context) {
    return Semantics(
      label: 'Social Media Links',
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
              IconButton(
                onPressed: () => launchUrl(Uri.parse(socialLinks['linkedin'] ?? '')),
                icon: FaIcon(FontAwesomeIcons.linkedin, color: Theme.of(context).colorScheme.primary),
                tooltip: linkedinTooltip,
              ),
              IconButton(
                onPressed: () => launchUrl(Uri.parse(socialLinks['github'] ?? '')),
                icon: FaIcon(FontAwesomeIcons.github, color: Theme.of(context).colorScheme.primary),
                tooltip: githubTooltip,
              ),
              IconButton(
                onPressed: () => launchUrl(Uri.parse(socialLinks['email'] ?? 'mailto:')),
                icon: const Icon(Icons.email, color: Color(0xFFFF9800)),
                tooltip: sendEmailTooltip,
              ),
        ],
      ),
    );
  }
}