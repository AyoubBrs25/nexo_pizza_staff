import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nexo_pizza_staff/HomePagaesStaff/add_order.dart';
import 'package:nexo_pizza_staff/HomePagaesStaff/dashboard_staff.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:nexo_pizza_staff/HomePagaesStaff/orders_staff.dart';

class AllPagesStaff extends StatefulWidget {
  const AllPagesStaff({super.key});

  @override
  State<AllPagesStaff> createState() => _AllPagesState();
}

class _AllPagesState extends State<AllPagesStaff> {
  List<Widget> pages = [
    const DashboardStaff(),
    const AddOrder(),
    const OrdersStaff(),
  ];
  int pageIndex = 0;

  List<Widget> navigationIcons = [
    Icon(Icons.dashboard_rounded, size: 23.r),
    Container(
      padding: EdgeInsets.all(6.r),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xffE23A00),
      ),
      child: Icon(
        Icons.add,
        size: 23.r,
        color: Theme.of(Get.context!).scaffoldBackgroundColor,
      ),
    ),
    Icon(Icons.add_shopping_cart_rounded, size: 23.r),
  ];

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        systemStatusBarContrastEnforced: false,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness:
            Theme.of(context).brightness == Brightness.light
            ? Brightness.dark
            : Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarContrastEnforced: false,
        systemNavigationBarIconBrightness:
            Theme.of(context).brightness == Brightness.light
            ? Brightness.dark
            : Brightness.light,
      ),
      child: Scaffold(
        extendBody: true,
        bottomNavigationBar: DotNavigationBar(
          dotIndicatorColor: Colors.transparent,
          borderRadius: 20.r,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).scaffoldBackgroundColor == Colors.black
                  ? Colors.white.withAlpha(51)
                  : Colors.black.withAlpha(51),
              blurRadius: 8,
              spreadRadius: 2,
              offset: Offset(2, 1),
            ),
          ],
          splashColor: Colors.transparent,
          margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 0),
          enablePaddingAnimation: false,
          marginR: EdgeInsets.zero,
          paddingR: EdgeInsets.zero,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          enableFloatingNavBar: true,
          currentIndex: pageIndex,
          onTap: (v) {
            if (v == 1) {
              Get.to(() => const AddOrder(), transition: Transition.downToUp);
            } else {
              setState(() {
                pageIndex = v;
              });
            }
          },
          items: List.generate(navigationIcons.length, (indx) {
            return DotNavigationBarItem(
              icon: navigationIcons[indx],
              selectedColor: const Color(0xffE23A00),
            );
          }),
        ),
        body: IndexedStack(index: pageIndex, children: pages),
      ),
    );
  }
}




// boxShadow: [
//               BoxShadow(
//                 color: Theme.of(context).scaffoldBackgroundColor == Colors.black
//                     ? Colors.white.withAlpha(51)
//                     : Colors.black.withAlpha(51),
//                 blurRadius: 8,
//                 spreadRadius: 2,
//                 offset: Offset(2, 1),
//               ),
//             ],