import 'package:flutter/material.dart';
import 'package:i_med_team/models/courses_list_model.dart';
import 'package:i_med_team/widgets/SearchBar.dart';
import 'package:i_med_team/widgets/SubjectWidget.dart';

import '../services/ApiService.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  final ApiService apiService =
      ApiService('https://oztech.uz/api/v1'); // Replace with your API URL
  late Future<CoursesListModel> _itemsFuture;

  late List<Data> items;
  @override
  void initState() {
    super.initState();
    _itemsFuture = apiService.course_list();
  }

  Future<void> _refreshItems() async {
    setState(() {
      _itemsFuture = apiService.course_list(); // Re-fetch items when refreshing
    });
  }

  void getCourses(num id) async {
    var data = await apiService.subject_course_list(id);
    print(data.data[0].name);

    setState(() {
      items = data.data;

    });   

  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Salom , Lochinbek",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              width: 40,
              height: 40,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image.network(
                'https://picsum.photos/seed/picsum/200/300',
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshItems,
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            SearchTextField(),
            Container(
              height: 60,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15),
                child: FutureBuilder(
                    future: apiService.subject_list(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData ||
                          snapshot.data!.data.isEmpty) {
                        return const Center(child: Text('No items found.'));
                      } else {
                        var subjects = snapshot.data!.data;
                        return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            // Make it scroll horizontally
                            itemCount: subjects.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  getCourses(subjects[index].id);
                                },
                                child: Subjectwidget(
                                  data: subjects[index],
                                ),
                              );
                            });
                      }
                    }),
              ),
            ),

            //courses ui

            Expanded(
              child: FutureBuilder<CoursesListModel>(
                future: apiService.course_list(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.data.isEmpty) {
                    return const Center(child: Text('No items found.'));
                  } else {
                    items = snapshot.data!.data;
                    print("TOEKN TOKEN TOKEN TOKEN TOKEN $items");
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 15),
                            child: Card(
                              child: Container(
                                width: 340,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 8,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Top Image Section
                                    ClipRRect(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(16)),
                                      child: Image.network(
                                        "${items[index].image}",
                                        // Replace with your image URL
                                        height: 180,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(height: 8),

                                    // Course Info Section
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Students and Icon Row
                                          Row(
                                            children: [
                                              Icon(Icons.people,
                                                  size: 20,
                                                  color: Colors.black54),
                                              SizedBox(width: 4),
                                              Text(
                                                "${items[index].countStudents} ta o'quvchi",
                                                style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),

                                          // Course Title
                                          Text(
                                            "${items[index].name} ",
                                            maxLines: 1,
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 4),

                                          // Course Description
                                          Text(
                                            maxLines: 3,
                                            items[index].description,
                                            style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 14,
                                            ),
                                          ),
                                          const SizedBox(height: 10),

                                          // Teacher Name and Rating
                                          Row(
                                            children: [
                                              Text(
                                                "${items[index].user.firstName} ${items[index].user.lastName}",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              const Icon(Icons.star,
                                                  color: Colors.amber,
                                                  size: 20),
                                              const SizedBox(width: 4),
                                              const Text(
                                                "4.5",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),

                                    const SizedBox(height: 12),

                                    // Bottom Price and Button Row
                                    Container(
                                      padding: const EdgeInsets.all(12.0),
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.vertical(
                                          bottom: Radius.circular(16),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "${items[index].price} so'm",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.orange,
                                              fontSize: 18,
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.orange,
                                              foregroundColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                            child: const Text("Kursni olish"),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
