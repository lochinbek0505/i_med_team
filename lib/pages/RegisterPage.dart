import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController firstNameController = TextEditingController();

  final TextEditingController middleController = TextEditingController();

  final TextEditingController lastController = TextEditingController();

  final TextEditingController phonelController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController password2Controller = TextEditingController();

  final Map<String, List<String>> regions = {
    'Toshkent': ['Mirzo Ulugbek', 'Chilonzor', 'Bektemir', 'Yunusobod'],
    'Samarqand': ['Samarqand sh.', 'Urgut', 'Jomboy', 'Bulung‘ur'],
    'Buxoro': ['Buxoro sh.', 'Kogon', 'G‘ijduvon', 'Vobkent'],
    // Shu yerga boshqa viloyatlar va ularning tumanlarini qo‘shishingiz mumkin.
  };
  String? selectedRegion;
 // Viloyat
  String? selectedDistrict;
 // Tuman
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Center(
            child: Text(
          "Ro'yxatdan o'tish",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white),
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Container(
            width: size.width / 0.9,
            margin: EdgeInsets.symmetric(vertical: 20),
            child: Card(
              color: Colors.white,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 35.0, horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: firstNameController,
                      decoration: InputDecoration(
                        labelText: 'Ismingiz',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 25),
                    TextField(
                      controller: middleController,
                      decoration: InputDecoration(
                        labelText: 'Sharifingiz',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 25),
                    TextField(
                      controller: lastController,
                      decoration: InputDecoration(
                        labelText: 'Familiyangiz',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 25),
                    TextField(
                      controller: phonelController..text = "+998 ",
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Phone',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: selectedRegion,
                      decoration: InputDecoration(
                        labelText: 'Viloyat',
                        border: OutlineInputBorder(),
                      ),
                      items: regions.keys
                          .map((region) => DropdownMenuItem<String>(
                        value: region,
                        child: Text(region),
                      ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedRegion = value;
                          selectedDistrict = null; // Reset tuman when viloyat changes
                        });
                      },
                    ),
                    SizedBox(height: 16),
                    if (selectedRegion != null)
                      DropdownButtonFormField<String>(
                        value: selectedDistrict,
                        decoration: InputDecoration(
                          labelText: 'Tuman',
                          border: OutlineInputBorder(),
                        ),
                        items: regions[selectedRegion]!
                            .map((district) => DropdownMenuItem<String>(
                          value: district,
                          child: Text(district),
                        ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedDistrict = value;
                          });
                        },
                      ),
                    SizedBox(height: 25),
                    TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: 'Parolingiz',
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: 25),
                    TextField(
                      controller: password2Controller,
                      decoration: InputDecoration(
                        labelText: 'Parolingizni takrorlang',
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: 30),
                    Container(
                      width: size.width / 0.9,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent),
                        onPressed: () {
                          // Perform registration action
                          print(
                              'Name: ${firstNameController.text}, Email: ${phonelController.text}, Password: ${passwordController.text}');
                        },
                        child: Text(
                          "Ro'yxatdan o'tish",
                          style: TextStyle(color: Colors.white, fontSize: 19),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Hisobga kirish',
                        style: TextStyle(

                          fontSize: 18,


                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
