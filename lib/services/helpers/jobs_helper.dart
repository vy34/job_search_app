import 'package:http/http.dart' as https;
import 'package:job_search_app/models/response/jobs/get_job.dart';
import 'package:job_search_app/models/response/jobs/jobs_response.dart';
import 'package:job_search_app/services/config.dart';

class JobsHelper {
  static var client = https.Client();

  static Future<List<JobsResponse>> getJobs() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    var url = Uri.parse("${Config.apiUrl}${Config.jobs}");
    // print(url);
    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var jobList = jobsResponseFromJson(response.body);
      return jobList;
    } else {
      throw Exception('Failed to load jobs');
    }
  }

  static Future<GetJobRes> getJob(String jobId) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    var url = Uri.parse("${Config.apiUrl}${Config.jobs}/$jobId");
    print('Fetching job from URL: $url');
    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var job = getJobResFromJson(response.body);
      return job;
    } else {
      print('Error: Status ${response.statusCode}, Body: ${response.body}');
      throw Exception('Failed to load job: ${response.statusCode}');
    }
  }

  static Future<List<JobsResponse>> getRecentJobs() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    var url = Uri.parse("${Config.apiUrl}${Config.jobs}?new=true");
    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var jobList = jobsResponseFromJson(response.body);
      return jobList;
    } else {
      throw Exception('Failed to load jobs');
    }
  }

  static Future<List<JobsResponse>> searchJobs(String query) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    var url = Uri.parse("${Config.apiUrl}${Config.search}/$query");
    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var jobList = jobsResponseFromJson(response.body);
      return jobList;
    } else {
      throw Exception('Failed to load jobs');
    }
  }
}
