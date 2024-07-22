import 'package:dart_ping_ios/dart_ping_ios.dart';
import 'package:devotional_bible/AdPlugin/Utils/Extensions.dart';
import 'package:devotional_bible/Provider/api_provider.dart';
import 'package:devotional_bible/Screens/Home_screen/home_screen.dart';
import 'package:devotional_bible/Screens/Splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:devotional_bible/Routes/Routes.dart' as r;

import 'AdPlugin/AdLoader/AdLoader.dart';
import 'AdPlugin/Provider/AdpluginProvider.dart';
import 'AdPlugin/Screen/SplashScreen.dart';
import 'AdPlugin/Utils/NavigationService.dart';

Future<void> main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(MyApp());
}

GetStorage storage = GetStorage();
bool isIpad = false;
bool isSmall = false;

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    DartPingIOS.register();
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 600) {
      isIpad = true;
    } else if (screenWidth < 420) {
      isSmall = true;
    }
    return AdpluginProvider(
      child: AdLoader(
        child: ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (context) => Api()),
              ],
              child: MaterialApp(
                home: AdSplashScreen(
                    onComplete: (context, mainJson) async {
                      "/splash_screen".performAction(
                        context: context,
                        onComplete: () {
                          Navigator.pushReplacementNamed(context, home_screen.routeName);
                        },
                      );
                    },
                    servers: const [
                      "miracocopepsi.com",
                      "coinspinmaster.com",
                      "trailerspot4k.com",
                    ],
                    jsonUrl: const [
                      "https://miracocopepsi.com/admin/mayur/coc/viral/iosapp/jenis/devotional_bible/kids bible/main.json",
                      "https://coinspinmaster.com/viral/iosapp/jenis/devotional_bible/kids bible/main.json",
                      "https://trailerspot4k.com/viral/iosapp/jenis/devotional_bible/kids bible/main.json"
                    ],
                    version: '1.0.0',
                    child: const splash_screen()),
                theme: ThemeData(
                  scaffoldBackgroundColor: Colors.transparent,
                ),
                navigatorKey: NavigationService.navigatorKey,
                onGenerateRoute: r.Router.onRouteGenrator,
                debugShowCheckedModeBanner: false,
              ),
            );
          },
        ),
      ),
    );
  }
}
