// To parse this JSON data, do
//
//     final allOrderModel = allOrderModelFromJson(jsonString);

import 'dart:convert';

AllOrderModel allOrderModelFromJson(String str) => AllOrderModel.fromJson(json.decode(str));

String allOrderModelToJson(AllOrderModel data) => json.encode(data.toJson());

class AllOrderModel {
    int? status;
    bool? error;
    String? message;
    List<Datum>? data;

    AllOrderModel({
        this.status,
        this.error,
        this.message,
        this.data,
    });

    factory AllOrderModel.fromJson(Map<String, dynamic> json) => AllOrderModel(
        status: json["status"],
        error: json["error"],
        message: json["message"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "error": error,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    String? orderId;
    String? userId;
    String? deliveryboyId;
    String? status;
    String? deliveryBoyName;
    String? cutomerName;
    String? customerContactno;
    String? cityName;
    String? stateName;
    String? pincode;
    String? lat;
    String? lng;
    String? address;
    String? distance;
    String? deliveryDate;
    String? deliveryTime;
    String? createdDate;
    List<Product>? products;

    Datum({
        this.orderId,
        this.userId,
        this.deliveryboyId,
        this.status,
        this.deliveryBoyName,
        this.cutomerName,
        this.customerContactno,
        this.cityName,
        this.stateName,
        this.pincode,
        this.lat,
        this.lng,
        this.address,
        this.distance,
        this.deliveryDate,
        this.deliveryTime,
        this.createdDate,
        this.products,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        orderId: json["order_id"],
        userId: json["user_id"],
        deliveryboyId: json["deliveryboy_id"],
        status: json["status"],
        deliveryBoyName: json["delivery_boy_name"],
        cutomerName: json["cutomer_name"],
        customerContactno: json["customer_contactno"],
        cityName: json["city_name"],
        stateName: json["state_name"],
        pincode: json["pincode"],
        lat: json["lat"],
        lng: json["lng"],
        address: json["address"],
        distance: json["distance"],
        deliveryDate: json["delivery_date"],
        deliveryTime: json["delivery_time"],
        createdDate: json["created_date"],
        products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "user_id": userId,
        "deliveryboy_id": deliveryboyId,
        "status": status,
        "delivery_boy_name": deliveryBoyName,
        "cutomer_name": cutomerName,
        "customer_contactno": customerContactno,
        "city_name": cityName,
        "state_name": stateName,
        "pincode": pincode,
        "lat": lat,
        "lng": lng,
        "address": address,
        "distance": distance,
        "delivery_date": deliveryDate,
        "delivery_time": deliveryTime,
        "created_date": createdDate,
        "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
    };
}

class Product {
    String? productname;
    String? variationId;
    String? qty;
    String? img;
    String? price;

    Product({
        this.productname,
        this.variationId,
        this.qty,
        this.img,
        this.price,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        productname: json["productname"],
        variationId: json["variation_id"],
        qty: json["qty"],
        img: json["img"],
        price: json["price"],
    );

    Map<String, dynamic> toJson() => {
        "productname": productname,
        "variation_id": variationId,
        "qty": qty,
        "img": img,
        "price": price,
    };
}
