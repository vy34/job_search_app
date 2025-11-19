import 'package:http/http.dart' as https;
import 'package:job_search_app/models/response/jobs/get_job.dart';
import 'package:job_search_app/models/response/jobs/jobs_response.dart';
import 'package:job_search_app/services/config.dart';

class JobsHelper {
  static var client = https.Client();
}
