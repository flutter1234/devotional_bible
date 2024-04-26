import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

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
    return Scaffold(
      backgroundColor: Colors.black,
      body: SfPdfViewer.network(
        '${widget.pdf}',
        key: _pdfViewerKey,
      ),
    );
  }
}
