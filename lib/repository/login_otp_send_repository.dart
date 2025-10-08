
import 'package:dio/dio.dart';

import '../../data/app_url.dart';
import '../../data/network/api_helper.dart';

class AuthApiRepository {
  //login Repository
  Future loginRepo({
    required String phone
  }) async {
    late var response;

    try {
      FormData formData =
          FormData.fromMap({'contact': phone});
      response = await NetworkApiService()
          .postApi(url: AppUrl.loginOtp, formData: formData);

      // response = await loginOtpModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
    return response;
  }

  
  //
  Future verifyOtp({
    required String phone,
  }) async {
    late var response;

    try {
      FormData formData = FormData.fromMap({'contact': phone});
      response = await NetworkApiService()
          .postApi(url: AppUrl.verifyOtp, formData: formData);

      // response = await loginOtpModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
    return response;
  }

 
}
