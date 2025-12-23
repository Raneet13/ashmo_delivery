import 'package:ashmo_delivery/data/app_url.dart';
import 'package:ashmo_delivery/model/all_order_model.dart';
import 'package:flutter/material.dart';

class ViewAllProduct extends StatelessWidget {
  final List<Product>? products;
  const ViewAllProduct({this.products, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Products"),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.only(left: 12,right: 12),
        itemBuilder: (context, index) {
        final product = products![index];
        return Container(
          margin: EdgeInsets.only(bottom: 8),
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              products?[index].img != null
                  ? Image.network(
                      "${AppUrl.imageApi}${products?[index].img!}",
                      height: 100,
                      width: 100,
                      fit: BoxFit.fill,
                    )
                  : Container(
                      height: 100,
                      width: 100,
                      color: Colors.grey,
                      child: const Icon(Icons.image, size: 50),
                    ),
              const SizedBox(width: 8),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      text: products?[index].productname ?? "",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        if (products?[index].variationName != null &&
                            products![index].variationName!.isNotEmpty)
                          TextSpan(
                            text: " (${products?[index].variationName})",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                      ],
                    ),
                  ),
                  Text.rich(
                    
                      TextSpan(
                      text: "Quantity: ",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                      text: products?[index].qty ?? "",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    ])
                    
                  ),
                  Text.rich(
                    
                      TextSpan(
                      text: "Price: ",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                      text: products?[index].price ?? "",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    ])
                    
                  ),
                ],
              ),
              
            ],
          ),
        );
      }, itemCount: products?.length ?? 0,),
    );
  }
}