import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:i_med_team/models/login_request.dart';
import 'package:i_med_team/models/login_response.dart';
import 'package:i_med_team/models/register_request.dart';
import 'package:i_med_team/models/register_response.dart';

class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  // Register API
  Future<RegisterResponse> register_request(RegisterRequest user) async {
    final url = Uri.parse('$baseUrl/users/signup/'); // Adjust the endpoint as needed
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
      }else{
        return RegisterResponse.fromJson(data);
      }
    } else {
      print(response);
      throw Exception('Failed to login');
    }
  }

  // Login API
  Future<LoginResponse> login_request(LoginRequest user) async {
    final url = Uri.parse('$baseUrl/users/login/'); // Adjust the endpoint as needed
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

      }else{
        return LoginResponse.fromJson(data);
      }
    } else {
      print(response);
      throw Exception('Failed to login');
    }
  }

}
