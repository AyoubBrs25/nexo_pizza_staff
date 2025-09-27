import 'package:get/get.dart';
import 'package:nexo_pizza_staff/Data_Mangement/models/product_model.dart';

class OrderCntrl extends GetxController {
  var supplierValue = 'Select Supplier'.obs;
  var productValue = 'Add Product'.obs;
  var products = <ProductModel>[].obs;
}
