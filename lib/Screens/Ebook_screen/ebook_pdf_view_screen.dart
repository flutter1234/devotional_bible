import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ebook_pdf_view_screen extends StatefulWidget {
  static const routeName = '/ebook_pdf_view_screen';
  final pdf;

  const ebook_pdf_view_screen({super.key, required this.pdf});

  @override
  State<ebook_pdf_view_screen> createState() => _ebook_pdf_view_screenState();
}

class _ebook_pdf_view_screenState extends State<ebook_pdf_view_screen> {
  final Completer<PDFViewController> controller = Completer<PDFViewController>();

  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SfPdfViewer.network(
        scrollDirection: PdfScrollDirection.horizontal,
        '${widget.pdf}',
        key: _pdfViewerKey,
      ),
    );
  }
}
