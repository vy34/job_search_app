import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_search_app/constants/app_constants.dart';
import 'package:job_search_app/models/request/auth/signup_model.dart';
import 'package:job_search_app/services/helpers/auth_helper.dart';
import 'package:job_search_app/views/screens/auth/login.dart';

class SignUpNotifier extends ChangeNotifier {
  bool _obscureText = true;
  bool get obscureText => _obscureText;
  set obscureText(bool newState) {
    _obscureText = newState;
    notifyListeners();
  }

  bool _loader = false;
  bool get loader => _loader;
  set loader(bool newState) {
    _loader = newState;
    notifyListeners();
  }

  final signupFormKey = GlobalKey<FormState>();
  bool validateandSave() {
    final form = signupFormKey.currentState;
    if (form != null && form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  signUp(String model) {
    AuthHelper.signup(model)
        .then((response) {
          if (response == true) {
            loader = false;
            Get.snackbar(
              "Success",
              "Signup successful! Please login",
              colorText: Color(kLight.value),
              backgroundColor: Colors.green,
            );
            Get.offAll(() => const LoginPage());
          } else {
            loader = false;
            Get.snackbar(
              "Failed to Signup",
              "Please try again later",
              colorText: Color(kLight.value),
              backgroundColor: Color(kOrange.value),
              icon: const Icon(Icons.add_alert),
            );
          }
        })
        .catchError((e) {
          loader = false;
          print("SignUp Error: $e");
          Get.snackbar(
            "Error",
            "Signup failed: $e",
            colorText: Color(kLight.value),
            backgroundColor: Color(kOrange.value),
            icon: const Icon(Icons.add_alert),
          );
        });
  }
}
