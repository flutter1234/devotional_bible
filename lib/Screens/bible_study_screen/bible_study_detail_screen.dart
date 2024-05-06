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
    // print("correctCount ======>>>${dataProvider.bibleStudyList['Bible Study'][widget.oneDataStudy]['title']}");
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
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                HexColor('9165ff'),
                HexColor('b48bfe'),
              ],
            ),
          ),
          child: BannerWrapper(
            parentContext: context,
            child: Scaffold(
              body: Padding(
                padding: EdgeInsets.only(
                  top: isIpad
                      ? 30.h
                      : isSmall
                          ? 35.h
                          : 45.h,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: isIpad
                                ? 65.sp
                                : isSmall
                                    ? 80.sp
                                    : 90.sp,
                            width: isIpad
                                ? 65.w
                                : isSmall
                                    ? 80.w
                                    : 90.w,
                            decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black, border: Border.all(width: 2.w, color: Colors.white)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(isIpad ? 48.r : 42.r),
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
                              height: isIpad
                                  ? 40.sp
                                  : isSmall
                                      ? 40.sp
                                      : 45.sp,
                              width: isIpad
                                  ? 40.w
                                  : isSmall
                                      ? 40.w
                                      : 45.w,
                              decoration: BoxDecoration(
                                border: Border.all(width: 1.w, color: Colors.white),
                                color: HexColor('622663'),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.close,
                                  size: isIpad
                                      ? 25.sp
                                      : isSmall
                                          ? 25.sp
                                          : 30.sp,
                                  color: Colors.white70,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: isIpad ? 5.h : 10.h),
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
                            fontSize: isIpad
                                ? 16.sp
                                : isSmall
                                    ? 18.sp
                                    : 20.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: isIpad ? 15.w : 25.w, right: isIpad ? 15.w : 25.w, top: isIpad ? 5.h : 10.h),
                      child: Text(
                        textAlign: TextAlign.center,
                        "${dataProvider.bibleStudyList['Bible Study'][widget.oneDataStudy]['title']}",
                        style: GoogleFonts.figtree(
                          fontSize: isIpad
                              ? 20.sp
                              : isSmall
                                  ? 26.sp
                                  : 28.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: isIpad
                            ? 5.h
                            : isSmall
                                ? 10.h
                                : 20.h,
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
                      padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: isIpad ? 5.sp : 20.sp),
                      child: Text(
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        "${dataProvider.bibleStudyList['Bible Study'][widget.oneDataStudy]['Note']}",
                        style: GoogleFonts.figtree(
                          fontSize: isIpad
                              ? 15.sp
                              : isSmall
                                  ? 18.sp
                                  : 20.sp,
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
                        height: isIpad
                            ? 40.sp
                            : isSmall
                                ? 45.sp
                                : 55.sp,
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
                              fontSize: isIpad
                                  ? 18.sp
                                  : isSmall
                                      ? 20.sp
                                      : 22.sp,
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
          ),
        );
      },
    );
  }
}
