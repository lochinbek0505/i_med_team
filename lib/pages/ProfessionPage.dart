import 'package:flutter/material.dart';
import 'package:i_med_team/pages/RegisterPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfessionPage extends StatefulWidget {
  @override
  State<ProfessionPage> createState() => _ProfessionPageState();
}

class _ProfessionPageState extends State<ProfessionPage> {
  var profession = "";

  Future<String?> getProf() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('proff');
  }

  Future<void> saveProf(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('proff', token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Kimsiz ?',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Column(
                children: [
                  SizedBox(height: 20),
                  Text(
                    'O\'zingiz haqingizda ma\'lumot bering. Bu bizga sizga mos tafsiyalarni berish imkonini yaratadi !',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 40),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        profession = "O\'quvchi";
                      });
                    },
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Container(
                        height: 65,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: profession == ""
                                    ? Colors.grey
                                    : profession == "O\'quvchi"
                                        ? Colors.red
                                        : Colors.grey),
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Image.asset(
                              "assets/graduated.png",
                              width: 40,
                              height: 40,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text("Men o'quvchiman"),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        profession = "Shifokor";
                      });
                    },
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Container(
                        height: 65,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: profession == ""
                                    ? Colors.grey
                                    : profession == "Shifokor"
                                        ? Colors.red
                                        : Colors.grey),
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Image.asset(
                              "assets/doctor.png",
                              width: 40,
                              height: 40,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text("Men shifokorman"),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () async {
                      // Keyingi sahifaga o'tish
                      if (profession != "") {
                        await saveProf(profession);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => RegisterPage()));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Text("Iltimos yuqoridagilardan birini tanlang !"),
                        ));
                      }
                    },
                    child: Text('DAVOM ETISH'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      textStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
              SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
