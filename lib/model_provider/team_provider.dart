import 'package:flutter/material.dart';

class TeamProvider extends ChangeNotifier {
  List _teamList;
  get teamList => _teamList;
  set teamList(teams) {
    _teamList = teams;
    notifyListeners();
  }
}
