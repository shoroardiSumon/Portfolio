import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:url_launcher/url_launcher.dart';
import 'widgets/footer.dart';
import 'widgets/header.dart';
import 'widgets/scroll_controller_inherited.dart';
import 'widgets/sections/about_section.dart';
import 'widgets/sections/contact_section.dart';
import 'widgets/sections/education_section.dart';
import 'widgets/sections/experience_section.dart';
import 'widgets/sections/home_section.dart';
import 'widgets/sections/projects_section.dart';
import 'widgets/sections/skills_section.dart';

class PortfolioHome extends StatefulWidget {
  const PortfolioHome({super.key});

  @override
  State<PortfolioHome> createState() => _PortfolioHomeState();
}

class _PortfolioHomeState extends State<PortfolioHome> {
  late final AutoScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = AutoScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(String section) {
    switch (section) {
      case 'home':
        _scrollController.scrollToIndex(0);
        break;
      case 'about':
        _scrollController.scrollToIndex(1);
        break;
      case 'skills':
        _scrollController.scrollToIndex(2);
        break;
      case 'projects':
        _scrollController.scrollToIndex(3);
        break;
      case 'experience':
        _scrollController.scrollToIndex(4);
        break;
      case 'education':
        _scrollController.scrollToIndex(5);
        break;
      case 'contact':
        _scrollController.scrollToIndex(6);
        break;
    }
  }

  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    // single dark mode — UI reads colors from Theme
    return ScrollControllerInherited(
      scrollController: _scrollController,
      child: Scaffold(
        // static gradient background (no animation)
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            // solid black background per your request
            Positioned.fill(
              child: ColoredBox(
                color: Colors.black,
              ),
            ),
            // Scrollable content; each section will float in the same styled container
            SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  _floatingSection(const HomeSection(), context),
                  _floatingSection(const AboutSection(), context),
                  _floatingSection(const SkillsSection(), context),
                  _floatingSection(const ProjectsSection(), context),
                  _floatingSection(const ExperienceSection(), context),
                  _floatingSection(const EducationSection(), context),
                  _floatingSection(const ContactSection(), context),
                  const SizedBox(height: 20),
                  Footer(onLaunchURL: _launchURL),
                ],
              ),
            ),
            // floating header positioned at top center
            Positioned(
              top: 20,
              left: 0,
              right: 0,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: Header(onScrollTo: _scrollToSection),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper: wrap a section with a subtle indigo tint based on primary color
  // Helper: render every section as a uniform floating card over the black background
  Widget _floatingSection(Widget child, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              // transparent background for the section cards; keep border and shadow so they float
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.06)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.6),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}