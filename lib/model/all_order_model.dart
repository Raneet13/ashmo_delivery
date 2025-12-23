// To parse this JSON data, do
//
//     final allOrderModel = allOrderModelFromJson(jsonString);

import 'dart:convert';

AllOrderModel allOrderModelFromJson(String str) => AllOrderModel.fromJson(json.decode(str));

String allOrderModelToJson(AllOrderModel data) => json.encode(data.toJson());

class AllOrderModel {
    final int? status;
    final bool? error;
    final String? message;
    final List<Order>? todayOrders;
    final List<Order>? allOrders;

    AllOrderModel({
        this.status,
        this.error,
        this.message,
        this.todayOrders,
        this.allOrders,
    });

    factory AllOrderModel.fromJson(Map<String, dynamic> json) => AllOrderModel(
        status: json["status"],
        error: json["error"],
        message: json["message"],
        todayOrders: json["today_orders"] == null ? [] : List<Order>.from(json["today_orders"]!.map((x) => Order.fromJson(x))),
        allOrders: json["all_orders"] == null ? [] : List<Order>.from(json["all_orders"]!.map((x) => Order.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "error": error,
        "message": message,
        "today_orders": todayOrders == null ? [] : List<dynamic>.from(todayOrders!.map((x) => x.toJson())),
        "all_orders": allOrders == null ? [] : List<dynamic>.from(allOrders!.map((x) => x.toJson())),
    };
}

class Order {
    final String? type;
    final String? orderId;
    final String? userId;
    final String? deliveryboyId;
    final String? status;
    final String? deliveryBoyName;
    final String? cutomerName;
    final String? customerContactno;
    final String? cityName;
    final String? stateName;
    final String? pincode;
    final String? lat;
    final String? lng;
    final String? address;
    final dynamic distance;
    final String? deliveryDate;
    final String? deliveryTime;
    final String? createdDate;
    final List<Product>? products;

    Order({
        this.type,
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

    factory Order.fromJson(Map<String, dynamic> json) => Order(
        type: json["type"],
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
        "type": type,
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
    final String? productname;
    final String? variationName;
    final String? qty;
    final String? img;
    final String? price;

    Product({
        this.productname,
        this.variationName,
        this.qty,
        this.img,
        this.price,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        productname: json["productname"],
        variationName: json["variation_name"],
        qty: json["qty"],
        img: json["img"],
        price: json["price"],
    );

    Map<String, dynamic> toJson() => {
        "productname": productname,
        "variation_name": variationName,
        "qty": qty,
        "img": img,
        "price": price,
    };
}
