import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nexo_pizza_staff/HomePagesManager/categogies.dart';
import 'package:nexo_pizza_staff/HomePagesManager/dashboard.dart';
import 'package:nexo_pizza_staff/HomePagesManager/products.dart';
import 'package:nexo_pizza_staff/HomePagesManager/suppliers.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';

class AllPages extends StatefulWidget {
  const AllPages({super.key});

  @override
  State<AllPages> createState() => _AllPagesState();
}

class _AllPagesState extends State<AllPages> {
  List<Widget> pages = [
    const Dashboard(),
    const Products(),
    const Categogies(),
    const Suppliers(),
  ];
  int pageIndex = 0;

  List<Widget> navigationIcons = [
    Icon(Icons.dashboard_rounded, size: 23.r),
    Icon(Icons.add_shopping_cart_rounded, size: 23.r),
    Icon(Icons.format_list_bulleted_rounded, size: 23.r),
    Icon(Icons.storefront_rounded, size: 23.r),
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

        bottomNavigationBar: SizedBox(
          height: 80.h,
          child: DotNavigationBar(
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
            enablePaddingAnimation: true,
            marginR: EdgeInsets.zero,
            paddingR: EdgeInsets.symmetric(vertical: 10.h),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            enableFloatingNavBar: true,
            currentIndex: pageIndex,
            onTap: (v) {
              setState(() {
                pageIndex = v;
              });
            },
            items: List.generate(navigationIcons.length, (indx) {
              return DotNavigationBarItem(
                icon: navigationIcons[indx],
                selectedColor: const Color(0xffE23A00),
              );
            }),
          ),
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