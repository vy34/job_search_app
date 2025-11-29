import 'dart:convert';
import 'package:http/http.dart' as https;
import 'package:job_search_app/models/request/auth/add_skills.dart';
import 'package:job_search_app/models/response/auth/login_res_model.dart';
import 'package:job_search_app/models/response/auth/profile_model.dart';
import 'package:job_search_app/models/response/auth/skills.dart';
import 'package:job_search_app/services/config.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AuthHelper {
  static var client = https.Client();

  static Future<bool> signup(String model) async {
    try {
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json; charset=UTF-8',
      };
      var url = Uri.parse("${Config.apiUrl}${Config.signupUrl}");

      var response = await client.post(
        url,
        headers: requestHeaders,
        body: model,
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception('Signup failed: $e');
    }
  }

  static Future<Map<String, dynamic>> login(String model) async {
    try {
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json; charset=UTF-8',
      };
      var url = Uri.parse("${Config.apiUrl}${Config.loginUrl}");

      var response = await client.post(
        url,
        headers: requestHeaders,
        body: model,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        var user = loginResponseModelFromJson(response.body);

        await prefs.setString('token', user.userToken);
        await prefs.setString('userId', user.id);
        await prefs.setString('uid', user.uid);
        await prefs.setString('profile', user.profile);
        await prefs.setString('username', user.username);
        await prefs.setBool('loggedIn', true);
        return {'success': true, 'message': 'Login successful'};
      } else if (response.statusCode == 400) {
        // Invalid credentials
        var responseBody = jsonDecode(response.body);
        String message = responseBody['message'] ?? 'Invalid email or password';
        return {'success': false, 'message': message};
      } else if (response.statusCode == 401) {
        // Unauthorized
        return {'success': false, 'message': 'Invalid email or password'};
      } else {
        return {
          'success': false,
          'message': 'Login failed. Please try again later',
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Error: $e'};
    }
  }

  static Future<ProfileRes> getProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      throw Exception('No token found');
    }
    try {
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
        'authorization': 'Bearer $token',
      };
      var url = Uri.parse("${Config.apiUrl}${Config.profileUrl}");

      var response = await client.get(url, headers: requestHeaders);

      if (response.statusCode == 200 || response.statusCode == 204) {
        var profile = profileResFromJson(response.body);
        return profile;
      } else {
        throw Exception('Failed to load profile: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load profile: $e');
    }
  }

  static Future<List<Skills>> getSkills() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      throw Exception('No token found');
    }
    try {
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
        'authorization': 'Bearer $token',
      };
      var url = Uri.parse("${Config.apiUrl}${Config.skillsUrl}");

      var response = await client.get(url, headers: requestHeaders);

      if (response.statusCode == 200 || response.statusCode == 204) {
        var skills = skillsFromJson(response.body);
        return skills;
      } else {
        throw Exception('Failed to load skills: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load skills: $e');
    }
  }

  static Future<bool> deleteSkill(String skillId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      throw Exception('No token found');
    }

    try {
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
        'authorization': 'Bearer $token',
      };

      var url = Uri.parse("${Config.apiUrl}${Config.skillsUrl}/$skillId");

      var response = await client.delete(url, headers: requestHeaders);

      if (response.statusCode == 200 || response.statusCode == 204) {
        return true;
      } else if (response.statusCode == 404) {
        throw Exception('Skill not found (404)');
      } else {
        throw Exception('Failed to delete skill: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to delete skill: $e');
    }
  }

  static Future<bool> addSkills(String model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      throw Exception('No token found');
    }
    try {
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
        'authorization': 'Bearer $token',
      };
      var url = Uri.parse("${Config.apiUrl}${Config.skillsUrl}");

      var response = await client.post(
        url,
        headers: requestHeaders,
        body: model,
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
