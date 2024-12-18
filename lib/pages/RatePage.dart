import 'package:flutter/material.dart';

class CourseList extends StatelessWidget {
  final List<Map<String, dynamic>> courseSections = [
    {
      'title': '1. Kirish (Bepul)',
      'isExpandable': true,
      'items': [
        {'name': 'Kurs haqida', 'icon': Icons.play_circle, 'color': Colors.green},
        {'name': 'Boshlang’ich qism', 'icon': Icons.play_circle, 'color': Colors.green},
        {'name': 'Fizikaga kirish', 'icon': Icons.play_circle, 'color': Colors.green},
      ],
    },
    {
      'title': '2. Kinematika',
      'isExpandable': true,
      'items': [
        {'name': 'Kurs haqida', 'icon': Icons.play_circle, 'color': Colors.green},
        {'name': 'Boshlang’ich qism', 'icon': Icons.play_circle, 'color': Colors.green},
        {'name': 'Fizikaga kirish', 'icon': Icons.play_circle, 'color': Colors.green},

      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: courseSections.length,
        itemBuilder: (context, sectionIndex) {
          final section = courseSections[sectionIndex];
      
          if (section['isExpandable']) {
            // Expandable Section
            return ExpansionTile(
              initiallyExpanded: sectionIndex == 0, // First section expanded by default
              title: Text(
                section['title'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              children: List.generate(
                section['items'].length,
                    (index) {
                  final item = section['items'][index];
                  return ListTile(
                    leading: Icon(item['icon'], color: item['color']),
                    title: Text(item['name']),
                  );
                },
              ),
            );
          } else {
            // Non-expandable Section
            return ListTile(
              title: Text(
                section['title'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: Icon(Icons.add),
            );
          }
        },
      ),
    );
  }
}