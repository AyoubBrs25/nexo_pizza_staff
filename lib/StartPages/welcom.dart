import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nexo_pizza_staff/StartPages/login.dart';

class WelcomPage extends StatefulWidget {
  const WelcomPage({super.key});

  @override
  State<WelcomPage> createState() => _WelcomPageState();
}

class _WelcomPageState extends State<WelcomPage> {
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Color.fromARGB(168, 255, 10, 55),
        systemNavigationBarContrastEnforced: true,
        systemNavigationBarIconBrightness:
            Theme.of(context).brightness == Brightness.light
            ? Brightness.dark
            : Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Container(
          width: 1.sw,
          height: 1.sh,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assetes/images/background.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: Stack(
            children: [
              Image(
                image: AssetImage("assetes/images/blur_background.png"),
                width: 1.sw,
                height: 1.sh,
                fit: BoxFit.fill,
                opacity: AlwaysStoppedAnimation(0.7),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 20.h),
                    Image(
                      image: AssetImage("assetes/logos/bradn_name.png"),
                      width: 200.w,
                    ),
                    SizedBox(height: 20.h),
                    Image(
                      image: AssetImage("assetes/logos/slice.png"),
                      width: 150.w,
                      height: 200.h,
                    ),
                    SizedBox(height: 20.h),
                    SizedBox(
                      width: 250.w,
                      height: 150.h,
                      child: Text(
                        'Welcome to Nexo Pizza where every purchase fuels the perfect slice!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w800,
                        ),
                        textAlign: TextAlign.center,
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () {
                    box.write("welcom_done", true);
                    Get.offAll(
                      () => LoginPage(),
                      transition: Transition.rightToLeft,
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20.h),
                    width: (1.sw - 40.w),
                    height: 50.h,
                    decoration: BoxDecoration(
                      color: Color(0xffe23a00),
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: Center(
                      child: Text(
                        'Get Started',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
