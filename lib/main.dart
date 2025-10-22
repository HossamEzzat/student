import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:screen_protector/screen_protector.dart';
import 'package:student/core/app/routes.dart';
import 'package:student/core/di/injection_container.dart';
import 'package:student/core/network/api_service.dart';
import 'package:zap_sizer/zap_sizer.dart';
import 'package:zapx/zapx.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  injectionContainer.init(ApiService.instance);
 await ScreenProtector.preventScreenshotOn();

  runApp(DevicePreview(enabled: false, builder: (c) => const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ZapSizer(
      builder: (_, _) => const XMaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: onGenerateRoute,
        initialRoute: Routes.splash,
      ),
    );
  }
}

final logger=Logger();


/*




 */