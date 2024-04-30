import 'package:cached_network_image/cached_network_image.dart';
import 'package:devotional_bible/AdPlugin/Ads/Banner/BannerWrapper.dart';
import 'package:devotional_bible/AdPlugin/Ads/FullScreen/Ads.dart';
import 'package:devotional_bible/AdPlugin/Ads/Native/NativeRN.dart';
import 'package:devotional_bible/Provider/api_provider.dart';
import 'package:devotional_bible/Screens/bible_study_screen/bible_study_detail_screen.dart';
import 'package:devotional_bible/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../AdPlugin/MainJson/MainJson.dart';

class bible_study_screen extends StatefulWidget {
  static const routeName = '/bible_study_screen';

  const bible_study_screen({super.key});

  @override
  State<bible_study_screen> createState() => _bible_study_screenState();
}

class _bible_study_screenState extends State<bible_study_screen> {
  bool isLoading = true;

  @override
  void initState() {
    Api dataProvider = Provider.of<Api>(context, listen: false);
    context.read<Api>().studyData(context.read<MainJson>().data!['assets']['bibleStudy']).then((value) {
      dataProvider.lessonComplete = storage.read("lessonComplete") ?? [];
      // print("lessonComplete ===========>>>>${dataProvider.lessonComplete}");
      isLoading = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Api dataProvider = Provider.of<Api>(context, listen: true);
    return BannerWrapper(
      parentContext: context,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 35.sp,
          leadingWidth: 50.w,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              size: isIpad
                  ? 23.sp
                  : isSmall
                      ? 23.sp
                      : 25.sp,
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.transparent,
          title: Text(
            "God\'s Big Story",
            style: GoogleFonts.figtree(
              fontSize: isIpad
                  ? 20.sp
                  : isSmall
                      ? 23.sp
                      : 25.sp,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: isLoading
            ? Center(
                child: CupertinoActivityIndicator(
                  color: Colors.white,
                  radius: 10.r,
                ),
              )
            : ListView.builder(
                itemCount: dataProvider.bibleStudyList['Bible Study'].length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 10.sp),
                    child: GestureDetector(
                      onTap: () {
                        AdsRN().showFullScreen(
                          context: context,
                          onComplete: () {
                            Navigator.pushNamed(context, bible_study_detail_screen.routeName, arguments: {
                              "oneDataStudy": index,
                            }).then((value) {
                              setState(() {});
                            });
                          },
                        );
                        // print("oneData ===========>>>>>${dataProvider.bibleStudyList['Bible Study'][index]}");
                      },
                      child: Column(
                        children: [
                          index == 1 ? NativeRN(parentContext: context) : SizedBox(),
                          Stack(
                            alignment: Alignment.topLeft,
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: index % 2 != 0 ? 0 : 30.h, bottom: index % 2 == 0 ? 0 : 30.h),
                                height: isIpad
                                    ? 150.sp
                                    : isSmall
                                        ? 180.sp
                                        : 180.sp,
                                width: 1.sw,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  color: Colors.black45,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(9.r),
                                      child: CachedNetworkImage(
                                        height: isIpad
                                            ? 150.sp
                                            : isSmall
                                                ? 180.sp
                                                : 180.sp,
                                        width: 1.sw,
                                        imageUrl: dataProvider.bibleStudyList['Bible Study'][index]['thumble'],
                                        fit: BoxFit.cover,
                                        errorWidget: (context, url, error) => Container(
                                          child: Center(
                                            child: Icon(
                                              Icons.error,
                                              color: Colors.white,
                                              size: 25.sp,
                                            ),
                                          ),
                                        ),
                                        placeholder: (context, url) => Container(
                                          child: Center(
                                            child: CupertinoActivityIndicator(
                                              color: Colors.white,
                                              radius: 5.r,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                left: index % 2 == 0 ? 0 : null,
                                bottom: index % 2 != 0 ? 0 : null,
                                right: index % 2 != 0 ? 0 : null,
                                child: Stack(
                                  alignment: Alignment.centerLeft,
                                  clipBehavior: Clip.none,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 25, left: 30.w),
                                      height: 75.sp,
                                      width: 210.w,
                                      decoration: BoxDecoration(
                                        color: dataProvider.lessonComplete.contains(dataProvider.bibleStudyList['Bible Study'][index]['title']) ? Colors.yellow.shade700 : Colors.black,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 20.w),
                                      height: 75.sp,
                                      width: 210.w,
                                      decoration: BoxDecoration(
                                        color: dataProvider.lessonComplete.contains(dataProvider.bibleStudyList['Bible Study'][index]['title']) ? Colors.white : Colors.yellow.shade700,
                                        border: Border.all(width: 1.w, color: Colors.black),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 30.w),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Lesson ${index + 1}",
                                              style: GoogleFonts.figtree(
                                                fontSize: isIpad
                                                    ? 16.sp
                                                    : isSmall
                                                        ? 18.sp
                                                        : 17.sp,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                            Text(
                                              "${dataProvider.bibleStudyList['Bible Study'][index]['title']}",
                                              style: GoogleFonts.amaranth(
                                                fontSize: isIpad
                                                    ? 15.sp
                                                    : isSmall
                                                        ? 16.sp
                                                        : 17.sp,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    dataProvider.lessonComplete.contains(dataProvider.bibleStudyList['Bible Study'][index]['title'])
                                        ? Container(
                                            height: 45.sp,
                                            width: 45.w,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white,
                                              border: Border.all(width: 4.w, color: Colors.green.shade700),
                                            ),
                                            child: Icon(
                                              Icons.check,
                                              size: 25.sp,
                                              color: Colors.green,
                                            ),
                                          )
                                        : SizedBox.shrink(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
