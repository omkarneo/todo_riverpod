import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DropdownModel extends ChangeNotifier {
  String updatedialog = "";
  String createdialog = "AT HOME";

  void updatedialogchanger(value) {
    updatedialog = value;
    notifyListeners();
  }

  void createdialogchanger(value) {
    createdialog = value;
    notifyListeners();
  }
}

class TodoModel extends ChangeNotifier {
  List sharedstorage = [];

  void setdata(data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? alltodo = prefs.getStringList('mytodo');
    if (alltodo == null) {
      prefs.setStringList("mytodo", []);
    } else {
      String encode = json.encode(data);
      alltodo.add(encode);
      prefs.setStringList("mytodo", alltodo);
      notifyListeners();
    }
  }

  void clearall() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Remove data for the 'counter' key.
    await prefs.remove('mytodo');

    prefs.setStringList("mytodo", []);
    sharedstorage = [];
    notifyListeners();
  }

  void updatedata(data, index) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? alltodos = prefs.getStringList("mytodo");
    if (alltodos == null) {
      prefs.setStringList("mytodo", []);
    } else {
      String encode = json.encode(data);
      alltodos[index] = encode;
      prefs.setStringList("mytodo", alltodos);

      notifyListeners();
    }
  }

  void getdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List? alltodos = prefs.getStringList("mytodo");
    if (alltodos == null) {
      prefs.setStringList("mytodo", []);
    } else {
      // return all
      sharedstorage = alltodos;
      notifyListeners();
    }
  }

  void deleteData(int index) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? alltodo = prefs.getStringList('mytodo');
    if (alltodo == null) {
      prefs.setStringList("mytodo", []);
    } else {
      alltodo.removeAt(index);
      prefs.setStringList("mytodo", alltodo);
      notifyListeners();
    }
  }
}
