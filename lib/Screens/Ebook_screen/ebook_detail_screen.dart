import 'dart:io';
import 'package:devotional_bible/AdPlugin/Ads/Banner/BannerWrapper.dart';
import 'package:devotional_bible/AdPlugin/Ads/FullScreen/Ads.dart';
import 'package:devotional_bible/AdPlugin/Ads/Native/NativeRN.dart';
import 'package:devotional_bible/Screens/Ebook_screen/ebook_pdf_view_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

import '../../AdPlugin/MainJson/MainJson.dart';
import '../../main.dart';

class ebook_detail_screen extends StatefulWidget {
  static const routeName = '/ebook_detail_screen';

  final oneDataEbook;
  final index;

  const ebook_detail_screen({super.key, required this.oneDataEbook, required this.index});

  @override
  State<ebook_detail_screen> createState() => _ebook_detail_screenState();
}

class _ebook_detail_screenState extends State<ebook_detail_screen> {
  void sharePdfFile(File pdfFile, String subject, String message) {
    Share.shareFiles([pdfFile.path], subject: subject, text: message);
  }

  bool download = false;

  Future<void> downloadFile(String url, String fileName) async {
    final Directory documentsDir = await getApplicationDocumentsDirectory();
    final String savePath = '${documentsDir.path}/$fileName';

    try {
      await Dio().download(url, savePath).then((value) {
        download = false;
        setState(() {});
      });
      print('Downloaded: $savePath');
    } catch (e) {
      print('Error downloading file: $e');
    }
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
            "${widget.oneDataEbook['Name']}",
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: isIpad ? 10.sp : 20.sp),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      height: isIpad
                          ? 170.sp
                          : isSmall
                              ? 200.sp
                              : 220.sp,
                      width: 1.sw,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r), color: Colors.black45, border: Border.all(width: 1.5.w, color: Colors.grey.shade800)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        child: Image.network(
                          fit: BoxFit.fitWidth,
                          "${widget.oneDataEbook['image']}",
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 10.w, bottom: 10.h),
                      child: GestureDetector(
                        onTap: () {
                          download = true;
                          final String url = '${context.read<MainJson>().data!['ebooksPdf']}/${widget.oneDataEbook['Name']}.pdf';
                          final String fileName = 'Ebook${widget.index + 1}.pdf';
                          downloadFile(url, fileName);
                          setState(() {});
                        },
                        child: Container(
                          height: isIpad ? 35.sp : 40.sp,
                          width: isIpad ? 35.w : 40.w,
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            shape: BoxShape.circle,
                            border: Border.all(width: 1.w, color: Colors.white),
                          ),
                          child: download
                              ? CupertinoActivityIndicator(
                                  radius: 10.r,
                                  color: Colors.white,
                                )
                              : Icon(
                                  Icons.download,
                                  size: isIpad ? 20.sp : 30.sp,
                                  color: Colors.white,
                                ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 10.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        AdsRN().showFullScreen(
                          context: context,
                          onComplete: () {
                            Navigator.pushNamed(
                              context,
                              ebook_pdf_view_screen.routeName,
                              arguments: "${context.read<MainJson>().data!['ebooksPdf']}/${widget.oneDataEbook['Name']}.pdf",
                            );
                          },
                        );
                      },
                      child: Container(
                        height: 55.sp,
                        width: 150.w,
                        decoration: BoxDecoration(
                          color: HexColor('b4d22f'),
                          border: Border.all(width: 1.w, color: Colors.white),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.picture_as_pdf_rounded,
                              size: 30.sp,
                              color: Colors.black,
                            ),
                            Text(
                              textAlign: TextAlign.justify,
                              "VIEW",
                              style: GoogleFonts.figtree(
                                fontSize: isIpad
                                    ? 12.sp
                                    : isSmall
                                        ? 13.sp
                                        : 15.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        File pdfFile = File('${context.read<MainJson>().data!['ebooksPdf']}/${widget.oneDataEbook['Name']}.pdf');
                        String subject = 'Sharing PDF';
                        String message = 'Check out this PDF file!';
                        sharePdfFile(pdfFile, subject, message);
                        setState(() {});
                      },
                      child: Container(
                        height: 55.sp,
                        width: 150.w,
                        decoration: BoxDecoration(
                          color: HexColor('73c9d7'),
                          border: Border.all(width: 1.w, color: Colors.white),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.share,
                              size: 30.sp,
                              color: Colors.black,
                            ),
                            Text(
                              textAlign: TextAlign.justify,
                              "SHARE",
                              style: GoogleFonts.figtree(
                                fontSize: isIpad
                                    ? 12.sp
                                    : isSmall
                                        ? 13.sp
                                        : 15.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              NativeRN(parentContext: context),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.sp),
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r), color: Colors.black45),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 10.sp),
                    child: Column(
                      children: [
                        Text(
                          textAlign: TextAlign.justify,
                          "PRAYER",
                          style: GoogleFonts.abhayaLibre(
                            fontSize: isIpad
                                ? 22.sp
                                : isSmall
                                    ? 24.sp
                                    : 25.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          textAlign: TextAlign.justify,
                          "${widget.oneDataEbook['Details']}",
                          style: GoogleFonts.figtree(
                            fontSize: isIpad
                                ? 16.sp
                                : isSmall
                                    ? 17.sp
                                    : 20.sp,
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
      ),
    );
  }
}
