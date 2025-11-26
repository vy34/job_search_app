import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_search_app/constants/app_constants.dart';
import 'package:job_search_app/controllers/jobs_provider.dart';
import 'package:job_search_app/models/response/jobs/jobs_response.dart';
import 'package:job_search_app/views/common/loader.dart';
import 'package:job_search_app/views/common/pages_loader.dart';
import 'package:job_search_app/views/screens/jobs/widgets/uploaded_title.dart';
import 'package:provider/provider.dart';

class PopularJobsList extends StatelessWidget {
  const PopularJobsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<JobsNotifier>(
      builder: (context, jobsNotifier, child) {
        jobsNotifier.getJobs();
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0.w),
          child: FutureBuilder<List<JobsResponse>>(
            future: jobsNotifier.jobsList,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const PageLoader();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.data!.isEmpty) {
                return const NoSearchResults(
                  text: " No popular jobs available ",
                );
              } else {
                final jobs = snapshot.data!;
                return ListView.builder(
                  itemCount: jobs.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    var job = jobs[index];
                    return UploadedTitle(job: job, text: 'popular');
                  },
                );
              }
            },
          ),
        );
      },
    );
  }
}
