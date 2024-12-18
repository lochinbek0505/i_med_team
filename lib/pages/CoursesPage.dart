import 'package:flutter/material.dart';

class Coursespage extends StatefulWidget {
  const Coursespage({super.key});

  @override
  State<Coursespage> createState() => _CoursespageState();
}

class _CoursespageState extends State<Coursespage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Center(
          child: Text(
            "Mening kurslarim",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),
          ),
        ),

      ),
      body: ListView.builder(
          itemCount: 5,
          itemBuilder: (context,index){

        return  Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 15),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        const Text(
                          "Fizika",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),

                        // Subtitle
                        const Text(
                          "Farxod Eshonqulov",
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
                                borderRadius: BorderRadius.circular(16),
                                child: LinearProgressIndicator(
                                  value: 0.0, // 0% progress
                                  backgroundColor: Colors.grey[300],
                                  color: Colors.green,
                                  minHeight: 6,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              "0%",
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

                  SizedBox(width: 10,),
                  // Circular Avatar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50), // Circular shape
                    child: Image.network(
                      "https://via.placeholder.com/80", // Replace with the actual image URL
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

      }),
    );
  }
}
