import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class Api extends ChangeNotifier {
  Map devotionalList = {};
  Map bibleStudyList = {};
  Map bibleStoriesList = {};
  int questionIndex = 0;
  int correctCount = 0;
  List keyList = [];
  List subKeyList = [];

  Future<void> devotionalData() async {
    var url = Uri.parse("https://coinspinmaster.com/viral/iosapp/bible/kids bible/KC Devotional.json");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      // devotionalList = jsonDecode(response.body);
      devotionalList = json.decode(utf8.decode(response.bodyBytes));
      notifyListeners();
    }
    print("devotionalList ==========>>>>${devotionalList}");
    notifyListeners();
  }

  Future<void> studyData() async {
    var url = Uri.parse("https://coinspinmaster.com/viral/iosapp/bible/kids bible/Bible Study.json");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      bibleStudyList = json.decode(utf8.decode(response.bodyBytes));
      notifyListeners();
    }
    // print("bibleStudyList ==========>>>>${bibleStudyList}");
    notifyListeners();
  }

  Future<void> storiesData() async {
    var url = Uri.parse("https://coinspinmaster.com/viral/iosapp/bible/kids bible/Bible Stories.json");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      bibleStoriesList = json.decode(utf8.decode(response.bodyBytes));
      notifyListeners();
    }
    print("bibleStudyList ==========>>>>${bibleStoriesList}");
    notifyListeners();
  }
}
