// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
    int? status;
    bool? error;
    Messages? messages;

    ProfileModel({
        this.status,
        this.error,
        this.messages,
    });

    factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
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
    String? userId;
    String? fullname;
    String? email;
    String? contact;
    String? status;
    String? lat;
    String? lng;
    String? storeImage;
    bool? isLoggedIn;

    Status({
        this.userId,
        this.fullname,
        this.email,
        this.contact,
        this.status,
        this.lat,
        this.lng,
        this.storeImage,
        this.isLoggedIn,
    });

    factory Status.fromJson(Map<String, dynamic> json) => Status(
        userId: json["user_id"],
        fullname: json["fullname"],
        email: json["email"],
        contact: json["contact"],
        status: json["status"],
        lat: json["lat"],
        lng: json["lng"],
        storeImage: json["store_image"],
        isLoggedIn: json["isLoggedIn"],
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "fullname": fullname,
        "email": email,
        "contact": contact,
        "status": status,
        "lat": lat,
        "lng": lng,
        "store_image": storeImage,
        "isLoggedIn": isLoggedIn,
    };
}
