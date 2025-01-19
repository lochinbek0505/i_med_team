import 'package:flutter/material.dart';
import 'package:i_med_team/models/my_courses_model.dart';
import 'package:i_med_team/pages/ShowMyLessons.dart';

import '../services/ApiService.dart';

class Coursespage extends StatefulWidget {
  const Coursespage({super.key});

  @override
  State<Coursespage> createState() => _CoursespageState();
}

class _CoursespageState extends State<Coursespage> {
  final ApiService apiService =
      ApiService('https://oztech.uz/api/v1'); // Replace with your API URL
  late Future<MyCoursesModel> _itemsFuture;

  late List<Data> items;

  @override
  void initState() {
    super.initState();
    _itemsFuture = apiService.my_courses_list();
  }

  Future<void> _refreshItems() async {
    setState(() {
      _itemsFuture =
          apiService.my_courses_list(); // Re-fetch items when refreshing
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Center(
          child: Text(
            "Mening kurslarim",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: FutureBuilder(
          future: apiService.my_courses_list(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.dataList!.isEmpty) {
              return const Center(child: Text('No items found.'));
            } else {
              var courses = snapshot.data!.dataList;

              return ListView.builder(
                  itemCount: courses!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 15),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ShowMyLessons(id: courses[index].id)),
                          );
                        },
                        child: Card(
                          child: Container(
                            width: 340,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Color(0xFFFEEBEB), // Light beige color
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 6,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Left Column (Text and Progress Bar)
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Title
                                      Text(
                                        courses![index].name!,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      const SizedBox(height: 4),

                                      // Subtitle
                                      Text(
                                        "${courses[index].user!.firstName} ${courses[index].user!.lastName}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      const SizedBox(height: 8),

                                      // Progress Bar and Percentage
                                      Row(
                                        children: [
                                          Expanded(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              child: LinearProgressIndicator(
                                                value: courses[index]
                                                        .percentage!
                                                        .toDouble() /
                                                    100, // 0% progress
                                                backgroundColor:
                                                    Colors.grey[300],
                                                color: Colors.green,
                                                minHeight: 6,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            "${courses[index].percentage!.toInt()}%",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(
                                  width: 10,
                                ),
                                // Circular Avatar
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  // Circular shape
                                  child: courses[index].user!.image == null
                                      ? Image.asset(
                                          "assets/teacher.png",
                                          height: 60,
                                          width: 60,
                                        )
                                      : Image.network(
                                          courses[index].user!.image,
                                          // Replace with the actual image URL
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            }
          }),
    );
  }
}
