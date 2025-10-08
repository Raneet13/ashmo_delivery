import 'dart:io';

import 'package:ashmo_delivery/core/show_toast/showTost_msg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../viewmodel/allorder_viewmodel.dart';

class NotDeliveredScreen extends StatefulWidget {
  final String OrderId;

  const NotDeliveredScreen({required this.OrderId, super.key}); 
  @override
  _NotDeliveredScreenState createState() => _NotDeliveredScreenState();
}

class _NotDeliveredScreenState extends State<NotDeliveredScreen> {
     final order = Get.find<AllorderViewmodel>();


  final List<String> reasons = [
    'Customer not available',
    'Customer refused to accept',
    'Incorrect address',
    'Unable to contact customer',
    'Order damaged or missing items',
  ];

  @override
  void dispose() {
    // reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('Order Not Delivered'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Obx(
            ()=>order.isLoading.value?SizedBox(height:  MediaQuery.of(context).size.height*0.8, child: SizedBox( 
              height: 20,width: 20,
              child: Center(child: CircularProgressIndicator(),))): Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Why was the order not delivered?',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Please select or enter the reason for non-delivery:',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 16),
                
                // Reason checkboxes
                Column(
                  children: reasons.map((reason) {
                    return InkWell(
                      onTap: (){
                       
                        order.selectResn(reason);
                      },
                      child: Container(
                        height: 50,
                        margin: EdgeInsets.symmetric(vertical: 4),
                        decoration: BoxDecoration(
                          color: order.selectedReason.value==reason?Colors.orange:Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.orange)
                        ),
                        child: Center(
                          child: Text(reason,style: TextStyle(color: order.selectedReason.value==reason?Colors.white:Colors.black,
                          fontSize: 16
                          ),),
                        ),
                      ),
                    );
                    // return CheckboxListTile(
                    //   title: Text(reason),
                    //   value: selectedReason == reason,
                    //   onChanged: (bool? value) {
                    //     setState(() {
                    //       selectedReason = value! ? reason : null;
                    //       if (value!) {
                    //         _reasonController.text = '';
                    //       }
                    //     });
                    //   },
                    //   controlAffinity: ListTileControlAffinity.leading,
                    //   contentPadding: EdgeInsets.zero,
                    // );
                  }).toList(),
                ),
                SizedBox(height: 12,),
                // Divider(thickness: 1, height: 32),
                
                // Custom reason field
                Text(
                  'Edit Reason:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: order.cancelReson,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter custom reason...',
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  ),
                  maxLines: 3,
                  // onChanged: (value) {
                  //   if (value.isNotEmpty) {
                  //     setState(() {
                  //       selectedReason = null;
                  //     });
                  //   }
                  // },
                ),
                SizedBox(height: 16),
                _fileUploadImage(context,"Upload Image",null,""),
                SizedBox(height: 24),
                
                // Save button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle save logic
                     final hasTypedReason = order.cancelReson.text.trim().isNotEmpty;
  final hasSelectedReason =order.selectedReason.value?.trim().isNotEmpty ?? false;
  final hasUploadedFile = order.uploadPick.value != null;
  if (hasTypedReason || hasSelectedReason || hasUploadedFile) {
    order.orderSts(orderId: widget.OrderId,sts: "3",reason:"${hasSelectedReason==true?hasSelectedReason:""},${hasTypedReason==true?hasTypedReason:""}").then((v){
      if (v) {
        Navigator.pop(context);
      }
      
    });
  }else{
ShowToast(msg: "Give the Reason Why are you Cancel order");
  }

                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: EdgeInsets.symmetric(vertical: 6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child:order.isLoading.value?SizedBox(height: 20,width: 20, child: Center(child: CircularProgressIndicator(),)):  Text(
                      'SAVE',
                      style: TextStyle(
                        fontSize:20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
   Widget _fileUploadImage(BuildContext context, String title,File? image,String kycImage) {
    return   Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              // border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(color: Colors.grey.shade300,blurRadius: 1,spreadRadius: 2)
              ]
            ),
            child:
       Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: TextStyle(fontSize: 15)),//GoogleFonts.montserrat.sp
          // SizedBox(height: 8),
          Row(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () {
                   order.insertFituredImage(context);
                    
                  }, child: Text("Select", style: TextStyle(fontSize: 14,color: Colors.white,fontWeight: FontWeight.bold))),
                  SizedBox(width: 10),
                   image!=null||kycImage!=""?
                    // SizedBox(
                    //     height: 50,
                    //     width: 50,
                    //     child: Padding(
                    //           padding: EdgeInsets.only(right: 8),
                    //           child:  ClipRRect(
                    //                 borderRadius: BorderRadius.circular(8), // Optional: for rounded square
                    //                 child: Image.file(
                    //                   image!,
                    //                   width: 50,
                    //                   height: 50,
                    //                   fit: BoxFit.cover,
                    //                 ),
                    //               ),),
                    //   )
                        Flexible(child:image!=null?ClipRRect(
                                    borderRadius: BorderRadius.circular(8), // Optional: for rounded square
                                    child: Image.file(
                                      image,
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ),
                                  ):
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8), // Optional: for rounded square
                                    child: Image.network(
                                      "${kycImage}",
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                   ,
                                   )  : 
                    Text("${order.uploadPick.value?? "No file selected"}", style: TextStyle(color: Colors.grey)),
                ],
              ),
         
          
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
