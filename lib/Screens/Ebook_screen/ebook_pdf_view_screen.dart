import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../main.dart';

class ebook_pdf_view_screen extends StatefulWidget {
  static const routeName = '/ebook_pdf_view_screen';
  final pdf;

  const ebook_pdf_view_screen({super.key, required this.pdf});

  @override
  State<ebook_pdf_view_screen> createState() => _ebook_pdf_view_screenState();
}

class _ebook_pdf_view_screenState extends State<ebook_pdf_view_screen> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
        body: PDF(swipeHorizontal: true).cachedFromUrl('${widget.pdf}'),
      ),
    );
  }
}
