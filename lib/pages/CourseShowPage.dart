import 'package:flutter/material.dart';
import 'package:i_med_team/widgets/CourseInformationWidget.dart';

class CourseShowPage extends StatefulWidget {
  const CourseShowPage({super.key});

  @override
  State<CourseShowPage> createState() => _CourseShowPageState();
}

class _CourseShowPageState extends State<CourseShowPage> {
  final List<Map<String, dynamic>> courseSections = [
    {
      'title': '1. Kirish (Bepul)',
      'isExpandable': true,
      'items': [
        {
          'name': 'Kurs haqida',
          'icon': Icons.play_circle,
          'color': Colors.green
        },
        {
          'name': 'Boshlang’ich qism',
          'icon': Icons.play_circle,
          'color': Colors.green
        },
        {
          'name': 'Fizikaga kirish',
          'icon': Icons.play_circle,
          'color': Colors.green
        },
      ],
    },
    {
      'title': '2. Kinematika',
      'isExpandable': true,
      'items': [
        {
          'name': 'Kurs haqida',
          'icon': Icons.play_circle,
          'color': Colors.green
        },
        {
          'name': 'Boshlang’ich qism',
          'icon': Icons.play_circle,
          'color': Colors.green
        },
        {
          'name': 'Fizikaga kirish',
          'icon': Icons.play_circle,
          'color': Colors.green
        },
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Center(
          child: Text(
            "KURS HAQIDA",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQk7mmC9oDvYrX0zAN6EgumppKhrH3uyhTxgg&s",
                  // Replace with your image URL
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "Abuteryentlar DTM imtihonlari uchun Fizika kursi",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                "Siz ushbu kursda OTM larga kirish DTM imtihonlari uchun yuqori darajadagi bilimlarni olish imkoniyatiga ega bo’lasiz.",
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
              child: Text(
                "O'qituvchi : ",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.network(
                      'https://picsum.photos/seed/picsum/200/300',
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Farxod Eshonqulov",
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Star Icon
                      Image.asset("assets/star.png"),
                      SizedBox(
                        width: 7,
                      ),
                      Text(
                        "4.4",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      // Coin Icon with Text
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Star Icon
                      Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Text(
                        "35 ",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      // Coin Icon with Text
                    ],
                  ),
                  Row(
                    children: [
                      Image.asset(
                        'assets/dollar.png',
                        // Replace with the path to your coin image asset
                        height: 24,
                        width: 24,
                      ),
                      SizedBox(width: 7), // Spacing between icon and text
                      Text(
                        '250 000 so\'m',
                        style: TextStyle(
                          color: Colors.orange,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            CourseInformationWidget(icon: "assets/lesson.png",text: "80 ta video dars",),
            CourseInformationWidget(icon: "assets/video_lesson.png",text: "10 soat 25 min",),
            CourseInformationWidget(icon: "assets/test.png",text: "50 ta test topshirig'i",),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
              child: Text(
                "Kurs tarkibi : ",
                style: TextStyle(
                  fontSize: 21,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(color: Colors.black, width: 2.0),
                      // Top border
                      left: BorderSide(color: Colors.black, width: 2.0),
                      // Left border
                      right: BorderSide(color: Colors.black, width: 2)),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40),
                    topLeft: Radius.circular(40),
                  ),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  // Ensures ListView takes only required space
                  physics: NeverScrollableScrollPhysics(),
                  // Disable ListView's scrolling

                  itemCount: courseSections.length,
                  itemBuilder: (context, sectionIndex) {
                    final section = courseSections[sectionIndex];

                    if (section['isExpandable']) {
                      // Expandable Section
                      return Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Theme(
                            data: ThemeData()
                                .copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTile(
                              initiallyExpanded: sectionIndex == 0,
                              // First section expanded by default
                              title: Text(
                                section['title'],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),

                              children: List.generate(
                                section['items'].length,
                                (index) {
                                  final item = section['items'][index];
                                  return ListTile(
                                    leading: Icon(item['icon'],
                                        color: item['color']),
                                    title: Text(
                                      item['name'],
                                      style: TextStyle(
                                        fontSize: 17,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(
                            thickness: 2,
                            height: 1,
                            color: Colors.black,
                          )
                        ],
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
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Container(
                height: 55,
                width: size.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10), // Set the corner radius
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    "KURSNI XARID QILISH",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
