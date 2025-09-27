import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:nexo_pizza_staff/HomePagaesStaff/all_pages_staff.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailContrl = TextEditingController();
  TextEditingController passContrl = TextEditingController();
  bool showpasswrd = false;

  //bool loader = false;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Color.fromARGB(202, 255, 10, 55),
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
              image: AssetImage("assetes/images/background2.png"),
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
                opacity: AlwaysStoppedAnimation(0.8),
              ),
              Padding(
                padding: EdgeInsets.only(right: 20.w, left: 20.w, top: 40.h),
                child: Column(
                  children: [
                    Image(
                      image: AssetImage('assetes/logos/logo2.png'),
                      width: 150.w,
                      fit: BoxFit.fill,
                    ),
                    SizedBox(height: 40.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 6.h,
                      ), // Changed to .w for horizontal, .h for vertical
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.r),
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            IonIcons.mail,
                            color: const Color(0xffE23A00),
                            size: 24.r, // Changed to .w for icon size
                          ),
                          SizedBox(
                            width: 10.w,
                          ), // Changed to .w for horizontal spacing
                          Expanded(
                            child: SizedBox(
                              child: TextFormField(
                                autofillHints: const [AutofillHints.email],
                                autofocus: true,
                                onChanged: (v) {
                                  setState(() {});
                                },
                                onFieldSubmitted: (_) {},
                                controller: emailContrl,
                                style: TextStyle(
                                  color:
                                      Theme.of(
                                            context,
                                          ).scaffoldBackgroundColor ==
                                          Colors.black
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 15.sp, // Using .sp for font size
                                  fontWeight: FontWeight.w500,
                                ),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  hintText: 'Email',
                                  hintStyle: TextStyle(
                                    fontSize: 16.sp, // Using .sp for font size
                                    fontWeight: FontWeight.w500,
                                    color:
                                        Theme.of(
                                              context,
                                            ).scaffoldBackgroundColor ==
                                            Colors.black
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                  border: InputBorder.none,
                                ),
                                cursorColor: const Color(0xffE23A00),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 6.h,
                      ), // Changed to .w for horizontal, .h for vertical
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.r),
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            IonIcons.lock_closed,
                            color: const Color(0xffE23A00),
                            size: 24.r, // Changed to .w for icon size
                          ),
                          SizedBox(
                            width: 10.w,
                          ), // Changed to .w for horizontal spacing
                          Expanded(
                            child: SizedBox(
                              child: TextFormField(
                                autofillHints: const [AutofillHints.email],
                                autofocus: true,
                                onChanged: (v) {
                                  setState(() {});
                                },
                                onFieldSubmitted: (_) {},
                                controller: passContrl,
                                style: TextStyle(
                                  color:
                                      Theme.of(
                                            context,
                                          ).scaffoldBackgroundColor ==
                                          Colors.black
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 15.sp, // Using .sp for font size
                                  fontWeight: FontWeight.w500,
                                ),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  hintText: 'Password',
                                  hintStyle: TextStyle(
                                    fontSize: 16.sp, // Using .sp for font size
                                    fontWeight: FontWeight.w500,
                                    color:
                                        Theme.of(
                                              context,
                                            ).scaffoldBackgroundColor ==
                                            Colors.black
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                  border: InputBorder.none,
                                ),
                                cursorColor: const Color(0xffE23A00),
                                obscureText: !showpasswrd,
                                obscuringCharacter: '●',
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                showpasswrd = !showpasswrd;
                              });
                            },
                            child: Icon(
                              showpasswrd ? EvaIcons.eye : EvaIcons.eye_off,
                              size: 22.r,
                              color: const Color(0xffE23A00),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () {
                    if (emailContrl.text.contains('@')) {
                      Get.to(
                        () => AllPagesStaff(),
                        transition: Transition.rightToLeft,
                      );
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20.h),
                    width: (1.sw - 40.w),
                    height: 50.h,
                    decoration: BoxDecoration(
                      color:
                          (!emailContrl.text.contains('@') ||
                              passContrl.text.length < 8)
                          ? const Color.fromARGB(111, 226, 56, 0)
                          : const Color(0xffE23A00),
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: Center(
                      child: Text(
                        'Login',
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
