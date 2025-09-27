import 'package:get/get.dart';
import 'package:nexo_pizza_staff/State_Management/connection_cntrl.dart';

class DependencyInjection {
  static void init() {
    Get.put<ConnectionCntrl>(ConnectionCntrl(), permanent: true);
  }
}
