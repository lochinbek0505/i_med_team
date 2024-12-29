import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:i_med_team/models/courses_list_model.dart';
import 'package:i_med_team/models/login_request.dart';
import 'package:i_med_team/models/login_response.dart';
import 'package:i_med_team/models/register_request.dart';
import 'package:i_med_team/models/register_response.dart';
import 'package:i_med_team/models/subject_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      print(response);
      throw Exception('Failed to register');
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
      print(response);
      throw Exception('Failed to login');
    }
  }

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

  Future<SubjectModel> subject_list() async {
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
    } else {
      print(response);
      throw Exception('Failed to get courses');
    }
  }
  Future<CoursesListModel> subject_course_list(num id) async {
    var token = await getToken();

    final url = Uri.parse('$baseUrl/courses/?subjects=$id/'); // Adjust the endpoint as needed
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


}
