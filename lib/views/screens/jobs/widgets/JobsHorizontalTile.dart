import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_search_app/models/response/jobs/jobs_response.dart';
import 'package:job_search_app/views/common/exports.dart';
import 'package:job_search_app/views/common/height_spacer.dart';
import 'package:job_search_app/views/common/width_spacer.dart';

class JobsHorizontalTile extends StatelessWidget {
  const JobsHorizontalTile({super.key, this.onTap, required this.job});

  final void Function()? onTap;
  final JobsResponse job;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(right: 12.w),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(12.w)),
          child: Container(
            height: hieght * 0.27,
            width: width * 0.75,
            constraints: BoxConstraints(maxWidth: width * 0.85),
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.w),
            decoration: BoxDecoration(
              color: Color(kLightGrey.value),
              image: DecorationImage(
                image: AssetImage('assets/images/jobs.png'),
                fit: BoxFit.contain,
                opacity: 0.5,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(job.imageUrl),
                    ),
                    const WidthSpacer(width: 10),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: Color(kLight.value),
                          borderRadius: BorderRadius.all(Radius.circular(16.w)),
                        ),
                        child: ReusableText(
                          text: job.company,
                          style: appStyle(
                            16,
                            Color(kDark.value),
                            FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const HeightSpacer(size: 12),
                ReusableText(
                  text: job.title,
                  style: appStyle(16, Color(kDark.value), FontWeight.w600),
                ),
                const HeightSpacer(size: 4),
                ReusableText(
                  text: job.location,
                  style: appStyle(14, Color(kDarkGrey.value), FontWeight.w500),
                ),
                const HeightSpacer(size: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ReusableText(
                          text: job.salary,
                          style: appStyle(
                            16,
                            Color(kDark.value),
                            FontWeight.w600,
                          ),
                        ),
                        ReusableText(
                          text: "/${job.period}",
                          style: appStyle(
                            14,
                            Color(kDarkGrey.value),
                            FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: Color(kLight.value),
                      child: Icon(Icons.arrow_forward, size: 18),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
