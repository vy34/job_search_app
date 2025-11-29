import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_search_app/constants/app_constants.dart';

class EditButton extends StatelessWidget {
  const EditButton({super.key, required this.OnTap});
  final void Function() OnTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: OnTap,
      child: Container(
        padding: EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: Color(kOrange.value),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(9),
            bottomRight: Radius.circular(9),
          ),
        ),
        child: Center(
          child: Text(
            'Edit',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
