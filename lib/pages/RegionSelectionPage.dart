import 'package:flutter/material.dart';



class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Icon(
                      Icons.arrow_back_outlined,
                      color: Colors.pinkAccent,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 40),
                    child: Text(
                      "French Toast",
                      style: TextStyle(
                        color: Colors.pinkAccent,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 79, right: 11),
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.pink,
                      ),
                      child: Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.pink,
                      ),
                      child: Icon(
                        Icons.share,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Stack(
                alignment: Alignment.topCenter,
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 340,
                    height: 345,
                    decoration: BoxDecoration(
                      color: Colors.pink,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Positioned(
                    child: Container(
                      width: 340,
                      height: 290,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: AssetImage("assets/cake.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 25, top: 305),
                        child: Text(
                          "Pankake & Cream",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                     Row(
                       children: [ Padding(
                         padding: EdgeInsets.only(left: 45, top: 305),
                         child: Icon(
                           Icons.star,
                           color: Colors.white,
                           size: 16,
                         ),
                       ),
                         Padding(
                           padding: EdgeInsets.only(right: 80, top: 305),
                           child: Text(
                             "4",
                             style: TextStyle(
                               fontSize: 14,
                               fontWeight: FontWeight.bold,
                               color: Colors.black,
                             ),
                           ),
                         ),
                         Padding(
                           padding: EdgeInsets.only(right: 20, top: 305),
                           child: Icon(
                             Icons.comment,
                             color: Colors.white,
                             size: 14,
                           ),
                         ),],
                     )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}