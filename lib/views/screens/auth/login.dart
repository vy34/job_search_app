import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:job_search_app/controllers/login_provider.dart';
import 'package:job_search_app/controllers/zoom_provider.dart';
import 'package:job_search_app/views/common/BackBtn.dart';
import 'package:job_search_app/views/common/app_bar.dart';
import 'package:job_search_app/views/common/custom_btn.dart';
import 'package:job_search_app/views/common/custom_textfield.dart';
import 'package:job_search_app/views/common/exports.dart';
import 'package:job_search_app/views/common/height_spacer.dart';
import 'package:job_search_app/views/common/styled_container.dart';
import 'package:job_search_app/views/screens/auth/registration.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginNotifier>(
      builder: (context, loginNotifier, child) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: CustomAppBar(
              text: 'Login',
              child: GestureDetector(
                onTap: () {
                  Get.offAll(() => const RegistrationPage());
                },
                child: const Icon(AntDesign.leftcircleo),
              ),
            ),
          ),
          body: buildStyleContainer(
            context,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Form(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    HeightSpacer(size: 50),
                    ReusableText(
                      text: "Welcome Back",
                      style: appStyle(30, Color(kDark.value), FontWeight.w600),
                    ),
                    ReusableText(
                      text: "Fill in your details to login",
                      style: appStyle(
                        14,
                        Color(kDarkGrey.value),
                        FontWeight.w400,
                      ),
                    ),
                    const HeightSpacer(size: 50),

                    CustomTextField(
                      controller: emailController,
                      hintText: "Enter your email",
                      keyboardType: TextInputType.emailAddress,
                      validator: (emailController) {
                        if (!RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}',
                        ).hasMatch(emailController!)) {
                          return "Enter a valid email address";
                        }
                        return null;
                      },
                    ),
                    const HeightSpacer(size: 15),
                    CustomTextField(
                      controller: passwordController,
                      hintText: "Enter your password",
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: loginNotifier.obscureText,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          loginNotifier.obscureText =
                              !loginNotifier.obscureText;
                        },
                        child: Icon(
                          loginNotifier.obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Color(kDarkGrey.value),
                        ),
                      ),
                      validator: (passwordController) {
                        if (passwordController!.isEmpty ||
                            passwordController.length < 8) {
                          return "Plese enter a valid password";
                        }
                        return null;
                      },
                    ),
                    const HeightSpacer(size: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          Get.offAll(() => const RegistrationPage());
                        },
                        child: ReusableText(
                          text: "Don't have an account? Sign Up",
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
                          text: "Login",
                          onTap: () {
                            print("tapped");
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
