import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nexo_pizza_staff/Data_Mangement/models/product_model.dart';
import 'package:nexo_pizza_staff/State_Management/order_cntrl.dart';

class AddOrder extends StatefulWidget {
  const AddOrder({super.key});

  @override
  State<AddOrder> createState() => _AddOrderState();
}

class _AddOrderState extends State<AddOrder> {
  late final OrderCntrl orderCntrl;

  final TextEditingController quantContrl = TextEditingController();
  final TextEditingController noteContrl = TextEditingController();

  late final OrderImageController imageController;

  @override
  void initState() {
    super.initState();
    orderCntrl = Get.put(OrderCntrl());
    imageController = Get.put(OrderImageController());
  }

  @override
  void dispose() {
    quantContrl.dispose();
    super.dispose();
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
          scrolledUnderElevation: 0,
          leadingWidth: 60.w,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          leading: GestureDetector(
            onTap: () {
              Get.back();
              orderCntrl.products.clear();
              orderCntrl.productValue.value = 'Add Product';
              orderCntrl.supplierValue.value = 'Select Supplier';
            },
            child: Container(
              margin: EdgeInsets.only(left: 20.w),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor == Colors.black
                    ? Colors.grey.shade800
                    : Colors.grey.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.arrow_back_rounded, size: 20.r),
            ),
          ),
          title: Text(
            "Create Order",
            style: TextStyle(
              fontSize: 23.sp,
              color: Theme.of(context).scaffoldBackgroundColor == Colors.black
                  ? Colors.white
                  : Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          toolbarHeight: 50.h,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Column(
            children: [
              SizedBox(
                width: 1.sw,
                child: Text(
                  'Supplier',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color:
                        Theme.of(context).scaffoldBackgroundColor ==
                            Colors.black
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              GestureDetector(
                onTap: _suppliersBottomSheet,
                child: Container(
                  width: 1.sw,
                  padding: EdgeInsets.symmetric(
                    horizontal: 15.w,
                    vertical: 10.h,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    color: Theme.of(context).scaffoldBackgroundColor,
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                  child: Obx(
                    () => Text(
                      orderCntrl.supplierValue.value,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color:
                            Theme.of(context).scaffoldBackgroundColor ==
                                Colors.black
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15.h),
              SizedBox(
                width: 1.sw,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Products',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color:
                            Theme.of(context).scaffoldBackgroundColor ==
                                Colors.black
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        orderCntrl.productValue.value = 'Add Product';
                        quantContrl.clear();
                        _addProductBottomSheet();
                      },
                      child: Container(
                        padding: EdgeInsets.all(6.r),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xffE23A00),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.add,
                            size: 20.r,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              Obx(
                () => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(orderCntrl.products.length, (index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 10.h),
                      width: 1.sw,
                      padding: EdgeInsets.symmetric(
                        horizontal: 15.w,
                        vertical: 10.h,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(15.r),
                        border: Border.all(color: Colors.grey, width: 1),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.inventory_2_rounded,
                            size: 25.r,
                            color: const Color(0xffE23A00),
                          ),
                          Text(
                            orderCntrl.products[index].name!,
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color:
                                  Theme.of(context).scaffoldBackgroundColor ==
                                      Colors.black
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          Text(
                            orderCntrl.products[index].quantity.toString(),
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color:
                                  Theme.of(context).scaffoldBackgroundColor ==
                                      Colors.black
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(
                width: 1.sw,
                child: Text(
                  'Note',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color:
                        Theme.of(context).scaffoldBackgroundColor ==
                            Colors.black
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Container(
                width: 1.sw,
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  border: Border.all(color: Colors.grey, width: 1),
                ),
                child: Center(
                  child: TextFormField(
                    onChanged: (v) {},
                    onFieldSubmitted: (_) {},
                    controller: noteContrl,
                    style: TextStyle(
                      color:
                          Theme.of(context).scaffoldBackgroundColor ==
                              Colors.black
                          ? Colors.white
                          : Colors.black,
                      fontSize: 15.sp, // Using .sp for font size
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      hintText: 'Note',
                      hintStyle: TextStyle(
                        fontSize: 15.sp, // Using .sp for font size
                        fontWeight: FontWeight.w500,
                        color:
                            Theme.of(context).scaffoldBackgroundColor ==
                                Colors.black
                            ? Colors.white
                            : Colors.black,
                      ),
                      border: InputBorder.none,
                    ),
                    cursorColor: const Color(0xffE23A00),
                    maxLines: 2,
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Recive Image',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color:
                        Theme.of(context).scaffoldBackgroundColor ==
                            Colors.black
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              RecipeImagePicker(id: 'recive-image', size: 1.sw),
              SizedBox(height: 15.h),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                width: 1.sw,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  color: Color(0xffE23A00),
                ),
                child: Center(
                  child: Text(
                    'Create',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).scaffoldBackgroundColor,
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

  void _suppliersBottomSheet() {
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
                  "Suppliers",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.h),
                Divider(height: 5.h, color: Colors.grey[300]),
                Expanded(
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int indx) {
                      return RadioGroup(
                        groupValue: orderCntrl.supplierValue.value,
                        onChanged: (value) {
                          setState(() {
                            orderCntrl.supplierValue.value = value!;
                          });
                        },
                        child: RadioListTile(
                          title: Text(
                            "Supplier Name $indx",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color:
                                  Theme.of(context).scaffoldBackgroundColor ==
                                      Colors.black
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          activeColor: const Color(0xffe23a00),
                          value: "Supplier Name $indx",
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      isDismissible: true,
      enableDrag: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      barrierColor: Theme.of(context).scaffoldBackgroundColor == Colors.black
          ? Colors.grey.withAlpha(38)
          : Colors.grey.withAlpha(64),
    );
  }

  void _productsBottomSheet() {
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
                  "Suppliers",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.h),
                Divider(height: 5.h, color: Colors.grey[300]),
                Expanded(
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int indx) {
                      return RadioGroup(
                        groupValue: orderCntrl.productValue.value,
                        onChanged: (value) {
                          setState(() {
                            orderCntrl.productValue.value = value!;
                          });
                        },
                        child: RadioListTile(
                          title: Text(
                            "Product Name $indx",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color:
                                  Theme.of(context).scaffoldBackgroundColor ==
                                      Colors.black
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          activeColor: const Color(0xffe23a00),
                          value: "Product Name $indx",
                        ),
                      );
                    },
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

  void _addProductBottomSheet() {
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
                  "Add Product",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.h),
                Divider(height: 5.h, color: Colors.grey[300]),
                SizedBox(height: 15.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: _productsBottomSheet,
                        child: Container(
                          width: 0.65.sw,
                          padding: EdgeInsets.symmetric(
                            horizontal: 15.w,
                            vertical: 13.h,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r),
                            color: Theme.of(context).scaffoldBackgroundColor,
                            border: Border.all(color: Colors.grey, width: 1),
                          ),
                          child: Obx(
                            () => Text(
                              orderCntrl.productValue.value,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor ==
                                        Colors.black
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r),
                            color: Theme.of(context).scaffoldBackgroundColor,
                            border: Border.all(color: Colors.grey, width: 1),
                          ),
                          child: Center(
                            child: TextFormField(
                              onChanged: (v) {},
                              onFieldSubmitted: (_) {},
                              controller: quantContrl,
                              style: TextStyle(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor ==
                                        Colors.black
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                              ),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                hintText: 'Quantity',
                                hintStyle: TextStyle(
                                  fontSize: 14.sp, // Using .sp for font size
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
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15.h),
                GestureDetector(
                  onTap: () {
                    if (orderCntrl.productValue.value.isNotEmpty &&
                        quantContrl.text.isNotEmpty) {
                      orderCntrl.products.add(
                        ProductModel(
                          name: orderCntrl.productValue.value,
                          quantity: double.tryParse(quantContrl.text) ?? 0,
                        ),
                      );
                    }
                  },
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
                        'Add Product',
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

class OrderImageController extends GetxController {
  final RxMap<String, String> _images = <String, String>{}.obs;

  String? path(String id) => _images[id];

  File? file(String id) {
    final p = path(id);
    if (p == null || p.isEmpty) return null;
    return File(p);
  }

  Future<void> pickImage(String id, ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? picked = await picker.pickImage(
        source: source,
        maxWidth: 1600,
        maxHeight: 1600,
        imageQuality: 85,
      );
      if (picked != null) {
        _images[id] = picked.path;
        update();
        if (Get.context != null) {
          ScaffoldMessenger.of(Get.context!).showSnackBar(
            SnackBar(
              content: Text('Image selected'),
              backgroundColor: Color(0xffe23a00),
            ),
          );
        }
      } else {
        if (Get.context != null) {
          ScaffoldMessenger.of(Get.context!).showSnackBar(
            SnackBar(
              content: Text('No image selected'),
              backgroundColor: Color(0xffe23a00),
            ),
          );
        }
      }
    } catch (e) {
      debugPrint('pickImage error: $e');
      if (Get.context != null) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: Text('Error picking image'),
            backgroundColor: Color(0xffe23a00),
          ),
        );
      }
    }
  }

  void removeImage(String id) {
    if (_images.containsKey(id)) {
      _images.remove(id);
      update();
    }
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
            Row(
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
          ],
        );
      },
    );
  }
}
