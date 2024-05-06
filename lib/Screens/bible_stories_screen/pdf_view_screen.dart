import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../main.dart';

class pdf_view_screen extends StatefulWidget {
  static const routeName = '/pdf_view_screen';
  final pdf;

  const pdf_view_screen({super.key, required this.pdf});

  @override
  State<pdf_view_screen> createState() => _pdf_view_screenState();
}

class _pdf_view_screenState extends State<pdf_view_screen> {
  final Completer<PDFViewController> controller = Completer<PDFViewController>();

  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

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
        body: SfPdfViewer.network(
          '${widget.pdf}',
          key: _pdfViewerKey,
        ),
      ),
    );
  }
}
