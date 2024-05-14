import 'package:devotional_bible/Screens/Ebook_screen/ebook_detail_screen.dart';
import 'package:devotional_bible/Screens/Ebook_screen/ebook_pdf_view_screen.dart';
import 'package:devotional_bible/Screens/Ebook_screen/ebook_screen.dart';
import 'package:devotional_bible/Screens/Home_screen/home_screen.dart';
import 'package:devotional_bible/Screens/Setting_screen/setting_screen.dart';
import 'package:devotional_bible/Screens/Splash_screen/splash_screen.dart';
import 'package:devotional_bible/Screens/bible_devotional_screen/bible_devotional_screen.dart';
import 'package:devotional_bible/Screens/bible_devotional_screen/devotional_detail_screen.dart';
import 'package:devotional_bible/Screens/bible_stories_screen/bible_stories_detail_screen.dart';
import 'package:devotional_bible/Screens/bible_stories_screen/devotional_bible_view_screen.dart';
import 'package:devotional_bible/Screens/bible_stories_screen/pdf_view_screen.dart';
import 'package:devotional_bible/Screens/bible_study_screen/bible_study_detail_screen.dart';
import 'package:devotional_bible/Screens/bible_study_screen/bible_study_quiz_screen.dart';
import 'package:devotional_bible/Screens/bible_study_screen/bible_study_screen.dart';
import 'package:flutter/material.dart';
import '../Screens/bible_stories_screen/bible_stories_screen.dart';

class Router {
  static MaterialPageRoute onRouteGenrator(settings) {
    switch (settings.name) {
      case splash_screen.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const splash_screen(),
        );
      case home_screen.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const home_screen(),
        );
      case bible_devotional_screen.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const bible_devotional_screen(),
        );
      case devotional_detail_screen.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => devotional_detail_screen(
            oneData: settings.arguments['oneData'],
          ),
        );
      case bible_study_screen.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => bible_study_screen(),
        );
      case bible_study_detail_screen.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => bible_study_detail_screen(
            oneDataStudy: settings.arguments['oneDataStudy'],
          ),
        );
      case bible_study_quiz_screen.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => bible_study_quiz_screen(
            oneDataQuiz: settings.arguments['QuizData'],
          ),
        );
      case bible_stories_screen.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => bible_stories_screen(),
        );
      case bible_stories_detail_screen.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => bible_stories_detail_screen(
            oneStories: settings.arguments['oneStories'],
          ),
        );
      case devotional_bible_view_screen.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => devotional_bible_view_screen(
            viewData: settings.arguments['View All'],
            keyName: settings.arguments['KeyName'],
          ),
        );
      case pdf_view_screen.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => pdf_view_screen(
            pdf: settings.arguments,
          ),
        );
      case setting_screen.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => setting_screen(),
        );
      case ebook_screen.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => ebook_screen(),
        );
      case ebook_detail_screen.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => ebook_detail_screen(
            oneDataEbook: settings.arguments['oneDataEbook'],
            index: settings.arguments['index'],
          ),
        );
      case ebook_pdf_view_screen.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => ebook_pdf_view_screen(
            pdf: settings.arguments,
          ),
        );
      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const Material(
            child: Center(
              child: Text("404 page not founded"),
            ),
          ),
        );
    }
  }
}
