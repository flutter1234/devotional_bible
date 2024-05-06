import 'package:cached_network_image/cached_network_image.dart';
import 'package:devotional_bible/AdPlugin/Ads/Banner/BannerWrapper.dart';
import 'package:devotional_bible/AdPlugin/Ads/FullScreen/Ads.dart';
import 'package:devotional_bible/AdPlugin/Ads/Native/NativeRN.dart';
import 'package:devotional_bible/Screens/bible_stories_screen/bible_stories_detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../main.dart';

class devotional_bible_view_screen extends StatefulWidget {
  static const routeName = '/devotional_bible_view_screen';
  final viewData;
  final keyName;

  const devotional_bible_view_screen({super.key, required this.viewData, required this.keyName});

  @override
  State<devotional_bible_view_screen> createState() => _devotional_bible_view_screenState();
}

class _devotional_bible_view_screenState extends State<devotional_bible_view_screen> {
  @override
  Widget build(BuildContext context) {
    return BannerWrapper(
      parentContext: context,
      child: Container(
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
              "${widget.keyName}",
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
          body: ListView.builder(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: isSmall ? 8.sp : 10.sp),
            itemCount: widget.viewData.length,
            itemBuilder: (context, index) {
              List subKeyList = [];
              widget.viewData.forEach((element) {
                subKeyList.addAll(element.keys.toList());
              });
              return Column(
                children: [
                  index == 1 ? NativeRN(parentContext: context) : SizedBox(),
                  ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 15.h),
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: widget.viewData[index][subKeyList[index]].length,
                    itemBuilder: (context, index2) {
                      return GestureDetector(
                        onTap: () {
                          AdsRN().showFullScreen(
                            context: context,
                            onComplete: () {
                              Navigator.pushNamed(
                                context,
                                bible_stories_detail_screen.routeName,
                                arguments: {"oneStories": widget.viewData[index][subKeyList[index]][index2]},
                              );
                            },
                          );
                          // print("oneStories =====>>>>>${dataProvider.bibleStoriesList['Bible Stories'][index][dataProvider.keyList[index]][index1][subKeyList[index1]][index2]}");
                          setState(() {});
                        },
                        child: Container(
                          height: isIpad
                              ? 160.sp
                              : isSmall
                                  ? 170.sp
                                  : 185.sp,
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            border: Border.all(width: 2.w, color: Colors.white),
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          child: Column(
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(14.r),
                                    child: CachedNetworkImage(
                                      height: isIpad
                                          ? 110.sp
                                          : isSmall
                                              ? 110.sp
                                              : 125.sp,
                                      width: 1.sw,
                                      imageUrl: widget.viewData[index][subKeyList[index]][index2]['image'],
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
                                  Container(
                                    height: isIpad
                                        ? 50.sp
                                        : isSmall
                                            ? 50.sp
                                            : 60.sp,
                                    width: isIpad
                                        ? 50.w
                                        : isSmall
                                            ? 50.sp
                                            : 60.w,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(width: 4.w, color: Colors.white),
                                      color: HexColor('9247a9'),
                                    ),
                                    child: Icon(
                                      Icons.play_arrow,
                                      size: isIpad
                                          ? 40.sp
                                          : isSmall
                                              ? 40.sp
                                              : 45.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: isIpad ? 5.sp : 8.sp, vertical: 2.sp),
                                  child: Text(
                                    textAlign: TextAlign.start,
                                    maxLines: 2,
                                    "${subKeyList[index]}",
                                    style: GoogleFonts.figtree(
                                      fontSize: isIpad
                                          ? 15.sp
                                          : isSmall
                                              ? 17.sp
                                              : 20.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
