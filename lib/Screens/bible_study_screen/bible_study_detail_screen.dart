import 'package:cached_network_image/cached_network_image.dart';
import 'package:devotional_bible/AdPlugin/Ads/Banner/BannerWrapper.dart';
import 'package:devotional_bible/AdPlugin/Ads/FullScreen/Ads.dart';
import 'package:devotional_bible/Screens/bible_study_screen/bible_study_quiz_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../Provider/api_provider.dart';
import '../../main.dart';

class bible_study_detail_screen extends StatefulWidget {
  static const routeName = '/bible_study_detail_screen';
  final oneDataStudy;

  const bible_study_detail_screen({super.key, required this.oneDataStudy});

  @override
  State<bible_study_detail_screen> createState() => _bible_study_detail_screenState();
}

class _bible_study_detail_screenState extends State<bible_study_detail_screen> {
  YoutubePlayerController? controller;

  @override
  void initState() {
    Api dataProvider = Provider.of<Api>(context, listen: false);
    dataProvider.correctCount = storage.read(dataProvider.bibleStudyList['Bible Study'][widget.oneDataStudy]['title']) ?? 0;
    print("correctCount ======>>>${dataProvider.bibleStudyList['Bible Study'][widget.oneDataStudy]['title']}");
    controller = YoutubePlayerController(
      initialVideoId: '${YoutubePlayer.convertUrlToId(dataProvider.bibleStudyList['Bible Study'][widget.oneDataStudy]['videourl'])}',
      flags: YoutubePlayerFlags(
        autoPlay: false,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Api dataProvider = Provider.of<Api>(context, listen: true);
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: controller!,
        progressColors: ProgressBarColors(
          backgroundColor: Colors.white70,
          playedColor: Colors.green,
          bufferedColor: Colors.grey,
          handleColor: Colors.green,
        ),
      ),
      builder: (context, player) {
        return BannerWrapper(
          parentContext: context,
          child: Scaffold(
            // appBar: AppBar(
            //   leading: GestureDetector(
            //     onTap: () {
            //       Navigator.pop(context);
            //     },
            //     child: Icon(
            //       Icons.arrow_back_ios,
            //       color: Colors.white,
            //     ),
            //   ),
            //   backgroundColor: Colors.transparent,
            //   title: Text(
            //     "${widget.oneDataStudy['title']}",
            //     style: GoogleFonts.figtree(
            //       fontSize: 25.sp,
            //       color: Colors.white,
            //       fontWeight: FontWeight.w700,
            //     ),
            //   ),
            // ),
            body: Padding(
              padding: EdgeInsets.only(top: 45.h),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 90.sp,
                          width: 90.w,
                          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black, border: Border.all(width: 2.w, color: Colors.white)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(42.r),
                            child: CachedNetworkImage(
                              imageUrl: dataProvider.bibleStudyList['Bible Study'][widget.oneDataStudy]['thumble'],
                              fit: BoxFit.fill,
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
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            setState(() {});
                          },
                          child: Container(
                            height: 45.sp,
                            width: 45.w,
                            decoration: BoxDecoration(
                              border: Border.all(width: 1.w, color: Colors.white),
                              color: HexColor('622663'),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Icon(
                                Icons.close,
                                size: 30.sp,
                                color: Colors.white70,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.h),
                  SizedBox(
                    height: 20.sp,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.only(left: 15.w),
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: dataProvider.bibleStudyList['Bible Study'][widget.oneDataStudy]['qna'].length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 2.w),
                                child: Icon(
                                  Icons.star_rate,
                                  size: 20.sp,
                                  color: dataProvider.correctCount > index ? Colors.yellow : Colors.grey.shade400,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.w),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Correct Answer",
                        style: GoogleFonts.figtree(
                          fontSize: 20.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 25.w, right: 25.w, top: 10.h),
                    child: Text(
                      "${dataProvider.bibleStudyList['Bible Study'][widget.oneDataStudy]['title']}",
                      style: GoogleFonts.figtree(
                        fontSize: 30.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 20.h,
                      left: 15.w,
                      right: 15.w,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 2.w, color: Colors.black54),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(9.r),
                        child: player,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 20.sp),
                    child: Text(
                      "${dataProvider.bibleStudyList['Bible Study'][widget.oneDataStudy]['Note']}",
                      style: GoogleFonts.figtree(
                        fontSize: 24.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      AdsRN().showFullScreen(
                        context: context,
                        onComplete: () {
                          Navigator.pushNamed(context, bible_study_quiz_screen.routeName, arguments: {
                            "QuizData": widget.oneDataStudy,
                          }).then((value) {
                            dataProvider.correctCount = storage.read(dataProvider.bibleStudyList['Bible Study'][widget.oneDataStudy]['title']) ?? 0;

                            setState(() {});
                          });
                        },
                      );
                      // print(widget.oneDataStudy);
                    },
                    child: Container(
                      height: 55.sp,
                      width: 150.w,
                      decoration: BoxDecoration(
                        color: Colors.black45,
                        border: Border.all(width: 1.w, color: Colors.white),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Center(
                        child: Text(
                          "START QUIZ!",
                          style: GoogleFonts.figtree(
                            fontSize: 22.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
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
    );
  }
}
