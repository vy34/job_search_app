import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_search_app/controllers/jobs_provider.dart';
import 'package:job_search_app/models/response/jobs/jobs_response.dart';
import 'package:job_search_app/views/common/loader.dart';
import 'package:job_search_app/views/screens/jobs/widgets/JobsVerticalTile.dart';
import 'package:provider/provider.dart';

class RecentList extends StatelessWidget {
  const RecentList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<JobsNotifier>(
      builder: (context, jobsNotifier, child) {
        jobsNotifier.getRecentJobs();
        return FutureBuilder<List<JobsResponse>>(
          future: jobsNotifier.recentJobsList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator.adaptive());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.data!.isEmpty) {
              return const NoSearchResults(text: " No popular jobs available ");
            } else {
              final jobs = snapshot.data!;
              return ListView.builder(
                itemCount: jobs.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                itemBuilder: (context, index) {
                  var job = jobs[index];
                  return JobsVerticalTile(job: job);
                },
              );
            }
          },
        );
      },
    );
  }
}
