import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_search_app/constants/app_constants.dart';
import 'package:job_search_app/controllers/jobs_provider.dart';
import 'package:job_search_app/models/response/jobs/jobs_response.dart';
import 'package:job_search_app/views/common/loader.dart';
import 'package:job_search_app/views/screens/jobs/widgets/JobsHorizontalTile.dart';
import 'package:job_search_app/views/screens/jobs/job_detail_page.dart';
import 'package:provider/provider.dart';

class PopularJobs extends StatelessWidget {
  const PopularJobs({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<JobsNotifier>(
      builder: (context, jobsNotifier, child) {
        jobsNotifier.getJobs();
        return SizedBox(
          height: hieght * 0.25,
          child: FutureBuilder<List<JobsResponse>>(
            future: jobsNotifier.jobsList,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
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
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    var job = jobs[index];
                    return JobsHorizontalTile(
                      job: job,
                      onTap: () {
                        Get.to(
                          () => JobDetailPage(
                            title: job.title,
                            id: job.id,
                            agentName: job.agentName,
                          ),
                        );
                      },
                    );
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
