import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:job_search_app/constants/app_constants.dart';
import 'package:job_search_app/models/response/bookmarks/all_bookmarks.dart';
import 'package:job_search_app/views/common/app_style.dart';
import 'package:job_search_app/views/common/custom_outline_btn.dart';
import 'package:job_search_app/views/common/reusable_text.dart';
import 'package:job_search_app/views/screens/jobs/job_detail_page.dart';

class BookmarkTitle extends StatelessWidget {
  const BookmarkTitle({super.key, required this.bookmark});

  final AllBookMarks bookmark;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => JobDetailPage(
            title: bookmark.job.title,
            id: bookmark.job.id,
            agentName: bookmark.job.agentName,
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 8.h, right: 4.w),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: Color(kLightGrey.value),
            borderRadius: BorderRadius.all(Radius.circular(9.w)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundImage: NetworkImage(bookmark.job.imageUrl),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: 2.h),
                              ReusableText(
                                text: bookmark.job.company,
                                style: appStyle(
                                  15,
                                  Color(kDark.value),
                                  FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 3.h),
                              ReusableText(
                                text: bookmark.job.title,
                                style: appStyle(
                                  12,
                                  Color(kDarkGrey.value),
                                  FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 3.h),
                              ReusableText(
                                text:
                                    "${bookmark.job.salary} per ${bookmark.job.period}",
                                style: appStyle(
                                  12,
                                  Color(kDarkGrey.value),
                                  FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8.w),
                  CustomOutlineBtn(
                    width: 75.w,
                    hieght: 36.h,
                    text: "View",
                    color: Color(kLightBlue.value),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
