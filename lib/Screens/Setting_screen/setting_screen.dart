import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../AdPlugin/Ads/Banner/BannerWrapper.dart';
import '../../AdPlugin/MainJson/MainJson.dart';
import '../../AdPlugin/Utils/Alerts/RateUs.dart';
import '../../Provider/api_provider.dart';
import '../../main.dart';

class setting_screen extends StatefulWidget {
  static const routeName = '/setting_screen';

  const setting_screen({super.key});

  @override
  State<setting_screen> createState() => _setting_screenState();
}

class _setting_screenState extends State<setting_screen> {
  @override
  Widget build(BuildContext context) {
    Api dataProvider = Provider.of<Api>(context, listen: true);
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
            centerTitle: true,
            backgroundColor: Colors.transparent,
            leading: Padding(
              padding: EdgeInsets.only(left: isIpad ? 10.w : 0),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {});
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: isIpad
                      ? 23.sp
                      : isSmall
                          ? 23.sp
                          : 25.sp,
                  color: Colors.white,
                ),
              ),
            ),
            title: Text(
              'Setting',
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
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.sp),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        dataProvider.url = context.read<MainJson>().data!['assets']['privacyPolicy'];
                      });
                      dataProvider.launchurl();
                    },
                    child: Container(
                      height: 45.sp,
                      width: 1.sw,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.w, color: Colors.white),
                        borderRadius: BorderRadius.circular(30.r),
                        color: Colors.black45,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.sp),
                        child: Row(
                          children: [
                            Icon(
                              Icons.lock_person_rounded,
                              size: isIpad
                                  ? 30.sp
                                  : isSmall
                                      ? 30.sp
                                      : 32.sp,
                              color: Colors.grey.shade300,
                            ),
                            SizedBox(width: 20.w),
                            Text(
                              'Privacy Policy',
                              style: GoogleFonts.figtree(
                                fontSize: isIpad
                                    ? 20.sp
                                    : isSmall
                                        ? 20.sp
                                        : 24.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      dataProvider.url = context.read<MainJson>().data!['assets']['contactUs'];
                    });
                    dataProvider.launchurl();
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: Container(
                      height: 45.sp,
                      width: 1.sw,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.w, color: Colors.white),
                        borderRadius: BorderRadius.circular(30.r),
                        color: Colors.black45,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.sp),
                        child: Row(
                          children: [
                            Icon(
                              Icons.contact_page_rounded,
                              size: isIpad
                                  ? 30.sp
                                  : isSmall
                                      ? 30.sp
                                      : 32.sp,
                              color: Colors.grey.shade300,
                            ),
                            SizedBox(width: 20.w),
                            Text(
                              'Contactus',
                              style: GoogleFonts.figtree(
                                fontSize: isIpad
                                    ? 20.sp
                                    : isSmall
                                        ? 20.sp
                                        : 24.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: Builder(builder: (contexts) {
                    return GestureDetector(
                      onTap: () {
                        final box = contexts.findRenderObject() as RenderBox?;
                        print(context.read<MainJson>().data!['assets']['shareApp']);
                        Share.share(
                          "${context.read<MainJson>().data!['assets']['shareApp']}",
                          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
                        );
                        setState(() {});
                      },
                      child: Container(
                        height: 45.sp,
                        width: 1.sw,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1.w, color: Colors.white),
                          borderRadius: BorderRadius.circular(30.r),
                          color: Colors.black45,
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.sp),
                          child: Row(
                            children: [
                              Icon(
                                Icons.feedback_sharp,
                                size: isIpad
                                    ? 30.sp
                                    : isSmall
                                        ? 30.sp
                                        : 32.sp,
                                color: Colors.grey.shade300,
                              ),
                              SizedBox(width: 20.w),
                              Text(
                                'Share App',
                                style: GoogleFonts.figtree(
                                  fontSize: isIpad
                                      ? 20.sp
                                      : isSmall
                                          ? 20.sp
                                          : 24.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                GestureDetector(
                  onTap: () {
                    RateUs().showRateUsDialog();
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: Container(
                      height: 45.sp,
                      width: 1.sw,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.w, color: Colors.white),
                        borderRadius: BorderRadius.circular(30.r),
                        color: Colors.black45,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.sp),
                        child: Row(
                          children: [
                            Icon(
                              Icons.star_rate,
                              size: isIpad
                                  ? 30.sp
                                  : isSmall
                                      ? 30.sp
                                      : 32.sp,
                              color: Colors.grey.shade300,
                            ),
                            SizedBox(width: 20.w),
                            Text(
                              'RateUs',
                              style: GoogleFonts.figtree(
                                fontSize: isIpad
                                    ? 20.sp
                                    : isSmall
                                        ? 20.sp
                                        : 24.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        exit(0);
                      });
                    },
                    child: Container(
                      height: 45.sp,
                      width: 1.sw,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.w, color: Colors.white),
                        borderRadius: BorderRadius.circular(30.r),
                        color: Colors.black45,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.sp),
                        child: Row(
                          children: [
                            Icon(
                              Icons.exit_to_app_outlined,
                              size: isIpad
                                  ? 30.sp
                                  : isSmall
                                      ? 30.sp
                                      : 32.sp,
                              color: Colors.grey.shade300,
                            ),
                            SizedBox(width: 20.w),
                            Text(
                              'Exit App',
                              style: GoogleFonts.figtree(
                                fontSize: isIpad
                                    ? 20.sp
                                    : isSmall
                                        ? 20.sp
                                        : 24.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Spacer(flex: 5),
                Text(
                  'V${context.read<MainJson>().version}',
                  style: GoogleFonts.figtree(
                    fontSize: isIpad ? 20.sp : 22.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
