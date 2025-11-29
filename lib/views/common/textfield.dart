import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_search_app/constants/app_constants.dart';

Widget buildtextfield({
  required String hintText,
  required TextEditingController controller,
  Widget? suffixIcon,
  String? Function(String?)? onSubmit,
  int maxLines = 1,
  TextInputType keyboardType = TextInputType.text,
  bool obscureText = false,
}) {
  return TextFormField(
    controller: controller,
    obscureText: obscureText,
    keyboardType: keyboardType,
    maxLines: maxLines,
    validator: onSubmit,
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Color(kDarkGrey.value)),
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: Color(kDarkGrey.value)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: Color(kDarkGrey.value).withOpacity(0.3)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: Color(kNewBlue.value), width: 1.5),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
    ),
  );
}
