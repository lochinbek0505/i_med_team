import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:i_med_team/pages/AboutUsPage.dart';
import 'package:i_med_team/pages/OnboardingPage.dart';
import 'package:i_med_team/pages/ResetPassword.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/contact_model.dart';
import '../models/profile_model.dart';
import '../services/ApiService.dart';
import '../services/ThemeProvider.dart';
import 'RewardsPage.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _townController = TextEditingController();
  File? _image;
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
  ProfileModel? profil;

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<void> clearSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<void> saveUserToPreferences(ProfileModel user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userJson = jsonEncode(user.toJson());
    await prefs.setString('user', userJson);
  }

  Future<ProfileModel?> getUserFromPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user');
    if (userJson != null) {
      Map<String, dynamic> userMap = jsonDecode(userJson);
      return ProfileModel.fromJson(userMap);
    }
    return null;
  }

  void edit_profil() {
    _firstNameController.text = profil!.data!.firstName.toString();
    _lastNameController.text = profil!.data!.lastName.toString();
    _middleNameController.text = profil!.data!.middleName.toString();
    selectedRegion = decodeText(profil!.data!.city.toString());
    selectedDistrict =
        utf8.decode(profil!.data!.town.toString().runes.toList());

    showModalBottomSheet(
      backgroundColor: Colors.grey[50],
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter modalSetState) {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: GestureDetector(
                            onTap: () async {
                              // Rasm tanlash
                              // final pickedFile = await ImagePicker()
                              //     .pickImage(source: ImageSource.gallery);
                              // if (pickedFile != null) {
                              // modalSetState(() {
                              // _image = File(pickedFile.path);
                              // });
                              final pickedFile = await ImagePicker()
                                  .pickImage(source: ImageSource.gallery);
                              if (pickedFile != null) {
                                final file = File(pickedFile.path);
                                final fileSize = await file.length();

                                if (fileSize <= 3 * 1024 * 1024) {
                                  // 5 MB tekshirish
                                  modalSetState(() {
                                    _image = file; // Rasmni saqlash
                                  });
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            "Iltimos, hajmi 5 MB dan kichik fayl tanlang!")),
                                  );
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text("Hech qanday rasm tanlanmadi.")),
                                );
                              }
                            },
                            child: Container(
                              width: 120,
                              height: 120,
                              clipBehavior: Clip.antiAlias,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: _image != null
                                  ? Image.file(
                                      _image!,
                                      fit: BoxFit.cover,
                                    )
                                  : profil!.data!.image != null
                                      ? Image.network(
                                          profil!.data!.image.toString(),
                                          fit: BoxFit.cover,
                                        )
                                      : Image.asset("assets/teacher.png"),
                            ),
                          ),
                        ),
                        TextFormField(
                          controller: _firstNameController,
                          decoration: InputDecoration(
                              labelText: "Ism", border: OutlineInputBorder()),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _lastNameController,
                          decoration: InputDecoration(
                              labelText: "Familiya",
                              border: OutlineInputBorder()),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _middleNameController,
                          decoration: InputDecoration(
                              labelText: "Otasining ismi",
                              border: OutlineInputBorder()),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        DropdownButtonFormField<String>(
                          value: selectedRegion,
                          decoration: const InputDecoration(
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
                            modalSetState(() {
                              selectedRegion = value;
                              selectedDistrict = null;
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        if (selectedRegion != null)
                          DropdownButtonFormField<String>(
                            value: selectedDistrict,
                            decoration: const InputDecoration(
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
                              modalSetState(() {
                                selectedDistrict = value;
                              });
                            },
                          ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 50,
                          width: 250,
                          child: ElevatedButton(
                            onPressed: () async {
                              await _submitProfile();
                            },
                            child: const Text(
                              "Profilni tahrirlash",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getUserFromPreferences().then((value) {
      setState(() {
        profil = value!;
      });
    });
  }

  String decodeText(String text) {
    try {
      return utf8.decode(text.runes.toList());
    } catch (e) {
      return text; // Xato bo‘lsa, asl matn qaytariladi
    }
  }

  Future<void> openTelegramWithPhone(String phone) async {
    final Uri url = Uri.parse('tg://resolve?phone=$phone');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch Telegram with phone: $phone';
    }
  }

  Future<ContactModel?> getContactFromPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('contact');
    if (userJson != null) {
      Map<String, dynamic> userMap = jsonDecode(userJson);
      return ContactModel.fromJson(userMap);
    }
    return null;
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Hisobdan chiqish !"),
          content: Text("Hisobdan chiqishni xohlaysizmi ?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Bekor qilish"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                clearSharedPreferences();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OnboardingScreen()),
                    (route)=>false);
                print("User logged out");
              },
              child: Text("Hisobdan chiqish"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[50],
      appBar: AppBar(
        // backgroundColor: Colors.redAccent,
        centerTitle: true,
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: profil == null
          ? CircularProgressIndicator()
          : SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  // Profile Section
                  Column(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 45,
                            backgroundColor: Colors.white,
                            backgroundImage: profil!.data!.image != null
                                ? NetworkImage(
                                    profil!.data!.image.toString(),
                                  )
                                : AssetImage(
                                    "assets/teacher.png"), // Placeholder
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: edit_profil,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 5,
                                      spreadRadius: 1,
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.edit,
                                  color: Colors.black87,
                                  size: 25,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Text(
                        '${profil!.data!.firstName} ${profil!.data!.lastName}',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                  // Profile Options
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => Rewardspage()));
                    },
                    child: _buildProfileOption(
                      link: "assets/business.png",
                      title: "Natijalar",
                      onTap: () {},
                    ),
                  ),

                  _buildProfileOption(
                    link: "assets/clock.png",
                    title: profil!.data!.duration != null
                        ? "${profil!.data!.duration! ~/ 60} soat ${profil!.data!.duration! % 60} minut"
                        : "Faollik mavjud emas",
                    onTap: () {},
                    showArrow: false,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => ResetPasswordPage(
                                  check: false, title: "Parolni tahrirlash")));
                    },
                    child: Container(
                      height: 65,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.lock_reset,
                            size: 30,
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Text(
                              maxLines: 1,
                              "Parolni almashtirish",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // const SizedBox(height: 20),
                  _buildDarkModeToggle(context),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (builder) => AboutUsPage()));
                    },
                    child: _buildProfileOption(
                      link: "assets/info.png",
                      title: "Biz haqimizda ",
                      onTap: () {},
                      showArrow: true,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (await canLaunch("https://t.me/imedteam_feedback")) {
                        await launch("https://t.me/imedteam_feedback");
                      } else {
                        throw 'Could not launch https://t.me/imedteam_feedback';
                      }
                    },
                    child: _buildProfileOption(
                      link: "assets/feedback.png",
                      title: " Feedback ",
                      onTap: () {},
                      showArrow: false,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      var contact = await getContactFromPreferences();
                      print(contact!.data!.phone);
                      openTelegramWithPhone(contact!.data!.phone!);
                    },
                    child: _buildProfileOption(
                      link: "assets/customer.png",
                      title: "Admin bilan bog'lanish",
                      onTap: () {},
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _showLogoutDialog(context);
                    },
                    child: _buildProfileOption(
                      link: "assets/logout 1.png",
                      title: "Hisobdan chiqish",
                      onTap: () {},
                      isLogout: true,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),

      // Bottom Navigation Bar
    );
  }

  Future<void> _submitProfile() async {
    try {
      final token = await getToken();

      // Multipart form ma'lumotlarini tayyorlash
      final uri = Uri.parse("https://oztech.uz/api/v1/users/profile/edit/");
      final request = http.MultipartRequest('POST', uri);

      request.headers['Authorization'] = 'Token $token';
      request.headers['Content-Type'] = 'multipart/form-data';

      request.fields['first_name'] = _firstNameController.text;
      request.fields['last_name'] = _lastNameController.text;
      request.fields['middle_name'] = _middleNameController.text;
      request.fields['city'] = selectedRegion.toString();
      request.fields['town'] = selectedDistrict.toString();

      // Rasm faylini qo'shish
      if (_image != null) {
        final imageFile = File(_image!.path);
        final fileName = path.basename(_image!.path);
        request.files.add(
          await http.MultipartFile.fromPath(
            'image',
            imageFile.path,
            filename: fileName,
          ),
        );
      }

      // So'rovni jo'natish
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        print(responseData);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseData.toString())),
        );

        final profilData = await apiService.profile();
        setState(() {
          profil = profilData!;
          saveUserToPreferences(profil!);
          Navigator.pop(context);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Xato: ${response.reasonPhrase}")),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Xatolik yuz berdi: $e")),
      );

      Navigator.pop(context);
    }
  }

  Widget _buildDarkModeToggle(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Image.asset("assets/day_mode.png", height: 24),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              "Qorong'u rejim",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
          Switch(
            value: themeProvider.themeMode == ThemeMode.dark,
            onChanged: (bool value) {
              themeProvider.toggleTheme(value);
            },
            activeColor: Colors.orange,
          ),
        ],
      ),
    );
  }

  // Profile Option Widget
  Widget _buildProfileOption({
    required String link,
    required String title,
    required VoidCallback onTap,
    bool showArrow = true,
    bool isLogout = false,
  }) {
    return Container(
      height: 65,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Image.asset(
            link,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              maxLines: 1,
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isLogout ? Colors.red : Colors.black87,
              ),
            ),
          ),
          if (showArrow)
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.black45,
            ),
        ],
      ),
    );
  }
}
