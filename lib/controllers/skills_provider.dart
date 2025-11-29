import 'package:flutter/material.dart';
import 'package:job_search_app/models/response/auth/skills.dart';

class SkillsNotifier with ChangeNotifier {
  bool _addSkills = false;
  bool get addSkills => _addSkills;
  set setSkills(bool newState) {
    _addSkills = newState;
    notifyListeners();
  }

  String _addSkillsId = '';
  String get addSkillsId => _addSkillsId;
  set setSkillsId(String newState) {
    _addSkillsId = newState;
    notifyListeners();
  }
}
