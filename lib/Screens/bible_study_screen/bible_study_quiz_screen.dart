import 'package:cached_network_image/cached_network_image.dart';
import 'package:devotional_bible/AdPlugin/Ads/Banner/BannerWrapper.dart';
import 'package:devotional_bible/AdPlugin/Ads/FullScreen/Ads.dart';
import 'package:devotional_bible/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import '../../Provider/api_provider.dart';

class bible_study_quiz_screen extends StatefulWidget {
  static const routeName = '/bible_study_quiz_screen';
  final oneDataQuiz;

  const bible_study_quiz_screen({super.key, required this.oneDataQuiz});

  @override
  State<bible_study_quiz_screen> createState() => _bible_study_quiz_screenState();
}

class _bible_study_quiz_screenState extends State<bible_study_quiz_screen> {
  bool submitButton = false;
  int selectedAnswerIndex = 0;
  String selectAnswer = "";
  var correctAnswerIndex;
  bool tryAgain = false;
  bool colorChange = false;
  bool hintDialog = false;
  bool continueDialog = false;
  bool completeDialog = false;
  bool answerTap = true;

  @override
  void initState() {
    Api dataProvider = Provider.of<Api>(context, listen: false);
    dataProvider.correctCount = storage.read(dataProvider.bibleStudyList['Bible Study'][widget.oneDataQuiz]['title']) ?? 0;
    print(dataProvider.bibleStudyList['Bible Study'][widget.oneDataQuiz]['title']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Api dataProvider = Provider.of<Api>(context, listen: true);
    return BannerWrapper(
      parentContext: context,
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: isIpad
                    ? 30.h
                    : isSmall
                        ? 35.h
                        : 45.h,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black,
                              border: Border.all(width: 2.w, color: Colors.white),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(isIpad ? 48.r : 42.r),
                              child: CachedNetworkImage(
                                imageUrl: dataProvider.bibleStudyList['Bible Study'][widget.oneDataQuiz]['thumble'],
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
                          itemCount: dataProvider.bibleStudyList['Bible Study'][widget.oneDataQuiz]['qna'].length,
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
                            fontSize: isSmall ? 18.sp : 20.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: isIpad ? 15.w : 25.w, right: isIpad ? 15.w : 25.w, top: isIpad ? 5.h : 10.h),
                      child: Text(
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        "${dataProvider.bibleStudyList['Bible Study'][widget.oneDataQuiz]['title']}",
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
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.sp,
                        vertical: isIpad
                            ? 5.sp
                            : isSmall
                                ? 8.sp
                                : 20.sp,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: Colors.black45,
                          border: Border.all(width: 2.w, color: Colors.white70),
                        ),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.sp,
                                vertical: isIpad
                                    ? 10.sp
                                    : isSmall
                                        ? 10.sp
                                        : 20.sp),
                            child: Text(
                              textAlign: TextAlign.center,
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              "${dataProvider.bibleStudyList['Bible Study'][widget.oneDataQuiz]['qna'][dataProvider.questionIndex]['Question']}",
                              style: GoogleFonts.figtree(
                                fontSize: isIpad
                                    ? 16.sp
                                    : isSmall
                                        ? 17.sp
                                        : 20.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.all(0),
                      itemCount: dataProvider.bibleStudyList['Bible Study'][widget.oneDataQuiz]['qna'][dataProvider.questionIndex]['answers'].length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 5.sp),
                          child: GestureDetector(
                            onTap: () {
                              if (answerTap == true) {
                                selectedAnswerIndex = index;
                                selectAnswer = dataProvider.bibleStudyList['Bible Study'][widget.oneDataQuiz]['qna'][dataProvider.questionIndex]['answers'][selectedAnswerIndex];
                                correctAnswerIndex = dataProvider.bibleStudyList['Bible Study'][widget.oneDataQuiz]['qna'][dataProvider.questionIndex]['answer'];
                                submitButton = true;
                                colorChange = false;
                              }
                              setState(() {});
                            },
                            child: Container(
                              height: isIpad
                                  ? 40.sp
                                  : isSmall
                                      ? 45.sp
                                      : 50.sp,
                              width: 1.sw,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.r),
                                color: Colors.black54,
                                border: Border.all(width: 1.5.w, color: submitButton && selectedAnswerIndex == index && colorChange ? Colors.green : Colors.white),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.w),
                                child: Row(
                                  children: [
                                    Container(
                                      height: isIpad
                                          ? 15.sp
                                          : isSmall
                                              ? 15.sp
                                              : 20.sp,
                                      width: isIpad
                                          ? 15.w
                                          : isSmall
                                              ? 15.w
                                              : 20.w,
                                      decoration: BoxDecoration(
                                        color: Colors.black26,
                                        border: Border.all(width: 0.5.w, color: Colors.white),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(isIpad
                                            ? 3.sp
                                            : isSmall
                                                ? 3.sp
                                                : 4.sp),
                                        child: submitButton && selectedAnswerIndex == index
                                            ? Container(
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: colorChange ? Colors.green : Colors.purple.shade500,
                                                ),
                                              )
                                            : SizedBox(),
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                    Expanded(
                                      child: Text(
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        "${dataProvider.bibleStudyList['Bible Study'][widget.oneDataQuiz]['qna'][dataProvider.questionIndex]['answers'][index]}",
                                        style: GoogleFonts.figtree(
                                          fontSize: isIpad
                                              ? 14.sp
                                              : isSmall
                                                  ? 15.sp
                                                  : 16.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    // Spacer(),
                    SizedBox(height: 20.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              hintDialog = !hintDialog;
                              setState(() {});
                            },
                            child: Container(
                              height: isIpad
                                  ? 45.sp
                                  : isSmall
                                      ? 50.sp
                                      : 60.sp,
                              width: 120.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(width: 2.w, color: Colors.white),
                              ),
                              child: Center(
                                child: Text(
                                  "HINT?",
                                  style: GoogleFonts.figtree(
                                    fontSize: isIpad
                                        ? 20.sp
                                        : isSmall
                                            ? 22.sp
                                            : 24.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          if (submitButton == true) ...{
                            GestureDetector(
                              onTap: () {
                                answerTap = false;
                                if (selectedAnswerIndex + 1 == correctAnswerIndex) {
                                  submitButton = false;
                                  colorChange = true;
                                  continueDialog = true;
                                } else {
                                  submitButton = false;
                                  colorChange = true;
                                  tryAgain = true;
                                }
                                setState(() {});
                              },
                              child: Container(
                                height: isIpad
                                    ? 45.sp
                                    : isSmall
                                        ? 50.sp
                                        : 60.sp,
                                width: 150.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  border: Border.all(width: 2.w, color: Colors.white),
                                ),
                                child: Center(
                                  child: Text(
                                    "SUBMIT ANSWER",
                                    style: GoogleFonts.figtree(
                                      fontSize: isIpad
                                          ? 15.sp
                                          : isSmall
                                              ? 16.sp
                                              : 17.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          } else if (tryAgain == true) ...{
                            GestureDetector(
                              onTap: () {
                                tryAgain = false;
                                colorChange = false;
                                answerTap = true;
                                setState(() {});
                              },
                              child: Container(
                                height: isIpad
                                    ? 45.sp
                                    : isSmall
                                        ? 50.sp
                                        : 60.sp,
                                width: 150.w,
                                decoration: BoxDecoration(
                                  color: HexColor('f02767'),
                                  borderRadius: BorderRadius.circular(8.r),
                                  border: Border.all(width: 2.w, color: Colors.white),
                                ),
                                child: Center(
                                  child: Text(
                                    "TRY AGAIN",
                                    style: GoogleFonts.figtree(
                                      fontSize: isIpad
                                          ? 20.sp
                                          : isSmall
                                              ? 22.sp
                                              : 24.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          } else if (continueDialog == true) ...{
                            GestureDetector(
                              onTap: () {
                                AdsRN().showFullScreen(
                                  context: context,
                                  onComplete: () {
                                    answerTap = true;
                                    dataProvider.correctCount++;
                                    setState(() {});
                                    storage.write(dataProvider.bibleStudyList['Bible Study'][widget.oneDataQuiz]['title'], dataProvider.correctCount);
                                    if (dataProvider.questionIndex < dataProvider.bibleStudyList['Bible Study'][widget.oneDataQuiz]['qna'].length - 1) {
                                      dataProvider.questionIndex++;
                                      continueDialog = false;
                                      colorChange = false;
                                    }
                                    if (dataProvider.correctCount == dataProvider.bibleStudyList['Bible Study'][widget.oneDataQuiz]['qna'].length) {
                                      completeDialog = true;
                                    }
                                    setState(() {});
                                  },
                                );
                              },
                              child: Container(
                                height: isIpad
                                    ? 45.sp
                                    : isSmall
                                        ? 50.sp
                                        : 60.sp,
                                width: 150.w,
                                decoration: BoxDecoration(
                                  color: HexColor('047b52'),
                                  borderRadius: BorderRadius.circular(8.r),
                                  border: Border.all(width: 2.w, color: Colors.white),
                                ),
                                child: Center(
                                  child: Text(
                                    "CONTINUE",
                                    style: GoogleFonts.figtree(
                                      fontSize: isIpad
                                          ? 20.sp
                                          : isSmall
                                              ? 20.sp
                                              : 22.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          },
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h)
                    // Spacer(),
                  ],
                ),
              ),
            ),
            hintDialog == true
                ? Positioned(
                    bottom: 140.h,
                    left: 20.w,
                    right: 20.w,
                    child: Container(
                      height: isIpad
                          ? 45.sp
                          : isSmall
                              ? 50.sp
                              : 60.sp,
                      width: 1.sw,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.sp),
                        child: Row(
                          children: [
                            Container(
                              height: isIpad
                                  ? 30.sp
                                  : isSmall
                                      ? 30.sp
                                      : 35.sp,
                              width: isIpad
                                  ? 30.w
                                  : isSmall
                                      ? 30.w
                                      : 35.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.r),
                                color: Colors.white,
                              ),
                              child: Icon(
                                Icons.info,
                                size: isIpad
                                    ? 20.sp
                                    : isSmall
                                        ? 22.sp
                                        : 25.sp,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Text(
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                "${dataProvider.bibleStudyList['Bible Study'][widget.oneDataQuiz]['qna'][dataProvider.questionIndex]['Hint']}",
                                style: GoogleFonts.figtree(
                                  fontSize: isIpad
                                      ? 15.sp
                                      : isSmall
                                          ? 16.sp
                                          : 18.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : SizedBox(),
            tryAgain == true
                ? Positioned(
                    bottom: 130.h,
                    left: 20.w,
                    right: 20.w,
                    child: Container(
                      height: isIpad
                          ? 45.sp
                          : isSmall
                              ? 50.sp
                              : 60.sp,
                      width: 1.sw,
                      decoration: BoxDecoration(
                        color: HexColor('f02767'),
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.sp),
                        child: Row(
                          children: [
                            Container(
                              height: isIpad
                                  ? 30.sp
                                  : isSmall
                                      ? 30.sp
                                      : 35.sp,
                              width: isIpad
                                  ? 30.w
                                  : isSmall
                                      ? 30.w
                                      : 35.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.r),
                                color: Colors.white,
                              ),
                              child: Icon(
                                Icons.replay,
                                size: isIpad
                                    ? 20.sp
                                    : isSmall
                                        ? 22.sp
                                        : 25.sp,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Text(
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                "Oops! Wrong Answer\nTry again?",
                                style: GoogleFonts.figtree(
                                  fontSize: isIpad
                                      ? 15.sp
                                      : isSmall
                                          ? 16.sp
                                          : 18.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : SizedBox(),
            continueDialog == true
                ? Positioned(
                    bottom: 130.h,
                    left: 20.w,
                    right: 20.w,
                    child: Container(
                      height: isIpad
                          ? 45.sp
                          : isSmall
                              ? 50.sp
                              : 60.sp,
                      width: 1.sw,
                      decoration: BoxDecoration(
                        color: HexColor('047b52'),
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.sp),
                        child: Row(
                          children: [
                            Container(
                              height: isIpad
                                  ? 30.sp
                                  : isSmall
                                      ? 30.sp
                                      : 35.sp,
                              width: isIpad
                                  ? 30.w
                                  : isSmall
                                      ? 30.w
                                      : 35.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.r),
                                color: Colors.white,
                              ),
                              child: Icon(
                                Icons.star,
                                size: isSmall ? 20.sp : 25.sp,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Text(
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                "Yes! Right Answer",
                                style: GoogleFonts.figtree(
                                  fontSize: isIpad
                                      ? 15.sp
                                      : isSmall
                                          ? 16.sp
                                          : 18.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : SizedBox(),
            completeDialog == true || dataProvider.correctCount == dataProvider.bibleStudyList['Bible Study'][widget.oneDataQuiz]['qna'].length
                ? Container(
                    color: Colors.black26,
                  )
                : SizedBox(),
            completeDialog == true || dataProvider.correctCount == dataProvider.bibleStudyList['Bible Study'][widget.oneDataQuiz]['qna'].length
                ? Positioned(
                    left: 15.w,
                    right: 15.w,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 2.w, color: Colors.black),
                        color: HexColor('fed44f'),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                        child: Column(
                          children: [
                            Image(
                              height: isIpad
                                  ? 45.sp
                                  : isSmall
                                      ? 50.sp
                                      : 60.sp,
                              width: isIpad
                                  ? 45.w
                                  : isSmall
                                      ? 50.w
                                      : 60.w,
                              image: AssetImage('assets/images/completeDialog.png'),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: isSmall ? 10.h : 20.h),
                              child: Text(
                                "YOU COMPLETED LESSON",
                                style: GoogleFonts.figtree(
                                  fontSize: isIpad
                                      ? 20.sp
                                      : isSmall
                                          ? 22.sp
                                          : 24.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: isSmall ? 10.h : 20.h, left: 10.w, right: 10.w),
                              child: Text(
                                textAlign: TextAlign.center,
                                maxLines: 5,
                                "${dataProvider.bibleStudyList['Bible Study'][widget.oneDataQuiz]['Note']}",
                                style: GoogleFonts.figtree(
                                  fontSize: isIpad
                                      ? 18.sp
                                      : isSmall
                                          ? 20.sp
                                          : 22.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 15.h, left: 15.w, right: 15.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      dataProvider.correctCount = 0;
                                      storage.write(
                                        dataProvider.bibleStudyList['Bible Study'][widget.oneDataQuiz]['title'],
                                        dataProvider.correctCount,
                                      );
                                      completeDialog = false;
                                      dataProvider.questionIndex = 0;
                                      Navigator.pushReplacementNamed(context, bible_study_quiz_screen.routeName, arguments: {
                                        "QuizData": widget.oneDataQuiz,
                                      });
                                      setState(() {});
                                    },
                                    child: Container(
                                      height: 45.sp,
                                      width: 140.w,
                                      decoration: BoxDecoration(
                                        color: Colors.black54,
                                        border: Border.all(width: 1.w, color: Colors.black),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 5.sp),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.restart_alt_outlined,
                                              size: isIpad
                                                  ? 24.sp
                                                  : isSmall
                                                      ? 25.sp
                                                      : 27.sp,
                                              color: Colors.white,
                                            ),
                                            SizedBox(width: 8.w),
                                            Text(
                                              textAlign: TextAlign.center,
                                              maxLines: 5,
                                              "RESTART",
                                              style: GoogleFonts.figtree(
                                                fontSize: isIpad
                                                    ? 18.sp
                                                    : isSmall
                                                        ? 18.sp
                                                        : 20.sp,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      AdsRN().showFullScreen(
                                        context: context,
                                        onComplete: () {
                                          if (dataProvider.bibleStudyList['Bible Study'].length - 1 == widget.oneDataQuiz) {
                                            if (!dataProvider.lessonComplete.contains(dataProvider.bibleStudyList['Bible Study'][widget.oneDataQuiz]['title'])) {
                                              dataProvider.lessonComplete.add(dataProvider.bibleStudyList['Bible Study'][widget.oneDataQuiz]['title']);
                                            }
                                            storage.write("lessonComplete", dataProvider.lessonComplete);
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                            setState(() {});
                                          } else {
                                            if (!dataProvider.lessonComplete.contains(dataProvider.bibleStudyList['Bible Study'][widget.oneDataQuiz]['title'])) {
                                              dataProvider.lessonComplete.add(dataProvider.bibleStudyList['Bible Study'][widget.oneDataQuiz]['title']);
                                            }
                                            storage.write("lessonComplete", dataProvider.lessonComplete);
                                            print("lessonComplete ========>>>${dataProvider.lessonComplete}");
                                            dataProvider.questionIndex = 0;
                                            Navigator.pushReplacementNamed(context, bible_study_quiz_screen.routeName, arguments: {
                                              "QuizData": widget.oneDataQuiz + 1,
                                            }).then((value) {
                                              setState(() {});
                                            });
                                            setState(() {});
                                          }
                                        },
                                      );
                                    },
                                    child: Container(
                                      height: 45.sp,
                                      width: 140.w,
                                      decoration: BoxDecoration(
                                        color: Colors.black54,
                                        border: Border.all(width: 1.w, color: Colors.black),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 5.sp),
                                        child: Row(
                                          children: [
                                            Icon(
                                              dataProvider.bibleStudyList['Bible Study'].length - 1 == widget.oneDataQuiz ? Icons.arrow_back_outlined : Icons.skip_next,
                                              size: isIpad
                                                  ? 24.sp
                                                  : isSmall
                                                      ? 25.sp
                                                      : 30.sp,
                                              color: Colors.white,
                                            ),
                                            SizedBox(width: 15.w),
                                            Text(
                                              textAlign: TextAlign.center,
                                              maxLines: 5,
                                              dataProvider.bibleStudyList['Bible Study'].length - 1 == widget.oneDataQuiz ? "BACK" : "NEXT",
                                              style: GoogleFonts.figtree(
                                                fontSize: isIpad
                                                    ? 18.sp
                                                    : isSmall
                                                        ? 18.sp
                                                        : 20.sp,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
