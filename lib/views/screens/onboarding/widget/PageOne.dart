import 'package:flutter/material.dart';
import 'package:job_search_app/constants/app_constants.dart';
import 'package:job_search_app/views/common/exports.dart';

class PageOne extends StatelessWidget {
  const PageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: width,
        height: hieght,
        color: Color(kDarkPurple.value),
        child: Column(
          children: [
            const SizedBox(height: 70),
            Image.asset('assets/images/page1.png'),
            const SizedBox(height: 40),
            Column(
              children: [
                ReusableText(
                  text: 'Find Your Dream Job',
                  style: appStyle(30, Color(kLight.value), FontWeight.w500),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text(
                    'Explore all the most exciting job roles based on your interest and study major. Find your dream job, and start your career',
                    style: appStyle(15, Color(kLight.value), FontWeight.normal),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
