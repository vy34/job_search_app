import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_search_app/constants/app_constants.dart';
import 'package:job_search_app/models/response/bookmarks/all_bookmarks.dart';
import 'package:job_search_app/services/helpers/book_helper.dart';

class BookNotifier extends ChangeNotifier {
  late Future<List<AllBookMarks>> bookmarks;
  bool _bookmark = false;
  bool get bookmark => _bookmark;

  set isBookmark(bool newState) {
    if (_bookmark != newState) {
      _bookmark = newState;
      notifyListeners();
    }
  }

  String _bookmarkId = '';
  String get bookmarkId => _bookmarkId;

  set isBookmarkId(String newState) {
    if (_bookmarkId != newState) {
      _bookmarkId = newState;
      notifyListeners();
    }
  }

  addBookmark(String model) {
    BookMarkHelper.addBookmark(model)
        .then((bookmark) {
          isBookmark = true;
          isBookmarkId = bookmark.bookmarkId;
          print("Bookmark added: ${bookmark.bookmarkId}");
          Get.snackbar(
            "Bookmark Added",
            "Job added to your bookmarks",
            colorText: Color(kLight.value),
            backgroundColor: Colors.green,
          );
        })
        .catchError((e) {
          print("Add bookmark error: $e");
          Get.snackbar(
            "Error",
            "Failed to add bookmark",
            colorText: Color(kLight.value),
            backgroundColor: Color(kOrange.value),
          );
        });
  }

  getBookMark(String jobId) {
    BookMarkHelper.getBookmark(jobId)
        .then((value) {
          if (value == null) {
            isBookmark = false;
            isBookmarkId = '';
          } else {
            isBookmark = true;
            isBookmarkId = value.bookmarkId;
          }
        })
        .catchError((e) {
          print("Get bookmark error: $e");
          isBookmark = false;
          isBookmarkId = '';
        });
  }

  deleteBookmark(String bookmarkId) {
    BookMarkHelper.deleteBookmarks(bookmarkId)
        .then((success) {
          if (success) {
            isBookmark = false;
            isBookmarkId = '';
            print("Bookmark deleted successfully");
            Get.snackbar(
              "Bookmark Deleted",
              "Bookmark removed from your list",
              colorText: Color(kLight.value),
              backgroundColor: Color(kOrange.value),
              icon: const Icon(Icons.bookmark_remove_outlined),
            );
          } else {
            Get.snackbar(
              "Error",
              "Failed to delete bookmark",
              colorText: Color(kLight.value),
              backgroundColor: Color(kOrange.value),
            );
          }
        })
        .catchError((e) {
          print("Delete bookmark error: $e");
          Get.snackbar(
            "Error",
            "Failed to delete bookmark",
            colorText: Color(kLight.value),
            backgroundColor: Color(kOrange.value),
          );
        });
  }

  Future<List<AllBookMarks>> getBookmarks() {
    bookmarks = BookMarkHelper.getAllBookmark();
    return bookmarks;
  }
}
