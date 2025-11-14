import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../scroll_controller_inherited.dart';

class EducationSection extends StatelessWidget {
  const EducationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final educations = const [
      {
        'institution': 'Pabna University of Science & Technology, Pabna',
        'degree': 'B.Sc. Engineering',
        'department': 'Department of Electronic & Telecommunication Engineering',
        'period': 'January, 2015 - May, 2021',
        'gpa': 'CGPA: 3.18',
      },
      {
        'institution': 'Ullapara Science College, Ullapara, Sirajganj',
        'degree': 'HSC',
        'department': null,
        'period': 'Session: 2011-2012',
        'gpa': 'GPA: 4.90',
      },
      {
        'institution': 'Momena Ali Biggan School, Ullapara, Sirajganj',
        'degree': 'SSC',
        'department': null,
        'period': 'Session: 2009-2010',
        'gpa': 'GPA: 5.00',
      },
    ];

    final scrollController = ScrollControllerInherited.of(context)!;

    return AutoScrollTag(
      key: const ValueKey('education'),
      controller: scrollController,
      index: 5,
      highlightColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Semantics(
              label: 'Education Section Title',
              child: Text(
                'Education',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            ...educations.map((edu) => _buildEducationCard(context, edu)),
          ],
        ),
      ),
    ).animate().slideX(begin: 0.3, end: 0.0, duration: const Duration(milliseconds: 800), curve: Curves.easeOut);
  }

  Widget _buildEducationCard(BuildContext context, Map<String, dynamic> edu) {
    return Animate(
      effects: const [FadeEffect(delay: Duration(milliseconds: 200))],
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      edu['institution'],
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    Text(edu['degree']),
                    if (edu['department'] != null) ...[
                      const SizedBox(height: 4),
                      Text(edu['department'], style: Theme.of(context).textTheme.bodySmall),
                    ],
                    const SizedBox(height: 6),
                    Text(edu['period'] ?? '', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.85))),
                  ],
                ),
              ),
              Expanded(
                child: Text(
                  edu['gpa'] ?? '',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).primaryColor,
                      ),
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}