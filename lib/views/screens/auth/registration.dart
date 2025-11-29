import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:job_search_app/constants/app_constants.dart';
import 'package:job_search_app/controllers/login_provider.dart';
import 'package:job_search_app/controllers/signup_provider.dart';
import 'package:job_search_app/controllers/zoom_provider.dart';
import 'package:job_search_app/models/request/auth/signup_model.dart';
import 'package:job_search_app/views/common/BackBtn.dart';
import 'package:job_search_app/views/common/app_bar.dart';
import 'package:job_search_app/views/common/app_style.dart';
import 'package:job_search_app/views/common/custom_btn.dart';
import 'package:job_search_app/views/common/custom_textfield.dart';
import 'package:job_search_app/views/common/height_spacer.dart';
import 'package:job_search_app/views/common/pages_loader.dart';
import 'package:job_search_app/views/common/reusable_text.dart';
import 'package:job_search_app/views/common/styled_container.dart';
import 'package:job_search_app/views/screens/auth/login.dart';
import 'package:provider/provider.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpNotifier>(
      builder: (context, signUpNotifier, child) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: CustomAppBar(
              text: 'Sign Up',
              child: GestureDetector(
                onTap: () {
                  Get.offAll(() => const LoginPage());
                },
                child: const Icon(AntDesign.leftcircleo),
              ),
            ),
          ),
          body: signUpNotifier.loader
              ? PageLoader()
              : buildStyleContainer(
                  context,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Form(
                      key: signUpNotifier.signupFormKey,
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          HeightSpacer(size: 50),
                          ReusableText(
                            text: "Welcome ",
                            style: appStyle(
                              30,
                              Color(kDark.value),
                              FontWeight.w600,
                            ),
                          ),
                          ReusableText(
                            text: "Fill in your details to sign up",
                            style: appStyle(
                              14,
                              Color(kDarkGrey.value),
                              FontWeight.w400,
                            ),
                          ),
                          const HeightSpacer(size: 50),

                          CustomTextField(
                            controller: usernameController,
                            hintText: "Username",
                            keyboardType: TextInputType.text,
                            validator: (usernameController) {
                              if (usernameController == null ||
                                  usernameController.isEmpty) {
                                return "Username is required";
                              }
                              if (usernameController.length < 3) {
                                return "Username must be at least 3 characters";
                              }
                              return null;
                            },
                          ),
                          const HeightSpacer(size: 15),

                          CustomTextField(
                            controller: emailController,
                            hintText: "Email",
                            keyboardType: TextInputType.emailAddress,
                            validator: (emailController) {
                              if (emailController == null ||
                                  emailController.isEmpty) {
                                return "Email is required";
                              }
                              final emailRegex = RegExp(
                                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                              );
                              if (!emailRegex.hasMatch(emailController)) {
                                return "Please enter a valid email address (e.g., user@example.com)";
                              }
                              return null;
                            },
                          ),
                          const HeightSpacer(size: 15),
                          CustomTextField(
                            controller: passwordController,
                            hintText: "Password",
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: signUpNotifier.obscureText,
                            suffixIcon: GestureDetector(
                              onTap: () {
                                signUpNotifier.obscureText =
                                    !signUpNotifier.obscureText;
                              },
                              child: Icon(
                                signUpNotifier.obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Color(kDarkGrey.value),
                              ),
                            ),
                            validator: (passwordController) {
                              if (passwordController == null ||
                                  passwordController.isEmpty) {
                                return "Password is required";
                              }
                              if (passwordController.length < 8) {
                                return "Password must be at least 8 characters";
                              }
                              return null;
                            },
                          ),
                          const HeightSpacer(size: 10),
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {
                                Get.offAll(() => const LoginPage());
                              },
                              child: ReusableText(
                                text: "Already have an account? Login",
                                style: appStyle(
                                  14,
                                  Color(kOrange.value),
                                  FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          const HeightSpacer(size: 50),
                          Consumer<ZoomNotifier>(
                            builder: (context, zoomNotifier, child) {
                              return CustomButton(
                                text: "Sign Up",
                                onTap: () {
                                  if (signUpNotifier.signupFormKey.currentState!
                                      .validate()) {
                                    signUpNotifier.loader = true;
                                    SignupModel model = SignupModel(
                                      username: usernameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                    String newModel = signupModelToJson(model);
                                    signUpNotifier.signUp(newModel);
                                  }
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}
