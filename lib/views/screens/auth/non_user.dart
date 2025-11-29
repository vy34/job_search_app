import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:job_search_app/views/common/custom_outline_btn.dart';
import 'package:job_search_app/views/common/exports.dart';
import 'package:job_search_app/views/common/height_spacer.dart';
import 'package:job_search_app/views/common/styled_container.dart';
import 'package:job_search_app/views/screens/auth/login.dart';

class NonUser extends StatelessWidget {
  const NonUser({super.key});

  @override
  Widget build(BuildContext context) {
    String imageUrl =
        'https://www.pngall.com/wp-content/uploads/5/User-Profile-PNG-High-Quality-Image.png';
    return buildStyleContainer(
      context,
      Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(90.w)),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              width: 70.w,
              height: 70.w,
            ),
          ),
          const HeightSpacer(size: 20),
          ReusableText(
            text: "To access content please login",
            style: appStyle(20, Color(kDarkGrey.value), FontWeight.normal),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: CustomOutlineBtn(
              text: "Proceed to Login",
              color: Color(kOrange.value),
              width: width,
              hieght: 40.h,
              onTap: () {
                Get.to(() => const LoginPage());
              },
            ),
          ),
        ],
      ),
    );
  }
}
