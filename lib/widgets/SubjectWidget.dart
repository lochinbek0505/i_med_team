import 'package:flutter/material.dart';
import 'package:i_med_team/models/subject_model.dart';

class Subjectwidget extends StatelessWidget {
  Subjectwidget({super.key, required this.data});

  Subject50 data;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 90,
        decoration: BoxDecoration(

          color: Colors.white,
          borderRadius: BorderRadius.circular(10),

        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 30,
                backgroundImage:
                    NetworkImage("https://oztech.uz${data.image!}"),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.name!,
                  style: TextStyle(
                    fontSize: 19,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5,),
                Text(
                  "${data.courses!} ta kurs",
                  style: TextStyle(
                    fontSize: 17,
                  ),
                )
              ],
            )
          ],
        ));
  }
}
