import 'dart:math';
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
import 'package:provider/provider.dart';
import '../../AdPlugin/MainJson/MainJson.dart';
import '../../Provider/api_provider.dart';
import '../../main.dart';

class bible_stories_screen extends StatefulWidget {
  static const routeName = '/bible_stories_screen';

  const bible_stories_screen({super.key});

  @override
  State<bible_stories_screen> createState() => _bible_stories_screenState();
}

class _bible_stories_screenState extends State<bible_stories_screen> {
  bool isLoading = true;

  @override
  void initState() {
    Api dataProvider = Provider.of<Api>(context, listen: false);
    context.read<Api>().storiesData(context.read<MainJson>().data!['assets']['bibleStories']).then((value) {
      dataProvider.keyList.clear();
      dataProvider.bibleStoriesList['Bible Stories'].forEach((element) {
        dataProvider.keyList.addAll(element.keys.toList());
      });
      featuredData();
      popularData();
      isLoading = false;
    });
    super.initState();
  }

  featuredData() {
    Api dataProvider = Provider.of<Api>(context, listen: false);
    dataProvider.featuredList.clear();
    for (int i = 0; i < dataProvider.bibleStoriesList['Bible Stories'].length; i++) {
      int randomIndex = Random().nextInt(dataProvider.bibleStoriesList['Bible Stories'][i][dataProvider.keyList[i]].length);
      List subKeyList = [];
      dataProvider.bibleStoriesList['Bible Stories'][i][dataProvider.keyList[i]].forEach((element) {
        subKeyList.addAll(element.keys.toList());
      });
      for (int k = 0; k < dataProvider.bibleStoriesList['Bible Stories'][i][dataProvider.keyList[i]][randomIndex][subKeyList[randomIndex]].length; k++) {
        int randomIndex2 = Random().nextInt(dataProvider.bibleStoriesList['Bible Stories'][i][dataProvider.keyList[i]][randomIndex][subKeyList[randomIndex]].length);

        dataProvider.featuredList.add(dataProvider.bibleStoriesList['Bible Stories'][i][dataProvider.keyList[i]][randomIndex][subKeyList[randomIndex]][randomIndex2]);
      }
      dataProvider.featuredList.shuffle();
      // print("featuredList =======>>>>${dataProvider.featuredList}");
    }
  }

  popularData() {
    Api dataProvider = Provider.of<Api>(context, listen: false);
    dataProvider.popularList.clear();
    for (int i = 0; i < dataProvider.bibleStoriesList['Bible Stories'].length; i++) {
      int randomIndex = Random().nextInt(dataProvider.bibleStoriesList['Bible Stories'][i][dataProvider.keyList[i]].length);
      // print("randomIndex =====>>>${randomIndex}");
      List subKeyList = [];
      dataProvider.bibleStoriesList['Bible Stories'][i][dataProvider.keyList[i]].forEach((element) {
        subKeyList.addAll(element.keys.toList());
      });
      for (int k = 0; k < dataProvider.bibleStoriesList['Bible Stories'][i][dataProvider.keyList[i]][randomIndex][subKeyList[randomIndex]].length; k++) {
        int randomIndex2 = Random().nextInt(dataProvider.bibleStoriesList['Bible Stories'][i][dataProvider.keyList[i]][randomIndex][subKeyList[randomIndex]].length);

        dataProvider.popularList.add(dataProvider.bibleStoriesList['Bible Stories'][i][dataProvider.keyList[i]][randomIndex][subKeyList[randomIndex]][randomIndex2]);
      }
      dataProvider.popularList.shuffle();
      // print("featuredList =======>>>>${dataProvider.popularList}");
    }
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
            "Bible Stories",
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
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star,
                          size: isIpad
                              ? 28.sp
                              : isSmall
                                  ? 30.sp
                                  : 35.sp,
                          color: Colors.lightGreen,
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          textAlign: TextAlign.center,
                          "FEATURED",
                          style: GoogleFonts.archivoBlack(
                            fontSize: isIpad
                                ? 20.sp
                                : isSmall
                                    ? 22.sp
                                    : 25.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: isIpad
                          ? 170.sp
                          : isSmall
                              ? 180.sp
                              : 210.sp,
                      child: ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.only(left: 10.w, top: 10.h),
                        itemCount: dataProvider.featuredList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 10.w),
                                child: GestureDetector(
                                  onTap: () {
                                    AdsRN().showFullScreen(
                                      context: context,
                                      onComplete: () {
                                        Navigator.pushNamed(
                                          context,
                                          bible_stories_detail_screen.routeName,
                                          arguments: {
                                            "oneStories": dataProvider.featuredList[index],
                                          },
                                        );
                                      },
                                    );
                                    setState(() {});
                                  },
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        height: isIpad
                                            ? 120.sp
                                            : isSmall
                                                ? 130.sp
                                                : 150.sp,
                                        width: 250.w,
                                        decoration: BoxDecoration(
                                          color: Colors.black54,
                                          border: Border.all(width: 2.w, color: Colors.white),
                                          borderRadius: BorderRadius.circular(10.r),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(isIpad ? 7.r : 9.r),
                                          child: CachedNetworkImage(
                                            height: isSmall ? 130.sp : 150.sp,
                                            width: 1.sw,
                                            imageUrl: dataProvider.featuredList[index]['image'],
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
                                      Container(
                                        height: isIpad ? 50.sp : 60.sp,
                                        width: isIpad ? 50.w : 60.w,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(width: 4.w, color: Colors.white),
                                          color: HexColor('9247a9'),
                                        ),
                                        child: Icon(
                                          Icons.play_arrow,
                                          size: isIpad ? 40.sp : 45.sp,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: isSmall ? 7.h : 10.h),
                              Text(
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                "${dataProvider.featuredList[index]['title']}",
                                style: GoogleFonts.figtree(
                                  fontSize: isIpad
                                      ? 16.sp
                                      : isSmall
                                          ? 18.sp
                                          : 20.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.sp),
                      child: Container(height: 1.h, color: Colors.white),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.favorite,
                          size: isIpad
                              ? 28.sp
                              : isSmall
                                  ? 30.sp
                                  : 35.sp,
                          color: Colors.purpleAccent.shade700,
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          textAlign: TextAlign.center,
                          "POPULAR",
                          style: GoogleFonts.archivoBlack(
                            fontSize: isIpad
                                ? 20.sp
                                : isSmall
                                    ? 22.sp
                                    : 25.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: isIpad
                          ? 170.sp
                          : isSmall
                              ? 180.sp
                              : 210.sp,
                      child: ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.only(left: 10.w, top: 10.h),
                        itemCount: dataProvider.popularList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 10.w),
                                child: GestureDetector(
                                  onTap: () {
                                    AdsRN().showFullScreen(
                                      context: context,
                                      onComplete: () {
                                        Navigator.pushNamed(
                                          context,
                                          bible_stories_detail_screen.routeName,
                                          arguments: {
                                            "oneStories": dataProvider.popularList[index],
                                          },
                                        );
                                      },
                                    );
                                    setState(() {});
                                  },
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        height: isIpad
                                            ? 120.sp
                                            : isSmall
                                                ? 130.sp
                                                : 150.sp,
                                        width: 250.w,
                                        decoration: BoxDecoration(
                                          color: Colors.black54,
                                          border: Border.all(width: 2.w, color: Colors.white),
                                          borderRadius: BorderRadius.circular(10.r),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(isIpad ? 7.r : 9.r),
                                          child: CachedNetworkImage(
                                            height: isSmall ? 130.sp : 150.sp,
                                            width: 1.sw,
                                            imageUrl: dataProvider.popularList[index]['image'],
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
                                      Container(
                                        height: isIpad ? 50.sp : 60.sp,
                                        width: isIpad ? 50.w : 60.w,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(width: 4.w, color: Colors.white),
                                          color: HexColor('9247a9'),
                                        ),
                                        child: Icon(
                                          Icons.play_arrow,
                                          size: isIpad ? 40.sp : 45.sp,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: isSmall ? 7.h : 10.h),
                              Text(
                                textAlign: TextAlign.center,
                                "${dataProvider.popularList[index]['title']}",
                                style: GoogleFonts.figtree(
                                  fontSize: isIpad
                                      ? 16.sp
                                      : isSmall
                                          ? 18.sp
                                          : 20.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5.h),
                      child: Container(height: 1.h, color: Colors.white),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: dataProvider.keyList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            index == 1 ? NativeRN(parentContext: context) : SizedBox.shrink(),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.sp),
                              child: Container(
                                height: isIpad
                                    ? 48.sp
                                    : isSmall
                                        ? 55.sp
                                        : 60.sp,
                                width: 1.sw,
                                child: Center(
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    "${dataProvider.keyList[index]}",
                                    style: GoogleFonts.archivoBlack(
                                      fontSize: isIpad
                                          ? 16.sp
                                          : isSmall
                                              ? 18.sp
                                              : 20.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: isIpad
                                  ? 170.sp
                                  : isSmall
                                      ? 180.sp
                                      : 200.sp,
                              child: ListView.builder(
                                itemCount: dataProvider.bibleStoriesList['Bible Stories'][index][dataProvider.keyList[index]].length,
                                padding: EdgeInsets.only(left: 10.w),
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemBuilder: (context, index1) {
                                  List subKeyList = [];
                                  dataProvider.bibleStoriesList['Bible Stories'][index][dataProvider.keyList[index]].forEach((element) {
                                    subKeyList.addAll(element.keys.toList());
                                  });
                                  return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: dataProvider.bibleStoriesList['Bible Stories'][index][dataProvider.keyList[index]][index1][subKeyList[index1]].length,
                                    itemBuilder: (context, index2) {
                                      return Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(right: 10.w),
                                            child: GestureDetector(
                                              onTap: () {
                                                AdsRN().showFullScreen(
                                                  context: context,
                                                  onComplete: () {
                                                    Navigator.pushNamed(
                                                      context,
                                                      bible_stories_detail_screen.routeName,
                                                      arguments: {
                                                        "oneStories": dataProvider.bibleStoriesList['Bible Stories'][index][dataProvider.keyList[index]][index1][subKeyList[index1]][index2],
                                                      },
                                                    );
                                                  },
                                                );
                                                // print("oneStories =====>>>>>${dataProvider.bibleStoriesList['Bible Stories'][index][dataProvider.keyList[index]][index1][subKeyList[index1]][index2]}");
                                                setState(() {});
                                              },
                                              child: Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  Container(
                                                    height: isIpad
                                                        ? 120.sp
                                                        : isSmall
                                                            ? 130.sp
                                                            : 150.sp,
                                                    width: 250.w,
                                                    decoration: BoxDecoration(
                                                      color: Colors.black54,
                                                      border: Border.all(width: 2.w, color: Colors.white),
                                                      borderRadius: BorderRadius.circular(10.r),
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius: BorderRadius.circular(9.r),
                                                      child: CachedNetworkImage(
                                                        height: isIpad
                                                            ? 120.sp
                                                            : isSmall
                                                                ? 130.sp
                                                                : 150.sp,
                                                        width: 1.sw,
                                                        imageUrl: dataProvider.bibleStoriesList['Bible Stories'][index][dataProvider.keyList[index]][index1][subKeyList[index1]][index2]['image'],
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
                                                  Container(
                                                    height: isIpad ? 50.sp : 60.sp,
                                                    width: isIpad ? 50.w : 60.w,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      border: Border.all(width: 4.w, color: Colors.white),
                                                      color: HexColor('9247a9'),
                                                    ),
                                                    child: Icon(
                                                      Icons.play_arrow,
                                                      size: isIpad ? 40.sp : 45.sp,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                              height: isIpad
                                                  ? 5.h
                                                  : isSmall
                                                      ? 7.h
                                                      : 10.h),
                                          Text(
                                            textAlign: TextAlign.center,
                                            maxLines: 2,
                                            "${dataProvider.bibleStoriesList['Bible Stories'][index][dataProvider.keyList[index]][index1][subKeyList[index1]][index2]['title']}",
                                            style: GoogleFonts.figtree(
                                              fontSize: isIpad
                                                  ? 16.sp
                                                  : isSmall
                                                      ? 18.sp
                                                      : 20.sp,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                            Container(
                              width: 1.sw,
                              color: Colors.white,
                              height: 1.sp,
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
