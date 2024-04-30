import 'package:cached_network_image/cached_network_image.dart';
import 'package:devotional_bible/AdPlugin/Ads/Banner/BannerWrapper.dart';
import 'package:devotional_bible/AdPlugin/Ads/FullScreen/Ads.dart';
import 'package:devotional_bible/AdPlugin/Ads/Native/NativeRN.dart';
import 'package:devotional_bible/AdPlugin/MainJson/MainJson.dart';
import 'package:devotional_bible/Provider/api_provider.dart';
import 'package:devotional_bible/Screens/bible_devotional_screen/devotional_detail_screen.dart';
import 'package:devotional_bible/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class bible_devotional_screen extends StatefulWidget {
  static const routeName = '/bible_devotional_screen';

  const bible_devotional_screen({super.key});

  @override
  State<bible_devotional_screen> createState() => _bible_devotional_screenState();
}

class _bible_devotional_screenState extends State<bible_devotional_screen> {
  bool isLoading = true;

  @override
  void initState() {
    context.read<Api>().devotionalData(context.read<MainJson>().data!['assets']['devotionalBible']).then((value) {
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
            "KC Devotional",
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
                    NativeRN(parentContext: context),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: dataProvider.devotionalList['KC Devotional'].length,
                      padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 10.sp),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: isIpad ? 170.sp : 200.sp,
                        mainAxisSpacing: 10.sp,
                        crossAxisSpacing: 10.sp,
                      ),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            AdsRN().showFullScreen(
                              context: context,
                              onComplete: () {
                                Navigator.pushNamed(
                                  context,
                                  devotional_detail_screen.routeName,
                                  arguments: {"oneData": dataProvider.devotionalList['KC Devotional'][index]},
                                );
                              },
                            );
                            // print("oneData =======>>>${dataProvider.devotionalList['KC Devotional'][index]}");
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(width: 1.w, color: Colors.cyanAccent.shade400),
                              borderRadius: BorderRadius.circular(10.r),
                              color: Colors.black45,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(9.r),
                                  child: CachedNetworkImage(
                                    height: isSmall
                                        ? 90.sp
                                        : isIpad
                                            ? 90.sp
                                            : 100.sp,
                                    width: 1.sw,
                                    imageUrl: dataProvider.devotionalList['KC Devotional'][index]['image'],
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
                                Padding(
                                  padding: EdgeInsets.only(left: 8.w, right: 8.w, top: 8.h),
                                  child: Text(
                                    "${dataProvider.devotionalList['KC Devotional'][index]['title']}",
                                    style: GoogleFonts.figtree(
                                      fontSize: isIpad
                                          ? 12.sp
                                          : isSmall
                                              ? 14.sp
                                              : 15.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Padding(
                                  padding: EdgeInsets.only(left: 8.w, right: 8.w, top: 2.h),
                                  child: Text(
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    "${dataProvider.devotionalList['KC Devotional'][index]['shortnote']}",
                                    style: GoogleFonts.figtree(
                                      fontSize: isIpad
                                          ? 10.sp
                                          : isSmall
                                              ? 12.sp
                                              : 13.sp,
                                      color: Colors.white70,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Spacer(),
                              ],
                            ),
                          ),
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
