import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:job_search_app/models/response/jobs/jobs_response.dart';
import 'package:job_search_app/views/common/exports.dart';
import 'package:job_search_app/views/screens/jobs/job_detail_page.dart';

class JobsVerticalTile extends StatelessWidget {
  const JobsVerticalTile({super.key, required this.job});

  final JobsResponse job;
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
        padding: EdgeInsets.only(bottom: 8.h, right: 8.w),
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
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: Color(kLight.value),
                    child: Icon(
                      Icons.arrow_forward,
                      color: Color(kDark.value),
                      size: 18,
                    ),
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
