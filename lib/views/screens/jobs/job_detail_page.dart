import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:job_search_app/controllers/bookmark_provider.dart';
import 'package:job_search_app/controllers/jobs_provider.dart';
import 'package:job_search_app/controllers/login_provider.dart';
import 'package:job_search_app/models/response/bookmarks/book_res.dart';
import 'package:job_search_app/models/response/jobs/get_job.dart';
import 'package:job_search_app/views/common/BackBtn.dart';
import 'package:job_search_app/views/common/app_bar.dart';
import 'package:job_search_app/views/common/custom_outline_btn.dart';
import 'package:job_search_app/views/common/exports.dart';
import 'package:job_search_app/views/common/height_spacer.dart';
import 'package:job_search_app/views/common/pages_loader.dart';
import 'package:job_search_app/views/common/styled_container.dart';
import 'package:provider/provider.dart';

class JobDetailPage extends StatefulWidget {
  const JobDetailPage({
    super.key,
    required this.title,
    required this.id,
    required this.agentName,
  });

  final String title;
  final String id;
  final String agentName;

  @override
  State<JobDetailPage> createState() => _JobDetailPageState();
}

class _JobDetailPageState extends State<JobDetailPage> {
  late Future<GetJobRes> _jobFuture; //  Future cục bộ

  @override
  void initState() {
    super.initState();
    // Gọi API 1 lần duy nhất khi mở màn
    final jobsNotifier = Provider.of<JobsNotifier>(context, listen: false);
    _jobFuture = jobsNotifier.getJob(widget.id);

    // Kiểm tra bookmark status khi mở detail page
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final bookNotifier = Provider.of<BookNotifier>(context, listen: false);
      bookNotifier.getBookMark(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    var loginProvider = Provider.of<LoginNotifier>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: CustomAppBar(
          actions: [
            loginProvider.loggedIn != false
                ? Consumer<BookNotifier>(
                    builder: (context, bookNotifier, child) {
                      return GestureDetector(
                        onTap: () {
                          if (bookNotifier.bookmark == true) {
                            bookNotifier.deleteBookmark(
                              bookNotifier.bookmarkId,
                            );
                          } else {
                            BookMarkReqRes model = BookMarkReqRes(
                              job: widget.id,
                            );
                            var newModel = bookMarkReqResToJson(model);
                            bookNotifier.addBookmark(newModel);
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.only(right: 12.w),
                          child: Icon(
                            bookNotifier.bookmark == false
                                ? Fontisto.bookmark
                                : Fontisto.bookmark_alt,
                            color: bookNotifier.bookmark == false
                                ? Color(kDark.value)
                                : Color(kOrange.value),
                            size: 22.sp,
                          ),
                        ),
                      );
                    },
                  )
                : SizedBox.shrink(),
          ],
          child: const BackBtn(),
        ),
      ),
      body: buildStyleContainer(
        context,
        FutureBuilder<GetJobRes>(
          future:
              _jobFuture, //  dùng future cục bộ, không dùng jobsNotifier.job
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const PageLoader();
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data == null) {
              return const Center(child: Text('No data available'));
            }

            final job = snapshot.data!;

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Stack(
                children: [
                  ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      Container(
                        width: width,
                        height: hieght * 0.27,
                        decoration: BoxDecoration(
                          color: Color(kLightGrey.value),
                          image: const DecorationImage(
                            image: AssetImage('assets/images/jobs.png'),
                            fit: BoxFit.contain,
                            opacity: 0.5,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(9.w)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //avatar
                            CircleAvatar(
                              radius: 30.w,
                              backgroundImage: NetworkImage(job.imageUrl),
                            ),

                            const HeightSpacer(size: 10),
                            //tile
                            ReusableText(
                              text: job.title,
                              style: appStyle(
                                16,
                                Color(kDark.value),
                                FontWeight.w600,
                              ),
                            ),

                            const HeightSpacer(size: 5),
                            //location
                            ReusableText(
                              text: job.location,
                              style: appStyle(
                                16,
                                Color(kDarkGrey.value),
                                FontWeight.w600,
                              ),
                            ),

                            const HeightSpacer(size: 15),

                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 50),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomOutlineBtn(
                                    width: width * 0.26,
                                    hieght: hieght * 0.04,
                                    text: job.contract,
                                    color: Color(kOrange.value),
                                  ),
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
                                          16,
                                          Color(kDarkGrey.value),
                                          FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      HeightSpacer(size: 20),
                      ReusableText(
                        text: "Description",
                        style: appStyle(
                          16,
                          Color(kDark.value),
                          FontWeight.bold,
                        ),
                      ),
                      HeightSpacer(size: 20),
                      Text(
                        job.description,
                        textAlign: TextAlign.justify,
                        maxLines: 9,
                        style: appStyle(
                          14,
                          Color(kDarkGrey.value),
                          FontWeight.w600,
                        ),
                      ),
                      HeightSpacer(size: 10),
                      ReusableText(
                        text: "Requirements",
                        style: appStyle(
                          16,
                          Color(kDark.value),
                          FontWeight.bold,
                        ),
                      ),
                      HeightSpacer(size: 10),
                      SizedBox(
                        height: hieght * 0.6,
                        child: ListView.builder(
                          itemCount: job.requirements.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            var requirement = job.requirements[index];
                            String bullet =
                                "\u2022 "; // Unicode for bullet point
                            return Padding(
                              padding: EdgeInsets.only(bottom: 12.w),
                              child: Text(
                                "$bullet$requirement",
                                style: appStyle(
                                  14,
                                  Color(kDarkGrey.value),
                                  FontWeight.w600,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 20.0.w),
                      child: CustomOutlineBtn(
                        text: loginProvider.loggedIn == false
                            ? "Please Login"
                            : "Apply Now",
                        hieght: hieght * 0.06,
                        color: Color(kLight.value),
                        color2: Color(kOrange.value),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
