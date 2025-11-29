import 'dart:convert';
import 'package:http/http.dart' as https;
import 'package:job_search_app/models/request/bookmarks/bookmarks_model.dart';
import 'package:job_search_app/models/response/bookmarks/all_bookmarks.dart';
import 'package:job_search_app/models/response/bookmarks/bookmark.dart';
import 'package:job_search_app/services/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookMarkHelper {
  static var client = https.Client();
  static Future<BookMark> addBookmark(String model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'authorization': 'Bearer $token',
    };
    var url = Uri.parse("${Config.apiUrl}${Config.bookmarkUrl}");

    try {
      var response = await client.post(
        url,
        headers: requestHeaders,
        body: model,
      );

      if (response.statusCode == 201) {
        var bookmark = bookMarkFromJson(response.body);
        return bookmark;
      } else {
        throw Exception('Failed to add bookmark: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Add bookmark failed: $e');
    }
  }

  static Future<List<AllBookMarks>> getAllBookmark() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'authorization': 'Bearer $token',
    };
    var url = Uri.parse("${Config.apiUrl}${Config.bookmarkUrl}");

    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200 || response.statusCode == 201) {
      var bookmarks = allBookMarksFromJson(response.body);
      return bookmarks;
    } else {
      throw Exception('Failed to fetch bookmarks');
    }
  }

  static Future<BookMark?> getBookmark(String jobId) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        print("No token found");
        return null;
      }
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
        'authorization': 'Bearer $token',
      };
      var url = Uri.parse("${Config.apiUrl}${Config.singleBookmarkUrl}/$jobId");
      print("Getting bookmark from: $url");

      var response = await client.get(url, headers: requestHeaders);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        // Backend trả về { status: true/false, bookmarkId: '...' }
        if (jsonData['status'] == true || jsonData['status'] == 'true') {
          var bookmark = bookMarkFromJson(response.body);
          return bookmark;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<bool> deleteBookmarks(String bookmarkId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    try {
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
        'authorization': 'Bearer $token',
      };
      var url = Uri.parse(
        "${Config.apiUrl}${Config.deleteBookmarkUrl}/$bookmarkId",
      );

      var response = await client.delete(url, headers: requestHeaders);

      if (response.statusCode == 200 || response.statusCode == 204) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
