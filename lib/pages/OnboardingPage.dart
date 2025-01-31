import 'package:flutter/material.dart';
import 'package:i_med_team/pages/LoginPage.dart';
import 'package:i_med_team/pages/ProfessionPage.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  final List<OnboardingItem> _onboardingItems = [
    OnboardingItem(
      image: 'assets/onboard1.png',
      title: '"iMed Team" ga xush kelibsiz!',
      description: " \"iMed Team\" - Tibbiyotni davolovchi maskan! ",
    ),
    OnboardingItem(
      image: 'assets/onboard3.png',
      title: "Biz bilan tibbiyotni tez va oson o’rganing!",
      description:
          "Maqsadimiz : talaba va shifokorlarni zamonaviy va isbotli tibbiyot bilan to’laqonli tanishtirish",
    ),
    OnboardingItem(
      image: 'assets/onboard22.png',
      title: "Har bir yo’nalishni o’z mutaxassislari tomonidan o’rganing!",
      description:
          "Talaba va shifokorlar biz bilan o’z maqsadlariga erishib kelmoqda !",
    ),
  ];

  void _nextPage() {
    if (_currentPage < _onboardingItems.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _onboardingItems.length,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemBuilder: (context, index) {
              return OnboardingPage(
                item: _onboardingItems[index],
              );
            },
          ),
          Positioned(
            bottom: 20.0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                SmoothPageIndicator(
                  controller: _pageController,
                  count: _onboardingItems.length,
                  effect: WormEffect(
                    activeDotColor: Colors.blue,
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    dotWidth: 10,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Previous Button

                    // Next Button
                    if (_currentPage < _onboardingItems.length - 1)
                      ElevatedButton(
                        onPressed: _nextPage,
                        child: Text('Keyingi'),
                      ),
                    // Get Started Button (on the last page)
                    if (_currentPage == _onboardingItems.length - 1)
                      ElevatedButton(
                        onPressed: () {
                          // Navigate to the main app screen
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => ProfessionPage()));
                        },
                        child: Text('Boshlash'),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final OnboardingItem item;

  OnboardingPage({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(

          image: DecorationImage(image: AssetImage("assets/ic_background.jpg"),
              opacity: 0.2,
              fit: BoxFit.cover)

      ),      child: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (builder) => LoginPage()));
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                  child: Text(
                    "O'tkazib yuborish",
                    style: TextStyle(
                      color: Colors.lightBlue,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    item.image,
                    height: 270,

                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      item.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      item.description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingItem {
  final String image;
  final String title;
  final String description;

  OnboardingItem({
    required this.image,
    required this.title,
    required this.description,
  });
}
