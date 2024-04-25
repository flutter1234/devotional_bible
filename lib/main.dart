import 'package:devotional_bible/Provider/api_provider.dart';
import 'package:devotional_bible/Screens/Splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:devotional_bible/Routes/Routes.dart' as r;

Future<void> main() async {
  await GetStorage.init();
  runApp(MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
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
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 600) {
      isIpad = true;
    } else if (screenWidth < 420) {
      isSmall = true;
    }
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Api(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            theme: ThemeData(
              scaffoldBackgroundColor: HexColor('006DAE'),
            ),
            onGenerateRoute: r.Router.onRouteGenrator,
            debugShowCheckedModeBanner: false,
            home: splash_screen(),
          );
        },
      ),
    );
  }
}
