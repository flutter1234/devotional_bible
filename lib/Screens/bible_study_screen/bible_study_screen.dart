import 'package:cached_network_image/cached_network_image.dart';
import 'package:devotional_bible/Provider/api_provider.dart';
import 'package:devotional_bible/Screens/bible_study_screen/bible_study_detail_screen.dart';
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
    context.read<Api>().studyData().then((value) {
      isLoading = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Api dataProvider = Provider.of<Api>(context, listen: true);
    return Scaffold(
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
                      Navigator.pushNamed(context, bible_study_detail_screen.routeName, arguments: {
                        "oneDataStudy": index,
                      });
                      print("oneData ===========>>>>>${dataProvider.bibleStudyList['Bible Study'][index]}");
                    },
                    child: Container(
                      height: 220.sp,
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
                              height: 150.sp,
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
                          Padding(
                            padding: EdgeInsets.only(left: 10.w, top: 5.h, bottom: 5.h),
                            child: Text(
                              "${dataProvider.bibleStudyList['Bible Study'][index]['title']}",
                              style: GoogleFonts.figtree(
                                fontSize: 22.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.w),
                            child: Text(
                              "Lesson ${index + 1}",
                              style: GoogleFonts.figtree(
                                fontSize: 20.sp,
                                color: Colors.white70,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
