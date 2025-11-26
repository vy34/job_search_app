import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:job_search_app/constants/app_constants.dart';
import 'package:job_search_app/models/response/jobs/jobs_response.dart';
import 'package:job_search_app/views/common/app_style.dart';
import 'package:job_search_app/views/common/custom_outline_btn.dart';
import 'package:job_search_app/views/common/reusable_text.dart';
import 'package:job_search_app/views/screens/jobs/job_detail_page.dart';

class UploadedTitle extends StatelessWidget {
  const UploadedTitle({super.key, required this.job, required this.text});

  final JobsResponse job;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => JobDetailPage(
            title: job.title,
            id: job.id,
            agentName: job.agentName,
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
                          backgroundImage: NetworkImage(job.imageUrl),
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
                                text: job.company,
                                style: appStyle(
                                  15,
                                  Color(kDark.value),
                                  FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 3.h),
                              ReusableText(
                                text: job.title,
                                style: appStyle(
                                  12,
                                  Color(kDarkGrey.value),
                                  FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 3.h),
                              ReusableText(
                                text: "${job.salary} per ${job.period}",
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
                  text == 'popular'
                      ? CustomOutlineBtn(
                          width: 75.w,
                          hieght: 36.h,
                          text: "View",
                          color: Color(kLightBlue.value),
                        )
                      : CustomOutlineBtn(
                          width: 75.w,
                          hieght: 36.h,
                          text: "Apply",
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
