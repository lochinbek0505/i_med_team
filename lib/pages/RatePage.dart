import 'package:flutter/material.dart';
import 'package:i_med_team/models/rate_request_model.dart';

import '../models/courses_list_model.dart';
import '../models/rate_response.dart';
import '../services/ApiService.dart';
import '../widgets/CustomDropDownWidget.dart';
import '../widgets/CustomRadioButtonWidgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ReytingPage(),
    );
  }
}

class ReytingPage extends StatefulWidget {
  @override
  _ReytingPageState createState() => _ReytingPageState();
}

class _ReytingPageState extends State<ReytingPage> {
  late Data70 selectedCourse;
  String selectedMode = 'Haftalik';
  final ApiService apiService =
      ApiService('https://oztech.uz/api/v1'); // Replace with your API URL
  late CoursesListModel _itemsFuture;
  late RateResponse _itemsRate;
  late List<Data70> items = [];
  late List<Ratings> ratings_list = [];
  final List<String> modes = ['Oylik', 'Haftalik', 'Kunlik'];
  var course_id;
  var type;

  void init() async {
    // Fetch courses and subjects from the API
    _itemsFuture = await apiService.course_list();
    setState(() {
      items = _itemsFuture.data!;
      selectedCourse = items[0];
    });
    _itemsRate = await apiService.get_rate(
      RateRequestModel(course: items[0].id, type: "monthly"),
    );
    setState(() {
      ratings_list = _itemsRate.data!.ratingsList!;
      print(ratings_list.length);
    });
  }

  void getReytings() async {
    var mode = "monthly";
    switch (selectedMode) {
      case "Haftalik":
        {
          mode = "weekly";
        }
      case "Oylik":
        {
          mode = "monthly";
        }
      case "Kunlik":
        {
          mode = "daily";
        }
    }

    _itemsRate = await apiService.get_rate(
      RateRequestModel(course: selectedCourse.id, type: mode),
    );
    setState(() {
      ratings_list = _itemsRate.data!.ratingsList!;
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Peshqadamlar',
        ),
        // backgroundColor: Colors.redAccent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Custom Dropdown
            items.isEmpty
                ? CircularProgressIndicator()
                : CustomDropdown(
                    selectedValue: selectedCourse,
                    items: items,
                    onChanged: (value) {
                      setState(() {
                        selectedCourse = value;
                        getReytings();
                      });
                    },
                  ),
            SizedBox(height: 20),
            // Custom Radio Buttons
            CustomRadioButtons(
              selectedValue: selectedMode,
              values: modes,
              onChanged: (value) {
                setState(() {
                  selectedMode = value;
                  getReytings();
                });
              },
            ),
            SizedBox(height: 20),
            // Example List (Rating)
            FutureBuilder(
                future: apiService.course_list(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData ||
                      snapshot.data!.data!.isEmpty) {
                    return const Center(child: Text('No items found.'));
                  } else {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: ratings_list.length, // Example list length
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Card(
                              elevation: 4,
                              shadowColor: Colors.redAccent,
                              child: index == 0
                                  ? Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey[50],
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          border: Border.all(
                                            color: Colors.yellowAccent,
                                            width: 1,
                                          )),
                                      child: ListTile(
                                        leading: Image.asset(
                                          "assets/gold.png",
                                          width: 40,
                                          height: 40,
                                        ),
                                        title: Text(
                                          "${ratings_list[index].user!.firstName} ${ratings_list[index].user!.lastName}",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                        ),
                                        trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Image.asset(
                                              "assets/star2.png",
                                              width: 35,
                                              height: 35,
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              '${ratings_list[index].score! ~/ 5}',
                                              style: TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : index == 1
                                      ? Container(
                                          decoration: BoxDecoration(
                                              color: Colors.grey[50],
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              border: Border.all(
                                                color: Colors.lightBlueAccent,
                                                width: 1,
                                              )),
                                          child: ListTile(
                                            leading: Image.asset(
                                              "assets/silver.png",
                                              width: 40,
                                              height: 40,
                                            ),
                                            title: Text(
                                              "${ratings_list[index].user!.firstName} ${ratings_list[index].user!.lastName}",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                              ),
                                            ),
                                            trailing: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Image.asset(
                                                  "assets/star2.png",
                                                  width: 35,
                                                  height: 35,
                                                ),
                                                SizedBox(width: 5),
                                                Text(
                                                  '${ratings_list[index].score! ~/ 5}',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : index == 2
                                          ? Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.grey[50],
                                                  borderRadius:
                                                      BorderRadius.circular(14),
                                                  border: Border.all(
                                                    color: Colors.redAccent,
                                                    width: 1,
                                                  )),
                                              child: ListTile(
                                                leading: Image.asset(
                                                  "assets/bronze.png",
                                                  width: 40,
                                                  height: 40,
                                                ),
                                                title: Text(
                                                  "${ratings_list[index].user!.firstName} ${ratings_list[index].user!.lastName}",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                trailing: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Image.asset(
                                                      "assets/star2.png",
                                                      width: 35,
                                                      height: 35,
                                                    ),
                                                    SizedBox(width: 5),
                                                    Text(
                                                      '${ratings_list[index].score! ~/ 5}',
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          : Container(
                                              decoration: BoxDecoration(
                                                color: Colors.grey[50],
                                                borderRadius:
                                                    BorderRadius.circular(14),
                                              ),
                                              child: ListTile(
                                                leading: Text(
                                                  '${index + 1}',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                title: Text(
                                                  "${ratings_list[index].user!.firstName} ${ratings_list[index].user!.lastName}",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                trailing: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Image.asset(
                                                      "assets/star2.png",
                                                      width: 35,
                                                      height: 35,
                                                    ),
                                                    SizedBox(width: 5),
                                                    Text(
                                                      '${ratings_list[index].score! ~/ 5}',
                                                      style: TextStyle(
                                                        fontSize: 18,
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
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}

// Custom Dropdown

// Custom Radio Buttons
