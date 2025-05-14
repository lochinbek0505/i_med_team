import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:i_med_team/models/contact_model.dart';
import 'package:i_med_team/models/courses_list_model.dart';
import 'package:i_med_team/models/end_end.dart';
import 'package:i_med_team/models/end_model.dart';
import 'package:i_med_team/models/end_test_model.dart';
import 'package:i_med_team/models/lesson_model.dart';
import 'package:i_med_team/models/login_request.dart';
import 'package:i_med_team/models/login_response.dart';
import 'package:i_med_team/models/my_courses_model.dart';
import 'package:i_med_team/models/profile_model.dart';
import 'package:i_med_team/models/quiz_model.dart';
import 'package:i_med_team/models/rate_request_model.dart';
import 'package:i_med_team/models/rate_response.dart';
import 'package:i_med_team/models/register_request.dart';
import 'package:i_med_team/models/register_response.dart';
import 'package:i_med_team/models/show_courses_model.dart';
import 'package:i_med_team/models/subject_model.dart';
import 'package:i_med_team/models/verfy_model.dart';
import 'package:i_med_team/pages/RegisterPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/OnboardingPage.dart';

class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  // Register API
  Future<RegisterResponse> register_request(RegisterRequest user) async {
    final url =
        Uri.parse('$baseUrl/users/signup/'); // Adjust the endpoint as needed
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      // Assuming the response contains a success message
      final data = jsonDecode(response.body);

      if (data['success'] == true) {
        return RegisterResponse.fromJson(data);
      } else {
        return RegisterResponse.fromJson(data);
      }
    } else {
      print(response.body);
      print(jsonDecode(response.body));

      throw Exception('Failed to register');
    }
  }

  // https://oztech.uz/api/v1/users/generate/
  Future<RegisterResponse> resend_code(String email) async {
    final url =
        Uri.parse('$baseUrl/users/generate/'); // Adjust the endpoint as needed
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"email": email}),
    );

    if (response.statusCode == 200) {
      // Assuming the response contains a success message
      final data = jsonDecode(response.body);
      print(data);
      if (data['success'] == true) {
        return RegisterResponse.fromJson(data);
      } else {
        return RegisterResponse.fromJson(data);
      }
    } else {
      print(response);
      throw Exception('Failed to login');
    }
  }

  Future<RegisterResponse> verfy_code(VerfyModel user) async {
    final url =
        Uri.parse('$baseUrl/users/verify/'); // Adjust the endpoint as needed
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      // Assuming the response contains a success message
      final data = jsonDecode(response.body);
      print(data);
      if (data['success'] == true) {
        return RegisterResponse.fromJson(data);
      } else {
        return RegisterResponse.fromJson(data);
      }
    } else {
      print(response);
      throw Exception('Failed to login');
    }
  }

  Future<RegisterResponse> reset_password(email, password) async {
    final url = Uri.parse(
        '$baseUrl/users/change/password/'); // Adjust the endpoint as needed
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"email": email, "password": password}),
    );

    if (response.statusCode == 200) {
      // Assuming the response contains a success message
      final data = jsonDecode(response.body);
      print(data);
      if (data['success'] == true) {
        return RegisterResponse.fromJson(data);
      } else {
        return RegisterResponse.fromJson(data);
      }
    } else {
      print(response);
      throw Exception('Failed to login');
    }
  }

  // Login API
  Future<LoginResponse> login_request(LoginRequest user) async {
    final url =
        Uri.parse('$baseUrl/users/login/'); // Adjust the endpoint as needed
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      // Assuming the response contains a success message
      final data = jsonDecode(response.body);

      if (data['success'] == true) {
        return LoginResponse.fromJson(data);
      } else {
        return LoginResponse.fromJson(data);
      }
    } else {
      print(response.body);
      throw Exception('Failed to login');
    }
  }

//Courses API main page
  Future<CoursesListModel> course_list() async {
    var token = await getToken();

    final url = Uri.parse('$baseUrl/courses/'); // Adjust the endpoint as needed
    final response = await http.get(
      url,
      headers: {'Authorization': 'Token $token'},
    );

    if (response.statusCode == 200) {
      // Assuming the response contains a success message
      final data = jsonDecode(response.body);

      if (data['success'] == true) {
        return CoursesListModel.fromJson(data);
      } else {
        return CoursesListModel.fromJson(data);
      }
    } else {
      print(response);
      throw Exception('Failed to get courses');
    }
  }

  Future<void> logout() async {
    var token = await getToken();

    final url =
        Uri.parse('$baseUrl/users/logout/'); // Adjust the endpoint as needed
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token $token'
      },
    );

    if (response.statusCode == 200) {
      // Assuming the response contains a success message
    } else {
      print(response);
      throw Exception('Failed to get courses');
    }
  }

// Subjects API main page
  Future<SubjectModel> subject_list(context) async {
    var token = await getToken();

    final url = Uri.parse(
        '$baseUrl/courses/subjects/'); // Adjust the endpoint as needed
    final response = await http.get(
      url,
      headers: {'Authorization': 'Token $token'},
    );
    if (response.statusCode == 200) {
      // Assuming the response contains a success message
      final data = jsonDecode(response.body);

      if (data['success'] == true) {
        return SubjectModel.fromJson(data);
      } else {
        return SubjectModel.fromJson(data);
      }
    } else if (response.statusCode == 401) {
      clearSharedPreferences();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => OnboardingScreen()));
      throw Exception("Unauthorized");
    } else {
      print(response);
      throw Exception('Failed to get courses');
    }
  }

  //Courses by subject API main page
  Future<CoursesListModel> subject_course_list(num id) async {
    var token = await getToken();

    final url = Uri.parse(
        '$baseUrl/courses/?subject=$id'); // Adjust the endpoint as needed
    final response = await http.get(
      url,
      headers: {'Authorization': 'Token $token'},
    );

    if (response.statusCode == 200) {
      // Assuming the response contains a success message
      final data = jsonDecode(response.body);

      if (data['success'] == true) {
        return CoursesListModel.fromJson(data);
      } else {
        return CoursesListModel.fromJson(data);
      }
    } else {
      print(response);
      throw Exception('Failed to get courses');
    }
  }

  Future<void> clearSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  //Show one course detailes API show course page
  Future<ShowCoursesModel> course_detailes(num id) async {
    var token = await getToken();

    final url =
        Uri.parse('$baseUrl/courses/$id/'); // Adjust the endpoint as needed
    final response = await http.get(
      url,
      headers: {'Authorization': 'Token $token'},
    );

    if (response.statusCode == 200) {
      // Assuming the response contains a success message
      final data = jsonDecode(response.body);

      if (data['success'] == true) {
        return ShowCoursesModel.fromJson(data);
      } else {
        return ShowCoursesModel.fromJson(data);
      }
    } else {
      print(response);
      throw Exception('Failed to get courses');
    }
  }

  // https://oztech.uz/api/v1/courses/1/modules/1/lessons/4/

  Future<LessonModel> show_lesson(
      num course_id, num modul_id, num lesson_id) async {
    var token = await getToken();

    final url = Uri.parse(
        '$baseUrl/courses/$course_id/modules/$modul_id/lessons/$lesson_id/'); // Adjust the endpoint as needed
    final response = await http.get(
      url,
      headers: {'Authorization': 'Token $token'},
    );

    if (response.statusCode == 200) {
      // Assuming the response contains a success message
      final data = jsonDecode(response.body);

      if (data['success'] == true) {
        return LessonModel.fromJson(data);
      } else {
        return LessonModel.fromJson(data);
      }
    } else {
      print(response);
      throw Exception('Failed to get courses');
    }
  }

  Future<QuizModel> show_quiz(
      num course_id, num modul_id, num lesson_id) async {
    var token = await getToken();

    final url = Uri.parse(
        '$baseUrl/courses/$course_id/modules/$modul_id/lessons/$lesson_id/'); // Adjust the endpoint as needed
    final response = await http.get(
      url,
      headers: {'Authorization': 'Token $token'},
    );

    if (response.statusCode == 200) {
      // Assuming the response contains a success message
      final data = jsonDecode(response.body);

      if (data['success'] == true) {
        return QuizModel.fromJson(data);
      } else {
        return QuizModel.fromJson(data);
      }
    } else {
      print(response);
      throw Exception('Failed to get courses');
    }
  }

  Future<EndEnd> end_lesson(EndModel end) async {
    var token = await getToken();

    final url =
        Uri.parse('$baseUrl/courses/end/'); // Adjust the endpoint as needed
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token $token'
      },
      body: jsonEncode(end.toJson()),
    );

    if (response.statusCode == 200) {
      // Assuming the response contains a success message
      final data = jsonDecode(response.body);
      print(EndEnd.fromJson(data));
      if (data['success'] == true) {
        return EndEnd.fromJson(data);
      } else {
        return EndEnd.fromJson(data);
      }
    } else {
      print(response);
      throw Exception('Failed to login ${response.body}');
    }
  }

  Future<EndEnd> end_test(EndTestModel end) async {
    var token = await getToken();

    final url =
        Uri.parse('$baseUrl/courses/rate/'); // Adjust the endpoint as needed
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token $token'
      },
      body: jsonEncode(end.toJson()),
    );

    if (response.statusCode == 200) {
      // Assuming the response contains a success message
      final data = jsonDecode(response.body);
      print(EndEnd.fromJson(data));
      if (data['success'] == true) {
        return EndEnd.fromJson(data);
      } else {
        return EndEnd.fromJson(data);
      }
    } else {
      print(response);
      throw Exception('Failed to login ${response.body}');
    }
  }

  Future<MyCoursesModel> my_courses_list() async {
    var token = await getToken();

    final url =
        Uri.parse('$baseUrl/courses/my/'); // Adjust the endpoint as needed
    final response = await http.get(
      url,
      headers: {'Authorization': 'Token $token'},
    );
    if (response.statusCode == 200) {
      // Assuming the response contains a success message
      final data = jsonDecode(response.body);

      if (data['success'] == true) {
        return MyCoursesModel.fromJson(data);
      } else {
        return MyCoursesModel.fromJson(data);
      }
    } else {
      print(response);
      throw Exception('Failed to get courses');
    }
  }

  // courses/ratings/
  Future<RateResponse> get_rate(RateRequestModel end) async {
    var token = await getToken();

    final url =
        Uri.parse('$baseUrl/courses/ratings/'); // Adjust the endpoint as needed
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token $token'
      },
      body: jsonEncode(end.toJson()),
    );

    if (response.statusCode == 200) {
      // Assuming the response contains a success message
      final data = jsonDecode(response.body);
      print(EndEnd.fromJson(data));
      if (data['success'] == true) {
        return RateResponse.fromJson(data);
      } else {
        return RateResponse.fromJson(data);
      }
    } else {
      print(response);
      throw Exception('Failed to login ${response.body}');
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

  Future<void> saveContactToPreferences(ContactModel user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userJson = jsonEncode(user.toJson());
    await prefs.setString('contact', userJson);
  }

  Future<ProfileModel> profile() async {
    var token = await getToken();

    final url =
        Uri.parse('$baseUrl/users/profile/'); // Adjust the endpoint as needed
    final response = await http.get(
      url,
      headers: {'Authorization': 'Token $token'},
    );
    if (response.statusCode == 200) {
      // Assuming the response contains a success message
      final data = jsonDecode(response.body);

      if (data['success'] == true) {
        return ProfileModel.fromJson(data);
      } else {
        return ProfileModel.fromJson(data);
      }
    } else {
      print(response);
      throw Exception('Failed to get courses');
    }
  }

  Future<ContactModel> contact() async {
    var token = await getToken();

    final url =
        Uri.parse('$baseUrl/users/contact/'); // Adjust the endpoint as needed
    final response = await http.get(
      url,
      headers: {'Authorization': 'Token $token'},
    );
    if (response.statusCode == 200) {
      // Assuming the response contains a success message
      final data = jsonDecode(response.body);

      if (data['success'] == true) {
        return ContactModel.fromJson(data);
      } else {
        return ContactModel.fromJson(data);
      }
    } else {
      print(response);
      throw Exception('Failed to get courses');
    }
  }
}
