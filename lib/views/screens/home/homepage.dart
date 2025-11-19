import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:job_search_app/constants/app_constants.dart';
import 'package:job_search_app/views/common/app_bar.dart';
import 'package:job_search_app/views/common/app_style.dart';
import 'package:job_search_app/views/common/drawer/drawer_widget.dart';
import 'package:job_search_app/views/common/heading_widget.dart';
import 'package:job_search_app/views/common/search.dart';
import 'package:job_search_app/views/screens/auth/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          actions: [
            Padding(
              padding: EdgeInsets.all(12.0.h),
              child: GestureDetector(
                onTap: () {
                  Get.to(() => const ProfilePage(drawer: false));
                },
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                  child: Image.asset(
                    'assets/images/account.jpg',
                    width: 30.h,
                    height: 30.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],

          child: Padding(
            padding: EdgeInsets.all(12.0.h),
            child: DrawerWidget(color: Color(kDark.value)),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Search \n Finding and Apply",
                  style: appStyle(38, Color(kDark.value), FontWeight.bold),
                ),
                SizedBox(height: 20.h),
                SearchWidget(onTap: () {}),
                SizedBox(height: 20.h),
                const HeadingWidget(text: 'Popular Jobs '),
                SizedBox(height: 15.h),
                const HeadingWidget(text: 'Recently Posted'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
