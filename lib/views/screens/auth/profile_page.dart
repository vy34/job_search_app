import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:job_search_app/controllers/login_provider.dart';
import 'package:job_search_app/models/response/auth/profile_model.dart';
import 'package:job_search_app/services/helpers/auth_helper.dart';
import 'package:job_search_app/views/common/BackBtn.dart';
import 'package:job_search_app/views/common/app_bar.dart';
import 'package:job_search_app/views/common/custom_outline_btn.dart';
import 'package:job_search_app/views/common/drawer/drawer_widget.dart';
import 'package:job_search_app/views/common/exports.dart';
import 'package:job_search_app/views/common/height_spacer.dart';
import 'package:job_search_app/views/common/pages_loader.dart';
import 'package:job_search_app/views/common/styled_container.dart';
import 'package:job_search_app/views/common/width_spacer.dart';
import 'package:job_search_app/views/screens/auth/non_user.dart';
import 'package:job_search_app/views/screens/auth/widgets/edit_button.dart';
import 'package:job_search_app/views/screens/auth/widgets/skills.dart';
import 'package:job_search_app/views/screens/mainscreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.drawer});

  final bool drawer;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<ProfileRes> userProfile;
  String username = '';

  @override
  void initState() {
    super.initState();
    userProfile = Future.value(
      ProfileRes(
        id: '',
        username: '',
        email: '',
        isAgent: false,
        skills: false,
        profile: '',
      ),
    );
    getProfile();
  }

  getProfile() async {
    var loginNotifier = Provider.of<LoginNotifier>(context, listen: false);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Lấy username từ SharedPreferences khi user đã login
    if (loginNotifier.loggedIn == true) {
      username = prefs.getString('username') ?? '';
      // Load profile từ API
      userProfile = AuthHelper.getProfile();
    }
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var loginNotifier = Provider.of<LoginNotifier>(context);
    return Scaffold(
      backgroundColor: Color(kLightGrey.value),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          text: loginNotifier.loggedIn == true
              ? (username.isEmpty ? 'Profile' : username.toUpperCase())
              : 'Guest',
          child: Padding(
            padding: EdgeInsets.all(12.0.h),
            child: widget.drawer == false
                ? BackBtn()
                : DrawerWidget(color: Color(kDark.value)),
          ),
        ),
      ),

      body: loginNotifier.loggedIn == false
          ? NonUser()
          : Stack(
              children: [
                Positioned(
                  right: 0,
                  left: 0,
                  bottom: 0,
                  top: 0.h,
                  child: Container(
                    color: Color(Color.fromARGB(255, 137, 179, 225).value),
                  ),
                ),
                Positioned(
                  right: 0,
                  left: 0,
                  top: 12.h,
                  child: FutureBuilder(
                    future: userProfile,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SizedBox.shrink();
                      } else if (snapshot.hasError) {
                        return const SizedBox.shrink();
                      } else {
                        var profile = snapshot.data;
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 20.w),
                          padding: EdgeInsets.symmetric(
                            horizontal: 14.w,
                            vertical: 12.h,
                          ),
                          width: width,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(kNewBlue.value),
                                Color(kGreen.value),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(14.w),
                            boxShadow: [
                              BoxShadow(
                                color: Color(kDark.value).withOpacity(0.08),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    image: profile!.profile,
                                    w: 48,
                                    h: 48,
                                  ),
                                  WidthSpacer(width: 12),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ReusableText(
                                        text: profile.username.toUpperCase(),
                                        style: appStyle(
                                          13,
                                          Colors.white,
                                          FontWeight.w600,
                                        ),
                                      ),
                                      ReusableText(
                                        text: profile.email,
                                        style: appStyle(
                                          10,
                                          Colors.white.withOpacity(0.85),
                                          FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  padding: EdgeInsets.all(7.w),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(6.w),
                                  ),
                                  child: Icon(
                                    Feather.edit,
                                    color: Color(kLightBlue.value),
                                    size: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ),
                Positioned(
                  right: 0,
                  left: 0,
                  bottom: 0,
                  top: 100.h,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(kLight.value),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: FutureBuilder(
                      future: userProfile,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const PageLoader();
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text('Error: ${snapshot.error}'),
                          );
                        } else {
                          var profile = snapshot.data;
                          return buildStyleContainer(
                            context,
                            ListView(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              children: [
                                HeightSpacer(size: 0),
                                ReusableText(
                                  text: 'User profile',
                                  style: appStyle(
                                    14,
                                    Color(kDark.value),
                                    FontWeight.w600,
                                  ),
                                ),
                                HeightSpacer(size: 10),
                                Stack(
                                  children: [
                                    Container(
                                      width: width,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 16.w,
                                        vertical: 14.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Color(
                                          kLightGrey.value,
                                        ).withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(
                                          14.w,
                                        ),
                                        border: Border.all(
                                          color: Color(
                                            kDarkGrey.value,
                                          ).withOpacity(0.2),
                                          width: 1,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 56.w,
                                            height: 56.h,
                                            decoration: BoxDecoration(
                                              color: Color(
                                                kOrange.value,
                                              ).withOpacity(0.15),
                                              borderRadius:
                                                  BorderRadius.circular(10.w),
                                            ),
                                            child: const Icon(
                                              FontAwesome5Regular.file_pdf,
                                              color: Colors.red,
                                              size: 28,
                                            ),
                                          ),
                                          WidthSpacer(width: 20),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                ReusableText(
                                                  text: "Upload Resume",
                                                  style: appStyle(
                                                    13,
                                                    Color(kDark.value),
                                                    FontWeight.w600,
                                                  ),
                                                ),
                                                HeightSpacer(size: 3),
                                                ReusableText(
                                                  text:
                                                      "Add your CV in PDF format",
                                                  style: appStyle(
                                                    11,
                                                    Color(kDarkGrey.value),
                                                    FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      right: 12.w,
                                      top: 12.h,
                                      bottom: 12.h,
                                      child: Center(
                                        child: EditButton(OnTap: () {}),
                                      ),
                                    ),
                                  ],
                                ),
                                HeightSpacer(size: 20),
                                SkillsWidget(),
                                HeightSpacer(size: 20),
                                profile!.isAgent
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ReusableText(
                                            text: 'Agent Section',
                                            style: appStyle(
                                              14,
                                              Color(kDark.value),
                                              FontWeight.w600,
                                            ),
                                          ),
                                          HeightSpacer(size: 12),
                                          CustomOutlineBtn(
                                            width: width,
                                            onTap: () {},
                                            color: Color(kNewBlue.value),
                                            text: 'Post a New Job',
                                            hieght: 45.h,
                                          ),
                                          HeightSpacer(size: 12),
                                          CustomOutlineBtn(
                                            width: width,
                                            onTap: () {},
                                            color: Color(kNewBlue.value),
                                            text: 'View My Jobs',
                                            hieght: 45.h,
                                          ),
                                        ],
                                      )
                                    : Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 16.w,
                                          vertical: 12.h,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Color(
                                            kNewBlue.value,
                                          ).withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(
                                            12.w,
                                          ),
                                          border: Border.all(
                                            color: Color(
                                              kOrange.value,
                                            ).withOpacity(0.3),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  ReusableText(
                                                    text: 'Become an Agent',
                                                    style: appStyle(
                                                      13,
                                                      Color(kOrange.value),
                                                      FontWeight.w600,
                                                    ),
                                                  ),
                                                  HeightSpacer(size: 2),
                                                  ReusableText(
                                                    text:
                                                        'Post jobs and find talent',
                                                    style: appStyle(
                                                      11,
                                                      Color(kDarkGrey.value),
                                                      FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Icon(
                                              MaterialCommunityIcons
                                                  .arrow_right,
                                              color: Color(kOrange.value),
                                            ),
                                          ],
                                        ),
                                      ),
                                HeightSpacer(size: 20),
                                CustomOutlineBtn(
                                  text: "Logout",
                                  color: Color(kNewBlue.value),
                                  width: width,
                                  hieght: 48.h,
                                  onTap: () {
                                    loginNotifier.logout();
                                    Get.offAll(() => const Mainscreen());
                                  },
                                ),
                                HeightSpacer(size: 20),
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class CircleAvatar extends StatelessWidget {
  const CircleAvatar({
    super.key,
    required this.image,
    required this.w,
    required this.h,
  });
  final String image;
  final double w;
  final double h;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(99.w)),
      child: image.isEmpty || !image.startsWith('http')
          ? Container(
              width: w,
              height: h,
              decoration: BoxDecoration(
                color: Color(kGreen.value),
                borderRadius: BorderRadius.circular(99.w),
              ),
              child: Icon(Icons.person, size: w * 0.5, color: Colors.white),
            )
          : CachedNetworkImage(
              imageUrl: image,
              width: w,
              height: h,
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator.adaptive()),
              errorWidget: (context, url, error) => Container(
                width: w,
                height: h,
                decoration: BoxDecoration(
                  color: Color(kGreen.value),
                  borderRadius: BorderRadius.circular(99.w),
                ),
                child: Icon(Icons.person, size: w * 0.5, color: Colors.white),
              ),
            ),
    );
  }
}
