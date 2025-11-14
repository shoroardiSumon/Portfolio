// animated_text_kit was removed from home content; kept import commented for future use
// import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/constants/assets.dart';
import 'package:portfolio/constants/content.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:url_launcher/url_launcher.dart';

import '../scroll_controller_inherited.dart';

class HomeSection extends StatelessWidget {
  const HomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final AutoScrollController scrollController = ScrollControllerInherited.of(context)!;
    final isMobile = MediaQuery.sizeOf(context).width < 600;

    return AutoScrollTag(
      key: const ValueKey('home'),
      controller: scrollController,
      index: 0,
      highlightColor: Colors.transparent,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            constraints: BoxConstraints(
              minHeight: isMobile ? 560 : MediaQuery.sizeOf(context).height - 120,
            ),
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: isMobile
                ? _buildMobileLayout(context, scrollController)
                : _buildDesktopLayout(context, scrollController),
          );
        },
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context, AutoScrollController? scrollController) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Animate(
          effects: const [ScaleEffect(duration: Duration(seconds: 1))],
          child: Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(image: AssetImage(assetProfileImage), fit: BoxFit.cover),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.12),
                  blurRadius: 20,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Animate(
          effects: const [FadeEffect(duration: Duration(seconds: 1))],
          child: Text(
            personName,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 8),
          // Job title
          Text(
            homeJobTitle,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
              homeParagraphs.first,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _downloadCV(context),
              child: const Text(downloadCvLabel),
            ),
            const SizedBox(width: 10),
            OutlinedButton(
              onPressed: () => scrollController?.scrollToIndex(3, preferPosition: AutoScrollPosition.begin),
              child: const Text(viewProjectsLabel),
            ),
            const SizedBox(width: 12),
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
            const SizedBox(height: 12),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context, AutoScrollController? scrollController) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Animate(
                effects: const [FadeEffect(duration: Duration(seconds: 1))],
                child: Text(
                  personName,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
                // Job title
                Text(
                  homeJobTitle,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              const SizedBox(height: 20),
              Text(
                homeParagraphs.join(' '),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () => _downloadCV(context),
                    child: const Text(downloadCvLabel),
                  ),
                  const SizedBox(width: 10),
                  OutlinedButton(
                    onPressed: () => scrollController?.scrollToIndex(3, preferPosition: AutoScrollPosition.begin),
                    child: const Text(viewProjectsLabel),
                  ),
                  const SizedBox(width: 12),
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
              const SizedBox(height: 12),
            ],
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.centerRight,
            child: Animate(
              effects: const [ScaleEffect(duration: Duration(milliseconds: 400))],
              child: Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(image: AssetImage(assetProfileImage), fit: BoxFit.cover),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.12),
                      blurRadius: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _downloadCV(BuildContext context) {
    launchUrl(Uri(path: downloadCvPath));
  }

}
