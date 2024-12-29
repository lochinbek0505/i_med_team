import 'package:flutter/material.dart';
import 'package:i_med_team/models/register_request.dart';

import '../services/ApiService.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

// https://oztech.uz/admin/users/user/
class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController firstNameController = TextEditingController();

  final TextEditingController middleController = TextEditingController();

  final TextEditingController lastController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController password2Controller = TextEditingController();
  final ApiService apiService =
      ApiService('https://oztech.uz/api/v1'); // Replace with your API URL

  final Map<String, List<String>> regions = {
    'Toshkent': [
      'Bektemir',
      'Mirzo Ulug‘bek',
      'Mirobod',
      'Olmazor',
      'Sirg‘ali',
      'Uchtepa',
      'Chilonzor',
      'Shayhontohur',
      'Yakkasaroy',
      'Yunusobod',
      'Yangihayot' // Добавлен новый район
    ],
    'Samarqand': [
      'Samarqand shahri',
      'Bulung‘ur',
      'Jomboy',
      'Ishtixon',
      'Kattaqo‘rg‘on',
      'Narpay',
      'Nurobod',
      'Oqdaryo',
      'Paxtachi',
      'Payariq',
      'Qo‘shrabot',
      'Samarqand tumani',
      'Tayloq',
      'Urgut'
    ],
    'Buxoro': [
      'Buxoro shahri',
      'Buxoro tumani',
      'Vobkent',
      'G‘ijduvon',
      'Jondor',
      'Kogon shahri',
      'Kogon tumani',
      'Qorako‘l',
      'Olot',
      'Peshku',
      'Romitan',
      'Shofirkon'
    ],
    'Andijon': [
      'Andijon shahri',
      'Andijon tumani',
      'Asaka',
      'Baliqchi',
      'Bo‘z',
      'Buloqboshi',
      'Izboskan',
      'Jalaquduq',
      'Marxamat',
      'Oltinko‘l',
      'Paxtaobod',
      'Qo‘rg‘ontepa',
      'Shahrixon',
      'Xo‘jaobod'
    ],
    'Farg‘ona': [
      'Farg‘ona shahri',
      'Beshariq',
      'Bog‘dod',
      'Buvayda',
      'Dang‘ara',
      'Farg‘ona tumani',
      'Furqat',
      'Qo‘shtepa',
      'Oltiariq',
      'Ozodlik',
      'Rishton',
      'So‘x',
      'Toshloq',
      'Uchko‘prik',
      'Yozyovon'
    ],
    'Namangan': [
      'Namangan shahri',
      'Chortoq',
      'Chust',
      'Kosonsoy',
      'Mingbuloq',
      'Namangan tumani',
      'Norin',
      'Pop',
      'To‘raqo‘rg‘on',
      'Uchqo‘rg‘on',
      'Yangiqo‘rg‘on'
    ],
    'Jizzax': [
      'Jizzax shahri',
      'Arnasoy',
      'Baxmal',
      'Do‘stlik',
      'Forish',
      'G‘allaorol',
      'Jizzax tumani',
      'Mirzacho‘l',
      'Paxtakor',
      'Zomin',
      'Zafarobod',
      'Yangiobod'
    ],
    'Qashqadaryo': [
      'Qarshi shahri',
      'Chiroqchi',
      'Dehqonobod',
      'G‘uzor',
      'Kasbi',
      'Kitob',
      'Koson',
      'Mirishkor',
      'Muborak',
      'Nishon',
      'Qamashi',
      'Qarshi tumani',
      'Shahrisabz',
      'Yakkabog‘'
    ],
    'Navoiy': [
      'Navoiy shahri',
      'Konimex',
      'Karmana',
      'Qiziltepa',
      'Navbahor',
      'Nurota',
      'Tomdi',
      'Uchquduq',
      'Xatirchi'
    ],
    'Surxondaryo': [
      'Termiz shahri',
      'Angor',
      'Bandixon',
      'Boysun',
      'Denov',
      'Jarqo‘rg‘on',
      'Muzrabot',
      'Oltinsoy',
      'Qiziriq',
      'Qumqo‘rg‘on',
      'Sherobod',
      'Sho‘rchi',
      'Termiz tumani',
      'Uzun'
    ],
    'Sirdaryo': [
      'Guliston shahri',
      'Boyovut',
      'Guliston tumani',
      'Mirzaobod',
      'Oqoltin',
      'Sardoba',
      'Sayxunobod',
      'Sirdaryo tumani',
      'Xovos'
    ],
    'Xorazm': [
      'Urganch shahri',
      'Bog‘ot',
      'Gurlan',
      'Hazorasp',
      'Xiva',
      'Xonqa',
      'Qo‘shko‘pir',
      'Shovot',
      'Urganch tumani',
      'Yangiariq',
      'Yangibozor',
      'Tuproqqal’a'
    ],
    'Qoraqalpog‘iston Respublikasi': [
      'Nukus shahri',
      'Amudaryo',
      'Beruniy',
      'Chimboy',
      'Ellikqal’a',
      'Kegeyli',
      'Mo‘ynoq',
      'Nukus tumani',
      'Qanliko‘l',
      'Qo‘ng‘irot',
      'Qorao‘zak',
      'Shumanay',
      'Taxtako‘pir',
      'To‘rtko‘l',
      'Xo‘jayli',
      'Taxiatosh',
      'Bo‘zatov' // Добавлен новый район
    ]
  };
  String? selectedRegion;

  // Viloyat
  String? selectedDistrict;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    phoneController.addListener(() {
      if (!phoneController.text.startsWith("+998")) {
        // Force the prefix "+998"
        phoneController.text = "+998";
        phoneController.selection = TextSelection.fromPosition(
          TextPosition(offset: phoneController.text.length),
        );
      }
    });
  }

  void handRegister() async {
    // var user=RegisterRequest(phone: , firstName: firstNameController.text, lastName: lastController.text, middleName: middleController.text, city: selectedRegion.toString(), town: selectedDistrict.toString(), password: passwordController.text);
    // var response=await apiService.register_request(user);

    var phone = phoneController.text.trim();
    final first_name = firstNameController.text.trim();
    final last_name = lastController.text.trim();
    final middle_name = middleController.text.trim();
    final password = passwordController.text.trim();
    final region = selectedRegion.toString().trim();
    final district = selectedDistrict.toString().trim();

    print(phone);
    if (phone.isEmpty ||
        password.isEmpty ||
        first_name.isEmpty ||
        last_name.isEmpty ||
        middle_name.isEmpty ||
        region.isEmpty ||
        district.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Iltimos hamma maydonlarni to\'diring')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final user = RegisterRequest(
          phone: phone,
          firstName: first_name,
          lastName: last_name,
          middleName: middle_name,
          city: region,
          town: district,
          password: password);
      final success = await apiService.register_request(user);

      if (success.status == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Register successful')),
        );
        Navigator.pop(context);
        // Navigator.pop(context);
        // Navigate to another page (e.g., HomePage)
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$success')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

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
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Telefon raqamingiz',
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
                          selectedDistrict =
                              null; // Reset tuman when viloyat changes
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
                    isLoading
                        ? CircularProgressIndicator()
                        : Container(
                            width: size.width / 0.9,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.redAccent),
                              onPressed: () {
                                // Perform registration action
                                handRegister();
                              },
                              child: Text(
                                "Ro'yxatdan o'tish",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 19),
                              ),
                            ),
                          ),
                    SizedBox(
                      height: 10,
                    ),
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
