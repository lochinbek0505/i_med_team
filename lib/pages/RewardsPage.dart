import 'package:flutter/material.dart';
import 'package:i_med_team/models/profile_model.dart';
import 'package:intl/intl.dart';

import '../services/ApiService.dart';

class Rewardspage extends StatefulWidget {
  Rewardspage({
    super.key,
  });

  @override
  State<Rewardspage> createState() => _RewardspageState();
}

class _RewardspageState extends State<Rewardspage> {
  final ApiService apiService =
      ApiService('https://oztech.uz/api/v1'); // Replace with your API URL

  String formatDate(inputDate) {
    // Stringni DateTime ob'ektiga o'tkazish
    DateTime dateTime = DateTime.parse(inputDate);

    // Vaqtni kerakli shaklda formatlash
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);

    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.redAccent,
        title: Text(
          "Natijalar",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: FutureBuilder<ProfileModel>(
          future: apiService.profile(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData ||
                snapshot.data!.data!.ratingList!.isEmpty) {
              return const Center(child: Text('No items found.'));
            } else {
              var list = snapshot.data!.data!.ratingList!;

              return ListView.builder(
                  itemCount: list!.length,
                  itemBuilder: (context, index) {
                    final item = list[index];
                    return Card(
                      margin: const EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.course!.name.toString(),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Bo'lim: ${item.module!.name}",
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Dars: ${item.lesson!.name}",
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/star2.png",
                                      width: 20,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      "Natija: ${item.score}",
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 4,
                                    horizontal: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.teal.shade300,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    "Sana: ${formatDate(item.created)}",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                    );
                  });
            }
          }),
    );
  }
}
