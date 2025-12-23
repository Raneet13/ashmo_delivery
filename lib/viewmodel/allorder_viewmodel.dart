
import 'dart:io';

import 'package:ashmo_delivery/repository/order_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart' as dio;
import '../core/show_toast/showTost_msg.dart';
import '../model/all_order_model.dart';

class AllorderViewmodel extends GetxController {
    var isLoading = true.obs;
Rx<AllOrderModel> allorder = AllOrderModel().obs;
TextEditingController search =TextEditingController();
RxList<Order> searchOrder = <Order>[].obs;
RxString userProfileImage = "".obs;
//cancelorder
TextEditingController cancelReson =TextEditingController();
Rxn<String> selectedReason = Rxn<String>();
Rx<File?> uploadPick = Rx<File?>(null);
final ImagePicker _picker = ImagePicker();

// // Rx<OrderDetails?> orderDetails = OrderDetails().obs;

// //   @override
// //   void onInit() {
// //     viewAllorder();
// //     super.onInit();
// //   }
  Future viewAllorder() async {
    isLoading(true);
    try {
      final prefs = await SharedPreferences.getInstance();
   String? userId =  await prefs.getString('userId');
      var resp = await OrderApiRepository().allorderRepo(userId: userId!,);
      if (resp != null) {
        isLoading(false);
        // print(resp);
        // if (resp["error"]) {
        //   // ShowToast(msg: "No order");
        // } else {
         allorder.value = AllOrderModel.fromJson(resp);   
        // }
      
      }
    } catch (e) {debugPrint(e.toString());} finally {
      isLoading(false);
    }
  }
    Future orderSts({required String orderId, required String sts,String? reason}) async {
      bool res = false;
    isLoading(true);
    try {
  //     final prefs = await SharedPreferences.getInstance();
  //  String? userId =  await prefs.getString('userId');
      var resp = await OrderApiRepository().orderStsUpdate(orderid: orderId, status: sts, reason: reason??"",image: uploadPick.value == null
            ? ""
            : dio.MultipartFile.fromFileSync(uploadPick.value!.path,
                filename: uploadPick.value!.path.split('/').last));
      if (resp != null&&resp["error"]==false) {
        res =true;
        viewAllorder();
        cancelReson.clear();
        selectedReason.value=null;
        uploadPick.value=null;
        isLoading(false);
      }else{
        ShowToast(msg: "${resp['messages']['status'].toString()}");
      }
    } catch (e) {
        ShowToast(msg: e.toString());
      isLoading(false);
      debugPrint(e.toString());
      } finally {
      isLoading(false);
    }
    return res;
  }
  searchDeliveryboyorder({required String query}){
    query = query.toLowerCase();

  searchOrder.value = (allorder.value.allOrders ?? []).where((order) {
  
  final lowerQuery = query.toLowerCase();

  final matchesProduct = (order.products != null)
      ? order.products!.any((product) =>
          (product.productname ?? '').toLowerCase().contains(lowerQuery))
      : false;

  return ((order.orderId ?? '').toLowerCase().contains(lowerQuery) ||
      (order.cutomerName ?? '').toLowerCase().contains(lowerQuery) ||
      (order.customerContactno ?? '').toLowerCase().contains(lowerQuery) ||
      (order.cityName ?? '').toLowerCase().contains(lowerQuery) ||
      (order.pincode ?? '').toLowerCase().contains(lowerQuery) ||
      (order.address ?? '').toLowerCase().contains(lowerQuery) ||
      (order.deliveryDate ?? '').toLowerCase().contains(lowerQuery) ||
      (order.deliveryTime ?? '').toLowerCase().contains(lowerQuery) ||
      matchesProduct);
}).toList();
  }

//upload image
insertFituredImage(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            content: Text("Choose the medium of your Image"),
            actions: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Photo Library'),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  // context.pop();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Camera'),
                onTap: () {
                  _pickImage(ImageSource.camera);
                   Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(
        source: source, maxWidth: 400, imageQuality: 45);

    if (pickedFile != null) {
      // final imageFile = File(pickedFile.path);
      // final imageSize = await imageFile.length();
      // ToastUtil.showToast(msg: extension);
     uploadPick.value = File(pickedFile.path);
    } else {
      ShowToast(msg: 'No image selected.');
    }
  }
  selectResn(String resn){
    selectedReason.value=resn;
    refresh();
  }
}