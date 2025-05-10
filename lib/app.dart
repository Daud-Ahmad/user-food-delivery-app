import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import 'routes.dart' as routes;

class MuraApp extends StatelessWidget {
  const MuraApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        // DeviceOrientation.landscapeLeft,
        // DeviceOrientation.landscapeRight,
      ],
    );

    final materialTheme = ThemeData(
      cupertinoOverrideTheme: const CupertinoThemeData(
          primaryColor: Color.fromRGBO(0x38, 0x7b, 0x96, 1.0)),
      primarySwatch: Colors.lightBlue,
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(const EdgeInsets.all(16.0)),
          foregroundColor: MaterialStateProperty.all(
              const Color.fromRGBO(0x38, 0x7b, 0x96, 1.0)),
        ),
      ),
    );

    return Theme(
      data: materialTheme,
      child: PlatformProvider(
        settings: PlatformSettingsData(iosUsesMaterialWidgets: true),
        builder: (context) => PlatformApp(
          debugShowCheckedModeBanner:false,
          localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
            DefaultMaterialLocalizations.delegate,
            DefaultWidgetsLocalizations.delegate,
            DefaultCupertinoLocalizations.delegate,
          ],
          title: 'Mura App',
          initialRoute: '/',
          routes: routes.appRoutes,
          material: (_, __) => MaterialAppData(
            theme: materialTheme,
          ),
          cupertino: (_, __) => CupertinoAppData(
            theme: const CupertinoThemeData(
              primaryColor: Color.fromRGBO(0x38, 0x7b, 0x96, 1.0),
            ),
          ),
        ),
      ),
    );
  }
}
