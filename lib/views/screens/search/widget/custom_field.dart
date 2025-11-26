import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:job_search_app/constants/app_constants.dart';
import 'package:job_search_app/views/common/app_style.dart';

class CustomField extends StatelessWidget {
  const CustomField({super.key, this.onTap, required this.controller});

  final void Function()? onTap;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      margin: EdgeInsets.only(top: 12.h, left: 12.w, right: 12.w),
      decoration: BoxDecoration(
        color: Color(kLightGrey.value),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Ionicons.chevron_back_circle,
                color: Color(kOrange.value),
                size: 30,
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: Color(kLight.value),
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Search jobs, companies...',
                  hintStyle: appStyle(
                    14,
                    Color(kDarkGrey.value),
                    FontWeight.w500,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 8.h,
                  ),
                  errorBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide(color: Colors.red, width: 0.5),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide(color: Colors.transparent, width: 0),
                  ),
                  focusedErrorBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide(color: Colors.red, width: 0.5),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide(
                      color: Color(kDarkGrey.value),
                      width: 0.5,
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 0.5,
                    ),
                  ),
                  border: InputBorder.none,
                ),
                controller: controller,
                cursorHeight: 25,
                style: appStyle(14, Color(kDark.value), FontWeight.w500),
              ),
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Ionicons.search_circle_outline,
                color: Color(kOrange.value),
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
