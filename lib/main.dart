import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pitangent_assignment/global/di/dependency_injection.dart';
import 'package:pitangent_assignment/global/presentation/router/app_router.dart';
import 'package:pitangent_assignment/global/util/navigation_service.dart';

Future<void> main() async {
  await initGetServiceLocator();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
