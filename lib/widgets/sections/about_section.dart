import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
                  label: 'About Section Title',
                  child: Text(
                    'About Me',
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
        _buildStatRow(context),
        const SizedBox(height: 18),
        _buildSkillsWrap(context),
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
        _buildCard(context, 'Experience', '3+ years', Icons.work),
        const SizedBox(height: 14),
        _buildCard(context, 'Projects', '7+ delivered', Icons.folder),
        const SizedBox(height: 14),
        _buildCard(context, 'Location', 'Dhaka, Bangladesh', Icons.location_on),
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

  Widget _buildStatRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStat(context, '3+', 'Years Experience'),
        _buildStat(context, '6+', 'Projects'),
        _buildStat(context, 'Flutter', 'Primary'),
      ],
    );
  }

  Widget _buildStat(BuildContext context, String big, String small) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(big, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, fontSize: 28)),
        const SizedBox(height: 6),
        Text(small, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }

  Widget _buildSkillsWrap(BuildContext context) {
    final skills = ['Flutter', 'Dart', 'Spring Boot', 'REST', 'Firebase', 'Git'];
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: skills
          .map((s) => Chip(
                label: Text(s, style: Theme.of(context).textTheme.bodySmall),
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.12)),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              ))
          .toList(),
    );
  }

  Widget _buildSummaryText(BuildContext context) {
    return Semantics(
      label: 'Professional Summary',
      child: Container(
        constraints: const BoxConstraints(maxWidth: 900),
        child: Text(
          'I am a Flutter Developer with 3 years of experience building fast, reliable, and visually polished applications for Android, iOS, and the web. I specialize in Flutter, Dart, Provider, Riverpod, and BLoC, and have delivered multiple production apps integrating real-time data, secure payments, authentication, and advanced UI/UX animations.\n\n'
          'I also work with Spring Boot to design high-performance REST APIs that follow clean architecture, scalable design patterns, and strong security practices. My focus is building seamless end-to-end experiences where frontend and backend work together smoothly.\n\n'
          'To stay efficient and modern, I actively use AI-assisted development tools such as GitHub Copilot and Claude Code, which help me speed up development, maintain clean code, and solve complex engineering problems more effectively.\n\n'
          'I enjoy working in Agile/Scrum environments, collaborating with teams, and building solutions that solve real business problems with clean, maintainable code.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.6, fontSize: 16),
          textAlign: TextAlign.justify,
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
        Text('Contact Information', textAlign: TextAlign.left, style: textStyle),
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
                    child: Text('House 11, Road 12, North Badda, Dhaka 1212, Bangladesh', style: textStyle),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.phone, size: 18, color: iconColor),
                  const SizedBox(width: 8),
                  SelectableText('+8801776954809', style: textStyle),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.email, size: 18, color: iconColor),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () => launchUrl(Uri.parse('mailto:shoroardi.sumon@gmail.com')),
                    child: SelectableText('shoroardi.sumon@gmail.com', style: textStyle),
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
            onPressed: () => launchUrl(Uri.parse('https://www.linkedin.com/in/md-shoroardi-sumon-a00a1a184/')),
            icon: FaIcon(FontAwesomeIcons.linkedin, color: Theme.of(context).colorScheme.primary),
            tooltip: 'LinkedIn',
          ),
          IconButton(
            onPressed: () => launchUrl(Uri.parse('https://github.com/shoroardiSumon')),
            icon: FaIcon(FontAwesomeIcons.github, color: Theme.of(context).colorScheme.primary),
            tooltip: 'GitHub',
          ),
          IconButton(
            onPressed: () => launchUrl(Uri.parse('mailto:shoroardi.sumon@gmail.com')),
            icon: const Icon(Icons.email, color: Color(0xFFFF9800)),
            tooltip: 'Email',
          ),
        ],
      ),
    );
  }
}