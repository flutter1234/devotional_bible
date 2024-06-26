import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class splash_screen extends StatefulWidget {
  static const routeName = '/splash_screen';

  const splash_screen({super.key});

  @override
  State<splash_screen> createState() => _splash_screenState();
}

class _splash_screenState extends State<splash_screen> {
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
        body: Column(
          children: [
            Spacer(flex: 3),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25.r),
                child: Image(
                  fit: BoxFit.cover,
                  height: 125.sp,
                  width: 125.w,
                  image: AssetImage('assets/images/kids_bible_splash.png'),
                ),
              ),
            ),
            Spacer(flex: 2),
            Text(
              'Loading...',
              style: GoogleFonts.rubik(
                fontSize: 25.sp,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
