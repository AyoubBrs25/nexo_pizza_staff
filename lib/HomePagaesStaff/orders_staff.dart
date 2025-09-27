import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nexo_pizza_staff/HomePagaesStaff/add_order.dart';

class OrdersStaff extends StatefulWidget {
  const OrdersStaff({super.key});

  @override
  State<OrdersStaff> createState() => _OrdersStaffState();
}

class _OrdersStaffState extends State<OrdersStaff> {
  late final OrderImageController imageController;

  @override
  void initState() {
    super.initState();
    imageController = Get.find<OrderImageController>();
  }

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
                                  overflow: TextOverflow.ellipsis,
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
                                  SizedBox(
                                    width: 150.w,
                                    child: Text(
                                      '${index + 1} items  12,450.75DNA',
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff8D8D8D),
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: _confirmOrderBottomSheet,
                            child: Container(
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

  void _confirmOrderBottomSheet() {
    Get.bottomSheet(
      StatefulBuilder(
        builder: (context, setState) {
          return Container(
            width: 1.sw,
            padding: EdgeInsets.symmetric(vertical: 14.h),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
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
                  "Confirm Order",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.h),
                Divider(height: 5.h, color: Colors.grey[300]),
                SizedBox(height: 15.h),
                RecipeImagePicker(id: 'recive-image', size: 1.sw),
                SizedBox(height: 15.h),
                GestureDetector(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    padding: EdgeInsets.symmetric(vertical: 15.h),
                    width: 1.sw,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      color: Color(0xffE23A00),
                    ),
                    child: Center(
                      child: Text(
                        'Confirm',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      isDismissible: true,
      enableDrag: true,
      backgroundColor: Colors.transparent,
      barrierColor: Theme.of(context).scaffoldBackgroundColor == Colors.black
          ? Colors.grey.withAlpha(38)
          : Colors.grey.withAlpha(64),
    );
  }
}

class RecipeImagePicker extends StatelessWidget {
  final String id;
  final double size;
  final String placeholderText;

  const RecipeImagePicker({
    super.key,
    this.id = 'recive-image',
    this.size = 0,
    this.placeholderText = 'Add recipe image',
  });

  @override
  Widget build(BuildContext context) {
    final OrderImageController ctrl = Get.put(OrderImageController());

    return GetBuilder<OrderImageController>(
      builder: (c) {
        final file = c.file(id);
        final bool isDark =
            Theme.of(context).scaffoldBackgroundColor == Colors.black;
        final placeholderColor = isDark ? Colors.white : Colors.black87;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                if (file != null) {
                  // show full-screen preview
                  showDialog(
                    context: context,
                    builder: (_) => GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        color: Colors.black.withOpacity(0.9),
                        alignment: Alignment.center,
                        child: Image.file(file),
                      ),
                    ),
                  );
                } else {
                  ctrl.pickImage(id, ImageSource.gallery);
                }
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                width: 1.sw,
                height: 140.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  border: Border.all(color: Colors.grey, width: 1.w),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.r),
                  child: file != null
                      ? Image.file(file, fit: BoxFit.cover)
                      : Container(
                          alignment: Alignment.center,
                          color: Colors.transparent,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.photo_camera_outlined,
                                size: 40.r,
                                color: placeholderColor,
                              ),
                              SizedBox(height: 6.h),
                              Text(
                                placeholderText,
                                textAlign: TextAlign.center,
                                style: TextStyle(color: placeholderColor),
                              ),
                            ],
                          ),
                        ),
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: () => ctrl.pickImage(id, ImageSource.camera),
                    icon: Icon(
                      Icons.camera_alt,
                      size: 18.r,
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                    label: Text(
                      'Camera',
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffE23A00),
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 10.h,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  OutlinedButton.icon(
                    onPressed: () => ctrl.pickImage(id, ImageSource.gallery),
                    icon: Icon(
                      Icons.photo_library,
                      size: 18.r,
                      color:
                          Theme.of(context).scaffoldBackgroundColor ==
                              Colors.black
                          ? Colors.white
                          : Colors.black,
                    ),
                    label: Text(
                      'Gallery',
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        color:
                            Theme.of(context).scaffoldBackgroundColor ==
                                Colors.black
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 10.h,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.r),
                        side: BorderSide(color: Colors.grey, width: 1.w),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  if (file != null)
                    TextButton(
                      onPressed: () => ctrl.removeImage(id),
                      child: Text(
                        'Remove',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.red,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
