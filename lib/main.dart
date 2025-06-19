import 'package:device_preview_plus/device_preview_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pitangent_assignment/global/di/dependency_injection.dart';
import 'package:pitangent_assignment/global/presentation/router/app_router.dart';
import 'package:pitangent_assignment/global/util/navigation_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initGetServiceLocator();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  return runApp(
    DevicePreview(enabled: !kReleaseMode, builder: (context) => const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final AppRouter router = AppRouter();
    final textTheme = Theme.of(context).textTheme;
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: const Size(411, 891),

      builder: (context, child) => MaterialApp(
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(
              context,
            ).copyWith(textScaler: TextScaler.linear(1.0)),
            child: child!,
          );
        },
        theme: ThemeData(textTheme: GoogleFonts.poppinsTextTheme(textTheme)),
        debugShowCheckedModeBanner: false,
        navigatorKey: getIt<NavigationService>().navigatorKey,
        onGenerateRoute: router.onGenerateRoute,
      ),
    );
  }
}
