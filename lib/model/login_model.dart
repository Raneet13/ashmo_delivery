// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
    int? status;
    bool? error;
    Messages? messages;

    LoginModel({
        this.status,
        this.error,
        this.messages,
    });

    factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        status: json["status"],
        error: json["error"],
        messages: json["messages"] == null ? null : Messages.fromJson(json["messages"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "error": error,
        "messages": messages?.toJson(),
    };
}

class Messages {
    String? responsecode;
    Status? status;

    Messages({
        this.responsecode,
        this.status,
    });

    factory Messages.fromJson(Map<String, dynamic> json) => Messages(
        responsecode: json["responsecode"],
        status: json["status"] == null ? null : Status.fromJson(json["status"]),
    );

    Map<String, dynamic> toJson() => {
        "responsecode": responsecode,
        "status": status?.toJson(),
    };
}

class Status {
    String? contactOtp;
    int? loginOtp;

    Status({
        this.contactOtp,
        this.loginOtp,
    });

    factory Status.fromJson(Map<String, dynamic> json) => Status(
        contactOtp: json["contact_otp"],
        loginOtp: json["login_otp"],
    );

    Map<String, dynamic> toJson() => {
        "contact_otp": contactOtp,
        "login_otp": loginOtp,
    };
}
