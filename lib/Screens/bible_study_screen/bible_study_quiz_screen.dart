import 'package:cached_network_image/cached_network_image.dart';
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
    print("correctCount ====>>>${dataProvider.correctCount}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Api dataProvider = Provider.of<Api>(context, listen: true);
    return Scaffold(
      // appBar: AppBar(
      //   leading: GestureDetector(
      //     onTap: () {
      //       Navigator.pop(context);
      //       setState(() {});
      //     },
      //     child: Icon(
      //       Icons.arrow_back_ios,
      //       color: Colors.white,
      //     ),
      //   ),
      //   backgroundColor: Colors.transparent,
      //   title: Text(
      //     "${widget.oneDataQuiz['title']}",
      //     style: GoogleFonts.figtree(
      //       fontSize: 25.sp,
      //       color: Colors.white,
      //       fontWeight: FontWeight.w700,
      //     ),
      //   ),
      // ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
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
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
                          border: Border.all(
                            width: 2.w,
                            color: Colors.white,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(42.r),
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
                          height: 45.sp,
                          width: 120.w,
                          decoration: BoxDecoration(
                            border: Border.all(width: 0.5.w, color: Colors.white),
                            color: HexColor('622663'),
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.sp),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.close,
                                  size: 25.sp,
                                  color: Colors.white70,
                                ),
                                SizedBox(width: 10.w),
                                Text(
                                  "CLOSE",
                                  style: GoogleFonts.figtree(
                                    fontSize: 24.sp,
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w700,
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
                    "${dataProvider.bibleStudyList['Bible Study'][widget.oneDataQuiz]['title']}",
                    style: GoogleFonts.figtree(
                      fontSize: 30.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                // SizedBox(
                //   height: 20.sp,
                //   child: Align(
                //     alignment: Alignment.centerRight,
                //     child: ListView.builder(
                //       shrinkWrap: true,
                //       padding: EdgeInsets.only(right: 16.w),
                //       physics: NeverScrollableScrollPhysics(),
                //       scrollDirection: Axis.horizontal,
                //       itemCount: widget.oneDataQuiz['qna'].length,
                //       itemBuilder: (context, index) {
                //         return Column(
                //           children: [
                //             Padding(
                //               padding: EdgeInsets.only(left: 2.w),
                //               child: Icon(
                //                 Icons.star_rate,
                //                 size: 20.sp,
                //                 color: Colors.grey.shade400,
                //               ),
                //             ),
                //           ],
                //         );
                //       },
                //     ),
                //   ),
                // ),
                // Padding(
                //   padding: EdgeInsets.only(right: 10.w),
                //   child: Align(
                //     alignment: Alignment.centerRight,
                //     child: Text(
                //       "Correct Answer",
                //       style: GoogleFonts.figtree(
                //         fontSize: 20.sp,
                //         color: Colors.white,
                //         fontWeight: FontWeight.w500,
                //       ),
                //     ),
                //   ),
                // ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 20.sp),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: Colors.black45,
                      border: Border.all(
                        width: 2.w,
                        color: Colors.white70,
                      ),
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 20.sp),
                        child: Text(
                          textAlign: TextAlign.center,
                          "${dataProvider.bibleStudyList['Bible Study'][widget.oneDataQuiz]['qna'][dataProvider.questionIndex]['Question']}",
                          style: GoogleFonts.figtree(
                            fontSize: 22.sp,
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
                            print("${!answerTap}");
                            selectedAnswerIndex = index;
                            selectAnswer = dataProvider.bibleStudyList['Bible Study'][widget.oneDataQuiz]['qna'][dataProvider.questionIndex]['answers'][selectedAnswerIndex];
                            correctAnswerIndex = dataProvider.bibleStudyList['Bible Study'][widget.oneDataQuiz]['qna'][dataProvider.questionIndex]['answer'];
                            submitButton = true;
                            colorChange = false;
                          }
                          setState(() {});
                        },
                        child: Container(
                          height: 50.sp,
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
                                  height: 20.sp,
                                  width: 20.w,
                                  decoration: BoxDecoration(
                                    color: Colors.black26,
                                    border: Border.all(width: 0.5.w, color: Colors.white),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(4.sp),
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
                                      fontSize: 18.sp,
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
                Spacer(),
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
                          height: 60.sp,
                          width: 120.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(width: 2.w, color: Colors.white),
                          ),
                          child: Center(
                            child: Text(
                              "HINT?",
                              style: GoogleFonts.figtree(
                                fontSize: 25.sp,
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
                            height: 60.sp,
                            width: 150.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(width: 2.w, color: Colors.white),
                            ),
                            child: Center(
                              child: Text(
                                "SUBMIT ANSWER",
                                style: GoogleFonts.figtree(
                                  fontSize: 20.sp,
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
                            height: 60.sp,
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
                                  fontSize: 25.sp,
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
                            answerTap = true;
                            dataProvider.correctCount++;
                            storage.write(dataProvider.bibleStudyList['Bible Study'][widget.oneDataQuiz]['title'], dataProvider.correctCount);
                            if (dataProvider.questionIndex < dataProvider.bibleStudyList['Bible Study'][widget.oneDataQuiz]['qna'].length - 1) {
                              dataProvider.questionIndex++;
                              print("correctCount =======>>>${dataProvider.correctCount}");
                              continueDialog = false;
                              colorChange = false;
                            }
                            if (dataProvider.correctCount == dataProvider.bibleStudyList['Bible Study'][widget.oneDataQuiz]['qna'].length) {
                              completeDialog = true;
                            }
                            setState(() {});
                          },
                          child: Container(
                            height: 60.sp,
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
                                  fontSize: 22.sp,
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
                Spacer(),
              ],
            ),
          ),
          hintDialog == true
              ? Positioned(
                  bottom: 140.h,
                  left: 20.w,
                  right: 20.w,
                  child: Container(
                    height: 60.sp,
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
                            height: 35.sp,
                            width: 35.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.r),
                              color: Colors.white,
                            ),
                            child: Icon(
                              Icons.info,
                              size: 25.sp,
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
                                fontSize: 18.sp,
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
                    height: 60.sp,
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
                            height: 35.sp,
                            width: 35.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.r),
                              color: Colors.white,
                            ),
                            child: Icon(
                              Icons.replay,
                              size: 25.sp,
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
                                fontSize: 20.sp,
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
                    height: 60.sp,
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
                            height: 35.sp,
                            width: 35.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.r),
                              color: Colors.white,
                            ),
                            child: Icon(
                              Icons.star,
                              size: 25.sp,
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
                                fontSize: 25.sp,
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
                    height: 300.sp,
                    width: 1.sw,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2.w,
                        color: Colors.black,
                      ),
                      color: HexColor('fed44f'),
                      // borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: Column(
                        children: [
                          Image(
                            height: 60.sp,
                            width: 60.w,
                            image: AssetImage('assets/images/completeDialog.png'),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20.h),
                            child: Text(
                              "YOU COMPLETED LESSON",
                              style: GoogleFonts.figtree(
                                fontSize: 25.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20.h, left: 10.w, right: 10.w),
                            child: Text(
                              textAlign: TextAlign.center,
                              maxLines: 5,
                              "${dataProvider.bibleStudyList['Bible Study'][widget.oneDataQuiz]['Note']}",
                              style: GoogleFonts.figtree(
                                fontSize: 22.sp,
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
                                    storage.write(dataProvider.bibleStudyList['Bible Study'][widget.oneDataQuiz]['title'], dataProvider.correctCount);
                                    completeDialog = false;
                                    dataProvider.questionIndex = 0;
                                    Navigator.pushReplacementNamed(context, bible_study_quiz_screen.routeName, arguments: {
                                      "QuizData": widget.oneDataQuiz,
                                    });
                                    setState(() {});
                                  },
                                  child: Container(
                                    height: 45.sp,
                                    width: 130.w,
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
                                            size: 30.sp,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 8.w),
                                          Text(
                                            textAlign: TextAlign.center,
                                            maxLines: 5,
                                            "RESTART",
                                            style: GoogleFonts.figtree(
                                              fontSize: 20.sp,
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
                                    Navigator.pushReplacementNamed(context, bible_study_quiz_screen.routeName, arguments: {
                                      "QuizData": widget.oneDataQuiz + 1,
                                    });
                                  },
                                  child: Container(
                                    height: 45.sp,
                                    width: 130.w,
                                    decoration: BoxDecoration(
                                      color: Colors.black54,
                                      border: Border.all(width: 1.w, color: Colors.black),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 5.sp),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.skip_next,
                                            size: 30.sp,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 15.w),
                                          Text(
                                            textAlign: TextAlign.center,
                                            maxLines: 5,
                                            "NEXT",
                                            style: GoogleFonts.figtree(
                                              fontSize: 20.sp,
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
    );
  }
}
