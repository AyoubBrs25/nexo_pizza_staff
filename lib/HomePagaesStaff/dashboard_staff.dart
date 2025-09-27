import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DashboardStaff extends StatefulWidget {
  const DashboardStaff({super.key});

  @override
  State<DashboardStaff> createState() => _DashboardStaffState();
}

class _DashboardStaffState extends State<DashboardStaff> {
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
        body: Padding(
          padding: EdgeInsets.only(top: 50.h),
          child: SizedBox(
            width: 1.sw,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50.r,
                  backgroundImage: AssetImage(
                    'assetes/images/profile_picture_hero_before.jpg',
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  'Hi, Ramy👋',
                  style: TextStyle(
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w800,
                    color:
                        Theme.of(context).scaffoldBackgroundColor ==
                            Colors.black
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: SizedBox(
                    width: 1.sw,
                    child: Text(
                      'My Tasks',
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w800,
                        color:
                            Theme.of(context).scaffoldBackgroundColor ==
                                Colors.black
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.only(
                      top: 10.h,
                      bottom: 70.h,
                      right: 20.w,
                      left: 20.w,
                    ),
                    itemCount: 10,
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 15.h),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          _showLocationBottomSheet(index + 1);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 15.w,
                            vertical: 18.h,
                          ),
                          width: 1.sw,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r),
                            color: Theme.of(context).scaffoldBackgroundColor,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Task ${index + 1}',
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
                              Text(
                                timeDifferenceFromNow(
                                  DateTime(2025, 09, 27, 8),
                                ),
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
                              Text(
                                index % 2 == 0
                                    ? 'Completed'
                                    : (index % 3 == 0
                                          ? 'Cancelled'
                                          : 'Pending'),
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w800,
                                  color: index % 2 == 0
                                      ? Colors.green
                                      : (index % 3 == 0
                                            ? Colors.red
                                            : Colors.orange),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showLocationBottomSheet(int index) {
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true, // allow sheet to expand beyond default height
      backgroundColor: Colors.transparent, // keep same visual feel
      barrierColor:
          Theme.of(Get.context!).scaffoldBackgroundColor == Colors.black
          ? Colors.grey.withAlpha(38)
          : Colors.grey.withAlpha(64),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.50,
          minChildSize: 0.40,
          maxChildSize: 0.90,
          expand:
              false, // important to prevent it from filling entire screen immediately
          builder: (context, scrollController) {
            return Container(
              width: 1.sw,
              padding: EdgeInsets.symmetric(vertical: 14.h),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(15),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40.w,
                    height: 3.h,
                    margin: EdgeInsets.only(bottom: 13.h),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  Text(
                    'Task$index Details',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Divider(height: 5.h, color: Colors.grey[300]),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: SizedBox(
                      width: 1.sw,
                      child: Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: SizedBox(
                      width: 1.sw,
                      child: Text(
                        'Yes, if Brand X mozzarella is available, go for that. For the tomato sauce, just make sure it’s high quality. Flour should be top-grade for pizzas, you know the usual supplier.',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        softWrap: true,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: SizedBox(
                      width: 1.sw,
                      child: Text(
                        'Task Products',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      padding: EdgeInsets.symmetric(vertical: 5.h),
                      itemCount: index,
                      itemBuilder: (context, i) {
                        return Container(
                          padding: EdgeInsets.all(10.r),
                          margin: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 5.h,
                          ),
                          width: 1.sw,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1.w, color: Colors.grey),
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                radius: 20.r,
                                backgroundImage: AssetImage(
                                  'assetes/images/profile_picture_hero_before.jpg',
                                ),
                              ),
                              SizedBox(
                                width: 100.w,
                                child: Text(
                                  'Chicken',
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                '25Kg',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffE23A00),
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  (index) % 2 == 0
                      ? Container(
                          margin: EdgeInsets.symmetric(horizontal: 20.w),
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          width: 1.sw,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r),
                            color: Color(0xffE23A00),
                          ),
                          child: Center(
                            child: Text(
                              'Complete',
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(
                                  context,
                                ).scaffoldBackgroundColor,
                              ),
                            ),
                          ),
                        )
                      : SizedBox(),
                ],
              ),
            );
          },
        );
      },
    );
  }

  String timeDifferenceFromNow(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.isNegative) {
      final futureDiff = date.difference(now);
      if (futureDiff.inDays > 0) {
        return "in ${futureDiff.inDays} day(s)";
      } else if (futureDiff.inHours > 0) {
        return "in ${futureDiff.inHours} hour(s)";
      } else if (futureDiff.inMinutes > 0) {
        return "in ${futureDiff.inMinutes} minute(s)";
      } else {
        return "in ${futureDiff.inSeconds} second(s)";
      }
    } else {
      // date is in the past
      if (diff.inDays > 0) {
        return "${diff.inDays} day(s) ago";
      } else if (diff.inHours > 0) {
        return "${diff.inHours} hour(s) ago";
      } else if (diff.inMinutes > 0) {
        return "${diff.inMinutes} minute(s) ago";
      } else {
        return "${diff.inSeconds} second(s) ago";
      }
    }
  }
}
