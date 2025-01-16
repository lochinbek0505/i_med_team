import 'package:flutter/material.dart';
import 'package:i_med_team/models/courses_list_model.dart';
import 'package:i_med_team/models/subject_model.dart';
import 'package:i_med_team/pages/CourseShowPage.dart';
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

  late List<Data70> items;
  var filteredItems = [];
  var subjects = [];
  late Future<SubjectModel> _subjects;

  // Filtered list for search
  TextEditingController searchController =
      TextEditingController(); // Controller for search input
  void dispose() {
    searchController.dispose(); // Dispose of controller
    super.dispose();
  }

  Future<void> _refreshItems() async {
    _itemsFuture = apiService.course_list();
    _itemsFuture.then((data) {
      setState(() {
        items = data.data;
        filteredItems =
            List.from(items); // Initialize filteredItems with all items
      });
    }).catchError((error) {
      print('Error fetching courses: $error');
    });
  }

  void getCourses(num id) async {
    if(id!=10000){
    var data = await apiService.subject_course_list(id);
    print(data.data[0].name);

    setState(() {
      items = data.data;
      filteredItems = data.data;
    });}
    else{
      _itemsFuture = apiService.course_list();
      _itemsFuture.then((data) {
        setState(() {
          items = data.data;
          filteredItems =
              List.from(items); // Initialize filteredItems with all items
        });
      }).catchError((error) {
        print('Error fetching courses: $error');
      });
    }
  }

  void _filterCourses(String query) {
    setState(() {
      filteredItems = items
          .where(
              (item) => item.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();

    // Fetch courses and subjects from the API
    _itemsFuture = apiService.course_list();
    _itemsFuture.then((data) {
      setState(() {
        items = data.data;
        filteredItems =
            List.from(items); // Initialize filteredItems with all items
      });
    }).catchError((error) {
      print('Error fetching courses: $error');
    });

    // Fetch subjects separately
    apiService.subject_list().then((data) {
      setState(() {
        subjects = data.data;
        subjects.insert(0, Subject50(id: 10000, name: "Barcha kurslar"));
      });
    }).catchError((error) {
      print('Error fetching subjects: $error');
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
            Card(
              color: Colors.white,
              elevation: 5,
              margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: Container(
                height: 60,
                child: Center(
                  child: TextField(
                    controller: searchController,
                    onChanged: (value) {
                      _filterCourses(value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Kurs qidirish',
                      hintStyle: TextStyle(
                        color: Colors.black87,
                        fontSize: 17,
                      ),
                      prefixIcon: Image.asset(
                        'assets/ic_loupe.png',
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 60,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15),
                child: subjects.isEmpty
                    ? CircularProgressIndicator()
                    : ListView.builder(
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
                        }),
              ),
            ),

            //courses ui

            Expanded(
              child: filteredItems.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: filteredItems.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 15),
                          child: Card(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CourseShowPage(
                                          id: filteredItems[index].id)),
                                );
                              },
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
                                        "${filteredItems[index].image}",
                                        height: 180,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(height: 8),

                                    // Course Info Section
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Students and Icon Row
                                    Row(
                                      children: [
                                        Icon(Icons.people,
                                            size: 20, color: Colors.black54),
                                        SizedBox(width: 4),
                                        Text(
                                          "${filteredItems[index]
                                              .countStudents} ta o'quvchi",
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
                                            "${filteredItems[index].name} ",
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
                                      filteredItems[index].description,
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
                                                "${filteredItems[index].user.firstName} ${filteredItems[index].user.lastName}",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(width: 10),
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
                                            "${filteredItems[index].price} so'm",
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
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
