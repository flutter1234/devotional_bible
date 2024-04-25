import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
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
                      padding: EdgeInsets.all(5.sp),
                      child: Container(
                        height: 50.sp,
                        width: 1.sw,
                        decoration: BoxDecoration(
                            // color: Colors.black54,
                            ),
                        child: Center(
                          child: Text(
                            textAlign: TextAlign.center,
                            "${dataProvider.keyList[index]}",
                            style: GoogleFonts.figtree(
                              fontSize: 22.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 150.sp,
                      child: ListView.builder(
                        itemCount: dataProvider.bibleStoriesList['Bible Stories'][index][dataProvider.keyList[index]].length,
                        padding: EdgeInsets.only(left: 10.w),
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index1) {
                          return Padding(
                            padding: EdgeInsets.only(right: 10.w),
                            child: Container(
                              height: 120.sp,
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
                                  imageUrl: dataProvider.bibleStoriesList['Bible Stories'][index][dataProvider.keyList[index]][index1]['The Creation Story'][0]['image'],
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
                          );
                        },
                      ),
                    )
                  ],
                );
              },
            ),
    );
  }
}
