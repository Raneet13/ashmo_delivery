import 'package:dio/dio.dart';

import '../../data/app_url.dart';
import '../../data/network/api_helper.dart';

class OrderApiRepository {
  //login Repository
  Future allorderRepo({
    required String userId
  }) async {
    late var response;

    try {
      FormData formData =
          FormData.fromMap({'delivery_boy_id': userId});
      response = await NetworkApiService()
          .postApi(url: AppUrl.allorder, formData: formData);

      // response = await loginOtpModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
    return response;
  }
  Future orderStsUpdate({
    required String orderid,
    required String status,
    required String reason,
    dynamic image
  }) async {
    late var response;

    try {
      FormData formData =
          FormData.fromMap({'orderid': orderid,'status':status,'reason':reason,'image':image});
      response = await NetworkApiService()
          .postApi(url: AppUrl.orderStsupdate, formData: formData);

      // response = await loginOtpModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
    return response;
  }
}