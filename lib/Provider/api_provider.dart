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
  List lessonComplete = [];
  List featuredList = [];
  List popularList = [];
  late String url;


  Future<void> devotionalData(var Url) async {
    var url = Uri.parse(Url);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      devotionalList = json.decode(utf8.decode(response.bodyBytes));
      notifyListeners();
    }
    // print("devotionalList ==========>>>>${devotionalList}");
    notifyListeners();
  }

  Future<void> studyData(var Url) async {
    var url = Uri.parse(Url);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      bibleStudyList = json.decode(utf8.decode(response.bodyBytes));
      notifyListeners();
    }
    // print("bibleStudyList ==========>>>>${bibleStudyList}");
    notifyListeners();
  }

  Future<void> storiesData(var Url) async {
    var url = Uri.parse(Url);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      bibleStoriesList = json.decode(utf8.decode(response.bodyBytes));
      notifyListeners();
    }
    // print("bibleStudyList ==========>>>>${bibleStoriesList}");
    notifyListeners();
  }

  Future<void> launchurl() async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch ${Uri.parse(url)}');
    }
  }
}
