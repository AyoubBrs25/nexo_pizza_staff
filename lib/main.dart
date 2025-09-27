import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nexo_pizza_staff/Data_Mangement/bindings/auth_binding.dart';
import 'package:nexo_pizza_staff/Data_Mangement/controllers/auth_controller.dart';
import 'package:nexo_pizza_staff/HomePagesManager/all_pages.dart';
import 'package:nexo_pizza_staff/StartPages/welcom.dart';
import 'package:nexo_pizza_staff/State_Management/Conectivity_Test/dependency_injct.dart';
import 'package:nexo_pizza_staff/Theme/themes.dart';
import 'package:nexo_pizza_staff/StartPages/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await AuthBinding.init();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final box = GetStorage();
  late bool welcomDone;

  @override
  void initState() {
    super.initState();
    DependencyInjection.init();
    welcomDone = box.read('welcom_done') == true;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.system,
          theme: Themedata.lightTheme,
          darkTheme: Themedata.darkTheme,
          home: child,
        );
      },
      child: welcomDone ? const SplashPage() : const WelcomPage(),
    );
  }
}

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: Get.find<AuthController>().checkAutoLogin(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Scaffold(
            body: Center(
              child: LoadingAnimationWidget.threeArchedCircle(
                color: const Color(0xffe23a00),
                size: 25.sp,
              ),
            ),
          );
        }

        if (snapshot.data == true) {
          box.write("isLoggedIn", true);
          return const AllPages();
        } else {
          box.write("isLoggedIn", false);
          return const LoginPage();
        }
      },
    );
  }
}
