import 'package:dual_screen/controller.dart';
import 'package:get/get.dart';

class RootBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<FavController>(FavController());
  }
}