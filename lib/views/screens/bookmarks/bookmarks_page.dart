import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:job_search_app/constants/app_constants.dart';
import 'package:job_search_app/controllers/bookmark_provider.dart';
import 'package:job_search_app/controllers/login_provider.dart';
import 'package:job_search_app/models/response/bookmarks/all_bookmarks.dart';
import 'package:job_search_app/views/common/app_bar.dart';
import 'package:job_search_app/views/common/drawer/drawer_widget.dart';
import 'package:job_search_app/views/common/pages_loader.dart';
import 'package:job_search_app/views/common/styled_container.dart';
import 'package:job_search_app/views/screens/auth/non_user.dart';
import 'package:job_search_app/views/screens/auth/profile_page.dart';
import 'package:job_search_app/views/screens/bookmarks/widgets/bookmark_title.dart';
import 'package:provider/provider.dart';

class BookmarksPage extends StatefulWidget {
  const BookmarksPage({super.key});

  @override
  State<BookmarksPage> createState() => _BookmarksPageState();
}

class _BookmarksPageState extends State<BookmarksPage> {
  late Future<List<AllBookMarks>> bookmarks;

  @override
  void initState() {
    super.initState();
    var bookNotifier = Provider.of<BookNotifier>(context, listen: false);
    bookmarks = bookNotifier.getBookmarks();
  }

  @override
  Widget build(BuildContext context) {
    var loginNotifier = Provider.of<LoginNotifier>(context);
    return Scaffold(
      backgroundColor: Color(kNewBlue.value),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          color: Color(kNewBlue.value),
          text: !loginNotifier.loggedIn ? "" : 'Bookmarks',
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
            child: DrawerWidget(color: Color(kLight.value)),
          ),
        ),
      ),

      body: loginNotifier.loggedIn == false
          ? NonUser()
          : Consumer<BookNotifier>(
              builder: (context, bookNotifier, child) {
                return Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 15.h),
                        decoration: BoxDecoration(
                          color: Color(kGreen.value),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.w),
                            topRight: Radius.circular(20.w),
                          ),
                        ),
                        child: buildStyleContainer(
                          context,
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: FutureBuilder<List<AllBookMarks>>(
                              future: bookmarks,
                              builder: ((context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const PageLoader();
                                } else if (snapshot.hasError) {
                                  return Text("Error: ${snapshot.error}");
                                } else {
                                  var processedBookmarks = snapshot.data;
                                  return ListView.builder(
                                    itemCount: processedBookmarks?.length ?? 0,
                                    itemBuilder: (context, index) {
                                      var bookmark = processedBookmarks![index];
                                      return BookmarkTitle(bookmark: bookmark);
                                    },
                                  );
                                }
                              }),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }
}
