import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:job_search_app/constants/app_constants.dart';
import 'package:job_search_app/views/common/custom_outline_btn.dart';
import 'package:job_search_app/views/common/exports.dart';
import 'package:job_search_app/views/screens/mainscreen.dart';

class PageThree extends StatelessWidget {
  const PageThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: width,
        height: hieght,
        color: Color(kLightBlue.value),
        child: Column(
          children: [
            Image.asset('assets/images/page3.png'),
            const SizedBox(height: 40),
            Column(
              children: [
                ReusableText(
                  text: 'Welcome to us',
                  style: appStyle(30, Color(kLight.value), FontWeight.w500),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text(
                    'We help you to find best job that suits your profile and build your career',
                    style: appStyle(15, Color(kLight.value), FontWeight.normal),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            CustomOutlineBtn(
              onTap: () {
                Get.to(() => const Mainscreen());
              },
              hieght: hieght * 0.05,
              width: width * 0.9,
              text: 'Continue as Guest',
              color: Color(kLight.value),
            ),
          ],
        ),
      ),
    );
  }
}
