import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

class devotional_detail_screen extends StatefulWidget {
    static const routeName = '/devotional_detail_screen';
  final Map oneData;

  const devotional_detail_screen({super.key, required this.oneData});

  @override
  State<devotional_detail_screen> createState() => _devotional_detail_screenState();
}

class _devotional_detail_screenState extends State<devotional_detail_screen> {
  AudioPlayer player = AudioPlayer();
  bool audioPlay = false;

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

  @override
  void initState() {
    player = AudioPlayer()..setUrl('https://coinspinmaster.com/viral/iosapp/bible/kids bible/KC Devotional audio/${widget.oneData['title']}.mp3');
    super.initState();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          "${widget.oneData['title']}",
          style: GoogleFonts.figtree(
            fontSize: 25.sp,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 10.sp),
                child: Container(
                  height: 150.sp,
                  width: 1.sw,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.r),
                    border: Border.all(width: 2.w, color: Colors.black54),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4.r),
                    child: CachedNetworkImage(
                      height: 100.sp,
                      width: 1.sw,
                      imageUrl: widget.oneData['image'],
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
              ),
              ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 15.sp),
                itemCount: widget.oneData['qna'].length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${widget.oneData['qna'][index]['tital']}",
                        style: GoogleFonts.figtree(
                          fontSize: 28.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                        child: Container(
                          height: 55.sp,
                          width: 1.sw,
                          decoration: BoxDecoration(
                            color: Colors.black87,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.sp),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    audioPlay = !audioPlay;
                                    if (audioPlay == true) {
                                      player.play();
                                      print("https://coinspinmaster.com/viral/iosapp/bible/kids bible/KC Devotional audio/${widget.oneData['title']}.mp3");
                                    } else {
                                      player.pause();
                                    }
                                    setState(() {});
                                  },
                                  child: Icon(
                                    audioPlay == true ? Icons.pause_outlined : Icons.play_arrow_rounded,
                                    size: 25.sp,
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
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: widget.oneData['qna'][index]['details'].length,
                        itemBuilder: (context, index1) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              widget.oneData['qna'][index]['details'][index1]['title'] == null
                                  ? SizedBox()
                                  : Padding(
                                      padding: EdgeInsets.only(top: 20.h),
                                      child: Text(
                                        "${widget.oneData['qna'][index]['details'][index1]['title']}",
                                        style: GoogleFonts.figtree(
                                          fontSize: 28.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ),
                              widget.oneData['qna'][index]['details'][index1]['type'] == 'image'
                                  ? SizedBox()
                                  : Text(
                                      textAlign: TextAlign.justify,
                                      "${widget.oneData['qna'][index]['details'][index1]['details']}",
                                      style: GoogleFonts.figtree(
                                        fontSize: 18.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                              widget.oneData['qna'][index]['details'][index1]['type'] == 'image'
                                  ? Padding(
                                      padding: EdgeInsets.only(top: 30.h),
                                      child: Text(
                                        textAlign: TextAlign.justify,
                                        "Casey's Day",
                                        style: GoogleFonts.figtree(
                                          fontSize: 30.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    )
                                  : SizedBox(),
                              widget.oneData['qna'][index]['details'][index1]['type'] == 'image'
                                  ? Padding(
                                      padding: EdgeInsets.only(top: 10.h, bottom: 30.h),
                                      child: CachedNetworkImage(
                                        height: 150.sp,
                                        width: 150.w,
                                        imageUrl: widget.oneData['qna'][index]['details'][index1]['image'],
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
                                    )
                                  : SizedBox(),
                            ],
                          );
                        },
                      ),
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PositionData {
  const PositionData(
    this.position,
    this.bufferedPosition,
    this.duration,
  );

  final Duration position;
  final Duration duration;
  final Duration bufferedPosition;
}
