import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrdersStaff extends StatefulWidget {
  const OrdersStaff({super.key});

  @override
  State<OrdersStaff> createState() => _OrdersStaffState();
}

class _OrdersStaffState extends State<OrdersStaff> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
        systemNavigationBarContrastEnforced: true,
        systemNavigationBarIconBrightness:
            Theme.of(context).brightness == Brightness.light
            ? Brightness.dark
            : Brightness.light,
      ),
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 0,
          leading: SizedBox(),
          scrolledUnderElevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          toolbarHeight: 50.h,
          title: Text(
            "My Orders",
            style: TextStyle(
              fontSize: 22.sp,
              color: Theme.of(context).scaffoldBackgroundColor == Colors.black
                  ? Colors.white
                  : Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: ListView.separated(
          padding: EdgeInsets.only(
            right: 20.w,
            left: 20.w,
            top: 15.h,
            bottom: 65.h,
          ),
          itemCount: 10,
          separatorBuilder: (context, index) => SizedBox(height: 15.h),
          itemBuilder: (context, index) => Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 10.h),
                width: 1.sw,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.r),
                    topRight: Radius.circular(15.r),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color:
                          Theme.of(context).scaffoldBackgroundColor ==
                              Colors.black
                          ? Colors.white.withAlpha(51)
                          : Colors.black.withAlpha(51),
                      blurRadius: 8,
                      spreadRadius: 2,
                      offset: Offset(2, 1),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.r,
                      backgroundImage: AssetImage(
                        'assetes/images/profile_picture_hero_before.jpg',
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 150.w,
                                child: Text(
                                  'Hamoud Boualem.',
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w800,
                                    color:
                                        Theme.of(
                                              context,
                                            ).scaffoldBackgroundColor ==
                                            Colors.black
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.inventory_rounded,
                                    size: 15.r,
                                    color:
                                        Theme.of(
                                              context,
                                            ).scaffoldBackgroundColor ==
                                            Colors.black
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                  SizedBox(width: 2.w),
                                  Text(
                                    '${index + 1} items  12,450.75DNA',
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff8D8D8D),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.w,
                              vertical: 3.h,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(11.r),
                              color: Color(0xffF99E24),
                            ),
                            child: Center(
                              child: Text(
                                'Sent',
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(
                                    context,
                                  ).scaffoldBackgroundColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 1.sw,
                padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 10.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15.r),
                    bottomRight: Radius.circular(15.r),
                  ),
                  color: Color.fromARGB(113, 141, 141, 141),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Order ID',
                              style: TextStyle(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w600,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor ==
                                        Colors.black
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                            Text(
                              'PO-002',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor ==
                                        Colors.black
                                    ? Colors.white
                                    : const Color.fromARGB(120, 0, 0, 0),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'Order Date',
                              style: TextStyle(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w600,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor ==
                                        Colors.black
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                            Text(
                              '2025/09/25',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor ==
                                        Colors.black
                                    ? Colors.white
                                    : const Color.fromARGB(120, 0, 0, 0),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'Expected',
                              style: TextStyle(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w600,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor ==
                                        Colors.black
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                            Text(
                              '2025/09/28',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor ==
                                        Colors.black
                                    ? Colors.white
                                    : const Color.fromARGB(120, 0, 0, 0),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      width: 1.sw,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                        color: Color(0xffE23A00),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.file_download_rounded,
                              size: 18.r,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            Text(
                              'Download PDF',
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(
                                  context,
                                ).scaffoldBackgroundColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
