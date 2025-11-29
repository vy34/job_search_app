import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:job_search_app/constants/app_constants.dart';
import 'package:job_search_app/controllers/login_provider.dart';
import 'package:job_search_app/views/common/app_bar.dart';
import 'package:job_search_app/views/common/app_style.dart';
import 'package:job_search_app/views/common/drawer/drawer_widget.dart';
import 'package:job_search_app/views/common/heading_widget.dart';
import 'package:job_search_app/views/common/search.dart';
import 'package:job_search_app/views/screens/auth/profile_page.dart';
import 'package:job_search_app/views/screens/jobs/job_list_page.dart';
import 'package:job_search_app/views/screens/jobs/widgets/PopularJobs.dart';
import 'package:job_search_app/views/screens/jobs/widgets/Recentlist.dart';
import 'package:job_search_app/views/screens/search/search_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    String imageUrl =
        'https://www.pngall.com/wp-content/uploads/5/User-Profile-PNG-High-Quality-Image.png';
    var loginNotifier = Provider.of<LoginNotifier>(context);
    loginNotifier.getPref();
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
                  child: Image.network(
                    imageUrl,
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
                  "Finding and Apply",
                  style: appStyle(38, Color(kDark.value), FontWeight.bold),
                ),
                SizedBox(height: 20.h),

                SearchWidget(
                  onTap: () {
                    Get.to(() => const SearchPage());
                  },
                ),

                SizedBox(height: 30.h),

                HeadingWidget(
                  text: 'Popular Jobs ',
                  onTap: () {
                    Get.to(() => const JobListPage());
                  },
                ),

                SizedBox(height: 15.h),

                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(12.w)),
                  child: const PopularJobs(),
                ),

                SizedBox(height: 15.h),

                HeadingWidget(
                  text: 'Recently Posted',
                  onTap: () {
                    Get.to(() => const JobListPage());
                  },
                ),

                SizedBox(height: 15.h),
                const RecentList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
