import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:job_search_app/constants/app_constants.dart';
import 'package:job_search_app/controllers/zoom_provider.dart';
import 'package:job_search_app/models/request/auth/login_model.dart';
import 'package:job_search_app/models/request/auth/profile_update_model.dart';
import 'package:job_search_app/services/helpers/auth_helper.dart';
import 'package:job_search_app/views/screens/mainscreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginNotifier extends ChangeNotifier {
  bool _obscureText = true;
  bool get obscureText => _obscureText;
  set obscureText(bool newState) {
    _obscureText = newState;
    notifyListeners();
  }

  bool? _entrypoint;
  bool get entrypoint => _entrypoint ?? false;
  set entrypoint(bool newState) {
    _entrypoint = newState;
    notifyListeners();
  }

  bool? _loggedIn;
  bool get loggedIn => _loggedIn ?? false;
  set loggedIn(bool newState) {
    _loggedIn = newState;
    notifyListeners();
  }

  bool _loader = false;
  bool get loader => _loader;
  set loader(bool newState) {
    _loader = newState;
    notifyListeners();
  }

  login(String model, ZoomNotifier zoomNotifier) {
    _loader = true;
    notifyListeners();

    AuthHelper.login(model)
        .then((response) {
          _loader = false;
          notifyListeners();

          bool success = response['success'] ?? false;
          String message = response['message'] ?? 'Unknown error';

          if (success == true) {
            Get.snackbar(
              "Success",
              message,
              colorText: Color(kLight.value),
              backgroundColor: Colors.green,
            );
            zoomNotifier.currentIndex = 0;
            Get.to(() => const Mainscreen());
          } else {
            // Hiển thị error message chi tiết
            Get.snackbar(
              "Login Failed",
              message,
              colorText: Color(kLight.value),
              backgroundColor: Color(kOrange.value),
              icon: const Icon(Icons.error),
              duration: const Duration(seconds: 3),
            );
          }
        })
        .catchError((e) {
          _loader = false;
          notifyListeners();
          print("Login catchError: $e");
          Get.snackbar(
            "Error",
            "Login failed: Check your connection and try again",
            colorText: Color(kLight.value),
            backgroundColor: Color(kOrange.value),
            icon: const Icon(Icons.error),
          );
        });
  }

  getPref() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    entrypoint = prefs.getBool('entrypoint') ?? false;
    loggedIn = prefs.getBool('loggedIn') ?? false;
    username = prefs.getString('username') ?? '';
    userUid = prefs.getString('uid') ?? '';
    profile = prefs.getString('profile') ?? '';
  }

  logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('loggedIn', false);
    await prefs.remove('token');
  }
}
