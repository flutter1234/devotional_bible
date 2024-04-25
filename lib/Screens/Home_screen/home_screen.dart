import 'package:devotional_bible/Screens/bible_devotional_screen/bible_devotional_screen.dart';
import 'package:devotional_bible/Screens/bible_stories_screen/bible_stories_screen.dart';
import 'package:devotional_bible/Screens/bible_study_screen/bible_study_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class home_screen extends StatefulWidget {
  static const routeName = '/home_screen';

  const home_screen({super.key});

  @override
  State<home_screen> createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Text(''),
        backgroundColor: Colors.transparent,
        title: Text(
          "Kids Corner",
          style: GoogleFonts.figtree(
            fontSize: 35.sp,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, bible_devotional_screen.routeName);
                setState(() {});
              },
              child: Padding(
                padding: EdgeInsets.all(10.sp),
                child: Container(
                  height: 50.sp,
                  width: 150.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: Colors.black45,
                    border: Border.all(width: 2.w, color: Colors.white),
                  ),
                  child: Center(
                    child: Text(
                      "Devotional",
                      style: GoogleFonts.figtree(
                        fontSize: 25.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, bible_study_screen.routeName);
                setState(() {});
              },
              child: Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: Container(
                  height: 50.sp,
                  width: 150.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: Colors.black45,
                    border: Border.all(width: 2.w, color: Colors.white),
                  ),
                  child: Center(
                    child: Text(
                      "Bible Study",
                      style: GoogleFonts.figtree(
                        fontSize: 25.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, bible_stories_screen.routeName);
                setState(() {});
              },
              child: Container(
                height: 50.sp,
                width: 150.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: Colors.black45,
                  border: Border.all(width: 2.w, color: Colors.white),
                ),
                child: Center(
                  child: Text(
                    "Bible Stories",
                    style: GoogleFonts.figtree(
                      fontSize: 25.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
