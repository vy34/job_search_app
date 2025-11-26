import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_search_app/models/response/jobs/jobs_response.dart';
import 'package:job_search_app/services/helpers/jobs_helper.dart';
import 'package:job_search_app/views/common/loader.dart';
import 'package:job_search_app/views/screens/jobs/widgets/JobsVerticalTile.dart';
import 'package:job_search_app/views/screens/search/widget/custom_field.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90.h),
        child: Padding(
          padding: EdgeInsets.only(top: 20.h),
          child: CustomField(
            controller: searchController,
            onTap: () {
              setState(() {});
            },
          ),
        ),
      ),
      body: searchController.text.isNotEmpty
          ? Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 8.w),
              child: FutureBuilder<List<JobsResponse>>(
                future: JobsHelper.searchJobs(searchController.text),
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
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        var job = jobs[index];
                        return JobsVerticalTile(job: job);
                      },
                    );
                  }
                },
              ),
            )
          : const NoSearchResults(text: 'Search for jobs...'),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
