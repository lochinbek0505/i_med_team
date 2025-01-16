import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class TestResultPage extends StatefulWidget {
  String? precent;
  String? correct;
  String? incorrect;

  TestResultPage(
      {required this.precent, required this.correct, required this.incorrect});

  @override
  State<TestResultPage> createState() => _TestResultPageState();
}

class _TestResultPageState extends State<TestResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('assets/anim/test.json'),
                _buildResultTile(
                  context,
                  icon: "assets/check.png",
                  color: Colors.green,
                  label: "To'g'ri javoblar",
                  value: '${widget.correct} ta',
                ),
                SizedBox(height: 20),
                _buildResultTile(
                  context,
                  icon: "assets/incorrect.png",
                  color: Colors.red,
                  label: "Noto'g'ri javoblar",
                  value: '${widget.incorrect} ta',
                ),
                SizedBox(height: 20),
                _buildResultTile(
                  context,
                  icon: "assets/energy.png",
                  color: Colors.teal,
                  label: "Samaradorlik",
                  value: '${widget.precent} %',
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        // Davom etish action
                        Navigator.pop(context);
                      },
                      child: Text(
                        'DAVOM ETISH',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResultTile(BuildContext context,
      {required String icon,
      required Color color,
      required String label,
      required String value}) {
    return Card(
      elevation: 4,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: ListTile(
            leading: Image.asset(
              icon,
              width: 35,
              height: 35,
            ),
            title: Text(
              label,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            trailing: Text(
              value,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
