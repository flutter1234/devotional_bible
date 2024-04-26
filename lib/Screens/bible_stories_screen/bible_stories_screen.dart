import 'package:cached_network_image/cached_network_image.dart';
import 'package:devotional_bible/Screens/bible_stories_screen/bible_stories_detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import '../../Provider/api_provider.dart';

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

    context.read<Api>().storiesData().then((value) {
      dataProvider.keyList.clear();
      dataProvider.bibleStoriesList['Bible Stories'].forEach((element) {
        dataProvider.keyList.addAll(element.keys.toList());
      });
      isLoading = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Api dataProvider = Provider.of<Api>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
        title: Text(
          "Bible Stories",
          style: GoogleFonts.figtree(
            fontSize: 25.sp,
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
          : ListView.builder(
              shrinkWrap: true,
              itemCount: dataProvider.keyList.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.sp),
                      child: Container(
                        height: 60.sp,
                        width: 1.sw,
                        decoration: BoxDecoration(
                            // color: Colors.black54,
                            ),
                        child: Center(
                          child: Text(
                            textAlign: TextAlign.center,
                            "${dataProvider.keyList[index]}",
                            style: GoogleFonts.figtree(
                              fontSize: 25.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 210.sp,
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
                                        Navigator.pushNamed(
                                          context,
                                          bible_stories_detail_screen.routeName,
                                          arguments: {
                                            "oneStories": dataProvider.bibleStoriesList['Bible Stories'][index][dataProvider.keyList[index]][index1][subKeyList[index1]][index2],
                                          },
                                        );
                                        print("oneStories =====>>>>>${dataProvider.bibleStoriesList['Bible Stories'][index][dataProvider.keyList[index]][index1][subKeyList[index1]][index2]}");
                                        setState(() {});
                                      },
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            height: 150.sp,
                                            width: 250.w,
                                            decoration: BoxDecoration(
                                              color: Colors.black54,
                                              border: Border.all(width: 2.w, color: Colors.white),
                                              borderRadius: BorderRadius.circular(10.r),
                                            ),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(9.r),
                                              child: CachedNetworkImage(
                                                height: 100.sp,
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
                                            height: 60.sp,
                                            width: 60.w,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(width: 4.w, color: Colors.white),
                                              color: HexColor('9247a9'),
                                            ),
                                            child: Icon(
                                              Icons.play_arrow,
                                              size: 45.sp,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  Text(
                                    textAlign: TextAlign.center,
                                    "${dataProvider.bibleStoriesList['Bible Stories'][index][dataProvider.keyList[index]][index1][subKeyList[index1]][index2]['title']}",
                                    style: GoogleFonts.figtree(
                                      fontSize: 20.sp,
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
    );
  }
}
