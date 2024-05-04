import 'package:cached_network_image/cached_network_image.dart';
import 'package:devotional_bible/AdPlugin/Ads/Banner/BannerWrapper.dart';
import 'package:devotional_bible/AdPlugin/Ads/Native/NativeRN.dart';
import 'package:devotional_bible/Screens/Ebook_screen/ebook_detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../AdPlugin/Ads/FullScreen/Ads.dart';
import '../../AdPlugin/MainJson/MainJson.dart';
import '../../Provider/api_provider.dart';
import '../../main.dart';

class ebook_screen extends StatefulWidget {
  static const routeName = '/ebook_screen';

  const ebook_screen({super.key});

  @override
  State<ebook_screen> createState() => _ebook_screenState();
}

class _ebook_screenState extends State<ebook_screen> {
  bool isLoading = true;

  @override
  void initState() {
    context.read<Api>().ebooksData(context.read<MainJson>().data!['assets']['ebooks']).then((value) {
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
            "God\'s Ebook",
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
                      padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 10.sp),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 200.sp,
                        crossAxisSpacing: 10.sp,
                        mainAxisSpacing: 10.sp,
                      ),
                      itemCount: dataProvider.eBooksList['ebooks'].length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            AdsRN().showFullScreen(
                              context: context,
                              onComplete: () {
                                Navigator.pushNamed(context, ebook_detail_screen.routeName, arguments: {"oneDataEbook": dataProvider.eBooksList['ebooks'][index], "index": index}).then((value) {
                                  setState(() {});
                                });
                              },
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r), color: Colors.black45, border: Border.all(width: 1.w, color: Colors.grey.shade800)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.r),
                                  child: CachedNetworkImage(
                                    height: isIpad
                                        ? 120.sp
                                        : isSmall
                                            ? 130.sp
                                            : 140.sp,
                                    width: 1.sw,
                                    imageUrl: dataProvider.eBooksList['ebooks'][index]['image'],
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
                                  padding: EdgeInsets.only(left: 5.w, top: isIpad ? 15.h:isSmall ? 10.h : 5.h, right: 2.w),
                                  child: Text(
                                    maxLines: 2,
                                    "${dataProvider.eBooksList['ebooks'][index]['Name']}",
                                    style: GoogleFonts.figtree(
                                      fontSize: isIpad
                                          ? 15.sp
                                          : isSmall
                                              ? 14.sp
                                              : 16.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
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
