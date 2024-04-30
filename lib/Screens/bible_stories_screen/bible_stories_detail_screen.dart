import 'dart:io';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:devotional_bible/AdPlugin/Ads/Banner/BannerWrapper.dart';
import 'package:devotional_bible/AdPlugin/Ads/Native/NativeRN.dart';
import 'package:devotional_bible/Screens/bible_stories_screen/pdf_view_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:share/share.dart';
import '../../main.dart';
import '../bible_devotional_screen/devotional_detail_screen.dart';

class bible_stories_detail_screen extends StatefulWidget {
  static const routeName = '/bible_stories_detail_screen';
  final Map oneStories;

  const bible_stories_detail_screen({super.key, required this.oneStories});

  @override
  State<bible_stories_detail_screen> createState() => _bible_stories_detail_screenState();
}

class _bible_stories_detail_screenState extends State<bible_stories_detail_screen> {
  bool listenDialog = false;
  int quizIndex = 0;
  bool answerShow = false;
  bool download = false;
  AudioPlayer player = AudioPlayer();
  bool audioPlay = false;
  FlutterTts flutterTts = FlutterTts();

  Stream<PositionData> get positionDataStream => Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        player.positionStream,
        player.bufferedPositionStream,
        player.durationStream,
        (position, bufferedPosition, duration) => PositionData(
          position,
          bufferedPosition,
          duration ?? Duration.zero,
        ),
      );

  void downloadAudio(String audioUrl) async {
    Dio dio = Dio();
    try {
      Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
      String savePath = appDocumentsDirectory.path + '/${widget.oneStories['title']}.mp3';
      await dio.download(audioUrl, savePath, onReceiveProgress: (received, total) {}).then((value) {
        download = false;
        setState(() {});
      });
    } catch (e) {
      print(e);
    }
  }

  void sharePdfFile(File pdfFile, String subject, String message) {
    Share.shareFiles([pdfFile.path], subject: subject, text: message);
  }

  @override
  void initState() {
    player = AudioPlayer()..setUrl('https://coinspinmaster.com/viral/iosapp/bible/kids bible/bible stories audio/${widget.oneStories['title']}.mp3');
    super.initState();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

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
              Navigator.pop(context);
              setState(() {});
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
            "${widget.oneStories['title']}",
            style: GoogleFonts.figtree(
              fontSize: isIpad
                  ? 20.sp
                  : isSmall
                      ? 23.sp
                      : 24.sp,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: 1.sw,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.oneStories['image']),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 20.sp),
                          child: Container(
                            width: 1.sw,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.r),
                              color: Colors.white54,
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 25.sp, vertical: 20.sp),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    textAlign: TextAlign.center,
                                    "${widget.oneStories['title']}",
                                    style: GoogleFonts.archivoBlack(
                                      fontSize: isIpad
                                          ? 22.sp
                                          : isSmall
                                              ? 25.sp
                                              : 26.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  Text(
                                    textAlign: TextAlign.center,
                                    "${widget.oneStories['note']}",
                                    style: GoogleFonts.figtree(
                                      fontSize: isIpad
                                          ? 19.sp
                                          : isSmall
                                              ? 22.sp
                                              : 24.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  GestureDetector(
                                    onTap: () {
                                      listenDialog = true;
                                      setState(() {});
                                    },
                                    child: Container(
                                      height: isIpad ? 45.sp : 50.sp,
                                      width: 160.w,
                                      decoration: BoxDecoration(
                                        border: Border.all(width: 1.w, color: Colors.white),
                                        borderRadius: BorderRadius.circular(8.r),
                                        color: Colors.purple.shade700,
                                      ),
                                      child: Center(
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          "Before You Listen",
                                          style: GoogleFonts.figtree(
                                            fontSize: isIpad
                                                ? 15.sp
                                                : isSmall
                                                    ? 17.sp
                                                    : 18.sp,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: isIpad
                              ? 60.sp
                              : isSmall
                                  ? 70.sp
                                  : 80.sp,
                          width: 1.sw,
                          decoration: BoxDecoration(
                            color: HexColor('873e9f'),
                            border: Border(
                              top: BorderSide(width: 1.w, color: Colors.white),
                              bottom: BorderSide(width: 1.w, color: Colors.white),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.sp),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    audioPlay = !audioPlay;
                                    if (audioPlay == true) {
                                      player.play();
                                      print("https://coinspinmaster.com/viral/iosapp/bible/kids bible/bible stories audio/${widget.oneStories['title']}.mp3");
                                    } else {
                                      player.pause();
                                    }
                                    setState(() {});
                                  },
                                  child: Container(
                                    height: isIpad
                                        ? 45.sp
                                        : isSmall
                                            ? 50.sp
                                            : 55.sp,
                                    width: isIpad
                                        ? 45.w
                                        : isSmall
                                            ? 50.w
                                            : 55.w,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    child: Icon(
                                      audioPlay == true ? Icons.pause_outlined : Icons.play_arrow_rounded,
                                      size: isIpad
                                          ? 32.sp
                                          : isSmall
                                              ? 35.sp
                                              : 40.sp,
                                      color: HexColor('873e9f'),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5.w),
                                GestureDetector(
                                  onTap: () {
                                    player.seek(player.position - Duration(seconds: 10));
                                    audioPlay = true;
                                    player.play();
                                    setState(() {});
                                  },
                                  child: Icon(
                                    Icons.replay_10_outlined,
                                    size: 35.sp,
                                    color: Colors.white,
                                  ),
                                ),
                                Expanded(
                                  child: StreamBuilder<PositionData>(
                                    stream: positionDataStream,
                                    builder: (context, snapshot) {
                                      final positionData = snapshot.data;
                                      return Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10.sp),
                                        child: ProgressBar(
                                          barHeight: 5.sp,
                                          timeLabelLocation: TimeLabelLocation.sides,
                                          baseBarColor: Colors.white70,
                                          bufferedBarColor: Colors.black12,
                                          thumbColor: Colors.white,
                                          thumbRadius: 5.r,
                                          progressBarColor: Colors.white,
                                          timeLabelTextStyle: TextStyle(
                                            fontSize: 15.sp,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w800,
                                          ),
                                          timeLabelPadding: 2.sp,
                                          progress: positionData?.position ?? Duration.zero,
                                          buffered: positionData?.bufferedPosition ?? Duration.zero,
                                          total: positionData?.duration ?? Duration.zero,
                                          onSeek: player.seek,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 50.sp,
                          width: 1.sw,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(width: 1.w, color: Colors.white),
                            ),
                          ),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    pdf_view_screen.routeName,
                                    arguments: "https://coinspinmaster.com/viral/iosapp/bible/kids bible/bible stories pdf/${widget.oneStories['title']}.pdf",
                                  );
                                },
                                child: Container(
                                  color: HexColor('b4d22f'),
                                  width: 1.sw / 3,
                                  height: 50.sp,
                                  child: Icon(
                                    Icons.picture_as_pdf_rounded,
                                    size: 30.sp,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  File pdfFile = File('https://coinspinmaster.com/viral/iosapp/bible/kids bible/bible stories pdf/${widget.oneStories['title']}.pdf');
                                  String subject = 'Sharing PDF';
                                  String message = 'Check out this PDF file!';
                                  sharePdfFile(pdfFile, subject, message);
                                  setState(() {});
                                },
                                child: Container(
                                  color: HexColor('73c9d7'),
                                  width: 1.sw / 3,
                                  height: 50.sp,
                                  child: Icon(
                                    Icons.share,
                                    size: 30.sp,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  download = true;
                                  downloadAudio("https://coinspinmaster.com/viral/iosapp/bible/kids bible/bible stories audio/${widget.oneStories['title']}.mp3");
                                  setState(() {});
                                },
                                child: Container(
                                  color: HexColor('132e39'),
                                  width: 1.sw / 3,
                                  height: 50.sp,
                                  child: download
                                      ? CupertinoActivityIndicator(
                                          radius: 10.r,
                                          color: Colors.white,
                                        )
                                      : Icon(
                                          Icons.download,
                                          size: 30.sp,
                                          color: Colors.white,
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: isIpad
                        ? 50.sp
                        : isSmall
                            ? 60.sp
                            : 70.sp,
                    width: 1.sw,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1.w, color: Colors.white),
                      ),
                      gradient: LinearGradient(
                        colors: [
                          HexColor('234352'),
                          HexColor('487183'),
                        ],
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "AFTER YOU LISTEN",
                        style: GoogleFonts.archivoBlack(
                          fontSize: isIpad
                              ? 22.sp
                              : isSmall
                                  ? 25.sp
                                  : 26.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                  NativeRN(parentContext: context),
                  SizedBox(height: 30.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.sp),
                    child: Container(
                      width: 1.sw,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: HexColor('5ac0d1'),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.sp),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.sp),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "MEMORY VERSE",
                                    style: GoogleFonts.archivoBlack(
                                      fontSize: isIpad
                                          ? 20.sp
                                          : isSmall
                                              ? 22.sp
                                              : 24.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      flutterTts.speak("${widget.oneStories['Memory Verse']}");
                                      setState(() {});
                                    },
                                    child: Icon(
                                      Icons.mic,
                                      size: 30.sp,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 20.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 25.sp),
                              child: Text(
                                textAlign: TextAlign.center,
                                "${widget.oneStories['Memory Verse']}",
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
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.sp),
                    child: Container(
                      width: 1.sw,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: HexColor('5ac0d1'),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.sp),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(2.sp),
                              child: Text(
                                "QUIZ",
                                style: GoogleFonts.archivoBlack(
                                  fontSize: isIpad
                                      ? 20.sp
                                      : isSmall
                                          ? 22.sp
                                          : 24.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 25.sp),
                              child: Container(
                                width: 1.sw,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: HexColor('247886'),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 10.sp),
                                  child: Column(
                                    children: [
                                      Text(
                                        "${quizIndex + 1}.  ${widget.oneStories['quiz'][quizIndex]['Question']}",
                                        style: GoogleFonts.figtree(
                                          fontSize: isIpad
                                              ? 18.sp
                                              : isSmall
                                                  ? 20.sp
                                                  : 22.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(height: 15.h),
                                      GestureDetector(
                                        onTap: () {
                                          answerShow = !answerShow;
                                          setState(() {});
                                        },
                                        child: Container(
                                          height: 50.sp,
                                          width: 180.w,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8.r),
                                            color: Colors.red.shade700,
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 6.sp),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  answerShow ? Icons.remove : Icons.add,
                                                  size: 25.sp,
                                                  color: Colors.white,
                                                ),
                                                Spacer(),
                                                Text(
                                                  answerShow ? "Hide The Answer" : "Show The Answer",
                                                  style: GoogleFonts.figtree(
                                                    fontSize: isIpad
                                                        ? 15.sp
                                                        : isSmall
                                                            ? 16.sp
                                                            : 17.sp,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      answerShow == true
                                          ? Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(vertical: 25.sp),
                                                child: Text(
                                                  "A: ${widget.oneStories['quiz'][quizIndex]['Answers']}",
                                                  style: GoogleFonts.figtree(
                                                    fontSize: isIpad
                                                        ? 20.sp
                                                        : isSmall
                                                            ? 22.sp
                                                            : 24.sp,
                                                    color: Colors.lightGreen,
                                                    fontWeight: FontWeight.w900,
                                                  ),
                                                ),
                                              ),
                                            )
                                          : SizedBox(
                                              height: isIpad ? 60.sp : 80.sp,
                                            ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 10.sp),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        answerShow = false;
                                        if (quizIndex == 0) {
                                          quizIndex = widget.oneStories['quiz'].length - 1;
                                        } else {
                                          quizIndex--;
                                        }
                                      });
                                    },
                                    child: Icon(
                                      Icons.arrow_back_outlined,
                                      size: 25.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      answerShow = false;
                                      if (quizIndex == widget.oneStories['quiz'].length - 1) {
                                        quizIndex = 0;
                                      } else {
                                        quizIndex++;
                                      }

                                      setState(() {});
                                    },
                                    child: Icon(
                                      Icons.arrow_forward_outlined,
                                      size: 25.sp,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.sp),
                    child: Container(
                      width: 1.sw,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: HexColor('5ac0d1'),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.sp),
                        child: Column(
                          children: [
                            Text(
                              "REFLECT",
                              style: GoogleFonts.archivoBlack(
                                fontSize: isIpad
                                    ? 25.sp
                                    : isSmall
                                        ? 27.sp
                                        : 28.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.sp),
                              child: Text(
                                textAlign: TextAlign.justify,
                                "${widget.oneStories['Reflect']}",
                                style: GoogleFonts.figtree(
                                  fontSize: isIpad
                                      ? 17.sp
                                      : isSmall
                                          ? 19.sp
                                          : 21.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.sp),
                    child: Container(
                      width: 1.sw,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: HexColor('5ac0d1'),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.sp),
                        child: Column(
                          children: [
                            Text(
                              "CHALLENGE",
                              style: GoogleFonts.archivoBlack(
                                fontSize: isIpad
                                    ? 25.sp
                                    : isSmall
                                        ? 27.sp
                                        : 28.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.sp),
                              child: Text(
                                textAlign: TextAlign.justify,
                                "${widget.oneStories['Challenge']}",
                                style: GoogleFonts.figtree(
                                  fontSize: isIpad
                                      ? 17.sp
                                      : isSmall
                                          ? 19.sp
                                          : 21.sp,
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
                  SizedBox(height: 30.h),
                ],
              ),
            ),
            listenDialog == true
                ? Container(
                    height: 1.sh,
                    width: 1.sw,
                    color: Colors.black54,
                  )
                : SizedBox(),
            listenDialog == true
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 80.sp),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      child: ListView.builder(
                        itemCount: widget.oneStories['Before You Listen'].length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 20.sp, horizontal: 20.sp),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${widget.oneStories['Before You Listen'][index]['Title']}",
                                  style: GoogleFonts.figtree(
                                    fontSize: 25.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Theme: ",
                                      style: GoogleFonts.figtree(
                                        fontSize: 22.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "${widget.oneStories['Before You Listen'][index]['Theme']}",
                                        style: GoogleFonts.figtree(
                                          fontSize: 20.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20.h),
                                Text(
                                  "${widget.oneStories['Before You Listen'][index]['Details']}",
                                  style: GoogleFonts.figtree(
                                    fontSize: 18.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 50.h),
                                Align(
                                  alignment: Alignment.center,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        listenDialog = false;
                                      });
                                    },
                                    child: Container(
                                      height: 45.sp,
                                      width: 100.w,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.r),
                                        color: Colors.red.shade700,
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Close",
                                          style: GoogleFonts.figtree(
                                            fontSize: 25.sp,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
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
