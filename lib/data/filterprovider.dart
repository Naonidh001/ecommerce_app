import 'package:flutter/material.dart';

class Filterprovider with ChangeNotifier {
  List<String> selectCat = [];

  bool _isAsc = false;
  bool _isDsc = false;

  bool get isAsc => _isAsc;
  bool get isDsc => _isDsc;

  void addSelectedCat(String cat) {
    selectCat.add(cat);
    notifyListeners();
  }

  void removeCategory(String cat) {
    selectCat.remove(cat);
    notifyListeners();
  }

  void setAsc(bool value) {
    _isAsc = value;
    notifyListeners();
  }

  void setDsc(bool value) {
    _isDsc = value;
    notifyListeners();
  }

  void resetFilter() {
    _isAsc = false;
    _isDsc = false;
    selectCat = [];
    notifyListeners();
  }
}
