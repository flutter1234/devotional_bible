import 'package:devotional_bible/AdPlugin/Ads/Banner/BannerWrapper.dart';
import 'package:devotional_bible/AdPlugin/Ads/FullScreen/Ads.dart';
import 'package:devotional_bible/Screens/Ebook_screen/ebook_screen.dart';
import 'package:devotional_bible/Screens/Setting_screen/setting_screen.dart';
import 'package:devotional_bible/Screens/bible_devotional_screen/bible_devotional_screen.dart';
import 'package:devotional_bible/Screens/bible_stories_screen/bible_stories_screen.dart';
import 'package:devotional_bible/Screens/bible_study_screen/bible_study_screen.dart';
import 'package:devotional_bible/main.dart';
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
    return BannerWrapper(
      parentContext: context,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 35.sp,
          leadingWidth: 50.w,
          leading: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, setting_screen.routeName);
              setState(() {});
            },
            child: Icon(
              size: isIpad
                  ? 23.sp
                  : isSmall
                      ? 23.sp
                      : 25.sp,
              Icons.settings,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.transparent,
          title: Text(
            "Kids Corner",
            style: GoogleFonts.figtree(
              fontSize: isIpad
                  ? 24.sp
                  : isSmall
                      ? 30.sp
                      : 32.sp,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.sp),
          child: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    AdsRN().showFullScreen(
                      context: context,
                      onComplete: () {
                        Navigator.pushNamed(context, bible_devotional_screen.routeName);
                      },
                    );
                    setState(() {});
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: isIpad ? 5.sp : 10.sp),
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Container(
                          height: isSmall
                              ? 160.sp
                              : isIpad
                                  ? 155.sp
                                  : 180.sp,
                          width: 1.sw,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(width: 3.w, color: Colors.black54),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(isIpad ? 5.r : 7.r),
                            child: Image.asset(fit: BoxFit.fill, "assets/images/devotional_home.png"),
                          ),
                        ),
                        Positioned(
                          bottom: 10.h,
                          right: 20.w,
                          child: Text(
                            textAlign: TextAlign.center,
                            "Kids Corner \n DEVOTIONAL",
                            style: GoogleFonts.lobster(
                              fontSize: isIpad
                                  ? 22.sp
                                  : isSmall
                                      ? 22.sp
                                      : 25.sp,
                              color: Colors.yellow.shade700,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: isIpad ? 5.sp : 10.sp),
                  child: GestureDetector(
                    onTap: () {
                      AdsRN().showFullScreen(
                        context: context,
                        onComplete: () {
                          Navigator.pushNamed(context, bible_study_screen.routeName);
                        },
                      );
                      setState(() {});
                    },
                    child: Stack(
                      children: [
                        Container(
                          height: isSmall
                              ? 160.sp
                              : isIpad
                                  ? 155.sp
                                  : 180.sp,
                          width: 1.sw,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(width: 3.w, color: Colors.black54),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(isIpad ? 5.r : 7.r),
                            child: Image.asset(fit: BoxFit.fill, "assets/images/bible_study_home.png"),
                          ),
                        ),
                        Positioned(
                          top: 10.h,
                          left: 10.w,
                          child: Text(
                            textAlign: TextAlign.start,
                            "GOD\'S BIG \n STORIES",
                            style: GoogleFonts.lobster(
                              fontSize: isIpad
                                  ? 22.sp
                                  : isSmall
                                      ? 22.sp
                                      : 25.sp,
                              color: Colors.yellow.shade700,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: isIpad ? 5.sp : 10.sp),
                  child: GestureDetector(
                    onTap: () {
                      AdsRN().showFullScreen(
                        context: context,
                        onComplete: () {
                          Navigator.pushNamed(context, bible_stories_screen.routeName);
                        },
                      );
                      setState(() {});
                    },
                    child: Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        Container(
                          height: isSmall
                              ? 160.sp
                              : isIpad
                                  ? 155.sp
                                  : 180.sp,
                          width: 1.sw,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(width: 3.w, color: Colors.black54),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(isIpad ? 5.r : 7.r),
                            child: Image.asset(fit: BoxFit.fill, "assets/images/bible_stories_home.png"),
                          ),
                        ),
                        Positioned(
                          bottom: 10.h,
                          right: 20.w,
                          child: Text(
                            textAlign: TextAlign.center,
                            "BIBLE\n STORIES",
                            style: GoogleFonts.lobster(
                              fontSize: isIpad
                                  ? 22.sp
                                  : isSmall
                                      ? 25.sp
                                      : 28.sp,
                              color: Colors.yellow.shade700,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: isIpad ? 5.sp : 10.sp),
                  child: GestureDetector(
                    onTap: () {
                      AdsRN().showFullScreen(
                        context: context,
                        onComplete: () {
                          Navigator.pushNamed(context, ebook_screen.routeName);
                        },
                      );
                      setState(() {});
                    },
                    child: Stack(
                      children: [
                        Container(
                          height: isSmall
                              ? 160.sp
                              : isIpad
                                  ? 155.sp
                                  : 180.sp,
                          width: 1.sw,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(width: 3.w, color: Colors.black54),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(isIpad ? 5.r : 7.r),
                            child: Image.asset(fit: BoxFit.fill, "assets/images/ebook_home.png"),
                          ),
                        ),
                        Positioned(
                          top: 10.h,
                          left: 10.w,
                          child: Text(
                            textAlign: TextAlign.center,
                            "GOD\'S BIG \n EBOOK",
                            style: GoogleFonts.lobster(
                              fontSize: isIpad
                                  ? 22.sp
                                  : isSmall
                                      ? 22.sp
                                      : 25.sp,
                              color: Colors.yellow.shade700,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
