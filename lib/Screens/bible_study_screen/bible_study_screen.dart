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

    context.read<Api>().studyData().then((value) {
      dataProvider.lessonComplete = storage.read("lessonComplete") ?? [];
      print("lessonComplete ===========>>>>${dataProvider.lessonComplete}");
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
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.transparent,
          title: Text(
            "God\'s Big Story",
            style: GoogleFonts.figtree(
              fontSize: 25.sp,
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
                          Container(
                            height: 225.sp,
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
                                    height: 140.sp,
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
                                Spacer(),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15.sp),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Lesson ${index + 1}",
                                              style: GoogleFonts.figtree(
                                                fontSize: 20.sp,
                                                color: Colors.white70,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                            Text(
                                              "${dataProvider.bibleStudyList['Bible Study'][index]['title']}",
                                              style: GoogleFonts.figtree(
                                                fontSize: 22.sp,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                            SizedBox(height: 5.h),
                                          ],
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
                                Spacer(),
                              ],
                            ),
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
