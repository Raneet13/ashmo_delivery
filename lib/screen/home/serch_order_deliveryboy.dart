import 'package:ashmo_delivery/screen/home/not_deliver_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../viewmodel/allorder_viewmodel.dart';

class SerchOrderDeliveryboy extends StatelessWidget {
  const SerchOrderDeliveryboy({super.key});

  @override
  Widget build(BuildContext context) {
    final order = Get.find<AllorderViewmodel>();
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 70,
          backgroundColor: Colors.white,
          elevation: 0.5,
          title: Row(
            children: [
              Image.asset('asset/logo/image.png', height: 30),
              const SizedBox(width: 16),
        
         
            ],
          ),),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                   Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 13,
                                  vertical: 0,
                                ),
                                // width: MediaQuery.of(context).size.width * 0.8,
                                height: 45,
                                
                                // decoration: BoxDecoration(
                                  // color: Colors.red,
                                
                                //   borderRadius: BorderRadius.circular(8),
                                //   // border: Border.all(color: AppColors.grey, width: 2),
                                // ),
                                child: TextFormField(
                                  obscureText: false,
                                
                                  controller: order.search,
                                  onChanged: (value) {
                                    // setState(() {
                                    // });
                                    order.searchDeliveryboyorder(query: value);
                                   
                                  },
                                  // readOnly: true,
                                  style: TextStyle(color: Colors.black),
                                  cursorColor:Colors.black,
                                  cursorHeight: 20,
                                  
                                  decoration: const InputDecoration(
                                    
                                    fillColor: Colors.white,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(8)),
                                    borderSide: BorderSide(color: Colors.orange), // No border
                                    ),
                                    contentPadding: EdgeInsets.only(left: 18,right: 18),
                                    hintStyle: TextStyle(color: Colors.black),
                                    hintText: 'Search',
                                    suffixIcon: const Icon(Icons.search, color: Colors.black,size: 20,),
                                      suffixIconConstraints: const BoxConstraints(
                                        minHeight: 20,
                                        minWidth: 30,
                                      ),
                                    // suffixIcon:Align(alignment: Alignment.centerRight, child: const Icon(Icons.search))
                                  ),
                                ),
                              ),
               Obx(
                ()=>order.isLoading.value?SizedBox(height: 20,width: 20, child: Center(child: CircularProgressIndicator(),)): order.searchOrder.length==0&&order.search.text ==""?
                 ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 46),
                      itemCount: order.allorder.value.allOrders?.length??0,
                      itemBuilder: (context, index) {
                         final todayOrder = order.allorder.value.allOrders?[index];
                        return  Container(
                      // width: 300,
                      margin: EdgeInsets.symmetric(vertical: 4),
                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                      decoration: BoxDecoration(
                        // border: Border.all(color: Colors.grey.shade300),
                        // borderRadius: BorderRadius.circular(8),
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.black.withOpacity(0.1),
                        //     blurRadius: 4,
                        //     offset: Offset(0, 2),
                        //   ),
                        // ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                             // Order ID and Get Direction
                  Row(
                      children: [
                        const Icon(Icons.location_on_outlined, size: 24),
                        const SizedBox(width: 8),
                             
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Order ID",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                             const SizedBox(width: 6),
                       Text(todayOrder?.orderId??"", style: TextStyle(color: Colors.black54)),
                          ],
                        ),
                       
                        const Spacer(),
                        // Icon(Icons.check_circle, color: Colors.green),
                        // const SizedBox(width: 4),
                        
                      todayOrder?.status=="3"?  Row(
                          children: [
                            Icon(Icons.close, color: Colors.redAccent),
                             const SizedBox(width: 4),
                        Text("Cancelled", style: TextStyle(color: Colors.red)),
                          ],
                        ):todayOrder?.status=="5"||todayOrder?.status=="2"?  Row(
                          children: [
                            Icon(Icons.check_circle, color: Colors.green),
                             const SizedBox(width: 4),
                        Text("Delivered", style: TextStyle(color: Colors.green)),
                          ],
                        ):Column(
                          children: [
                            Image.asset("asset/image/image (5).png",height: 40,),
                            Text("Get Direction", style: TextStyle(color: Colors.orangeAccent)),
                          ],
                        ),
                       
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.account_circle_outlined, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                todayOrder?.cutomerName??"",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                               SizedBox(width: 6),
                       Text(todayOrder?.customerContactno??"", style: TextStyle(color: Colors.black54)),
                            ],
                          ),
                        
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.home_outlined, size: 24, color: Colors.orange),
                        const SizedBox(width: 8),
                        Column(
                           mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Home",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                             const SizedBox(width: 6),
                            Text(
                              todayOrder?.address??"",
                              style: TextStyle(color: Colors.black54),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    
                     
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.fastfood_outlined, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            todayOrder?.products?.map((t)=>t.productname??"").toList().join(", ").toString()??"",
                            style: TextStyle(color: Colors.black54),
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 4),
                    Row(
                      children: [
                       Expanded(
                         child: ListTile(
                          dense: true,
                  visualDensity: VisualDensity(horizontal: -4),
                          minLeadingWidth: 3,
                          contentPadding: EdgeInsets.zero,
                          // minVerticalPadding: 0,
                                         leading: const Icon(Icons.calendar_today_outlined, size: 18),
                                         title: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                            "Delivered Date",
                            style: TextStyle(color: Colors.black54,fontSize: 16),
                          ),
                          // const SizedBox(height: 4),
                         todayOrder?.deliveryDate==null?SizedBox(): Text(todayOrder?.deliveryDate==null?"": DateFormat("dd/MM/yyyy").format(DateTime.parse(todayOrder?.deliveryDate??"")).toString(),style: TextStyle(color: Colors.black,fontSize: 14),),
                          ],
                                         ),
                                       ),
                       ),
                    Expanded(
                      child: ListTile(
                        dense: true,
                  visualDensity: VisualDensity(horizontal: -4),
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(Icons.calendar_today_outlined, size: 18),
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                            "Delivered Time",
                            style: TextStyle(color: Colors.black54,fontSize: 16),
                          ),
                          // const SizedBox(height: 6),
                          todayOrder?.deliveryTime==null?SizedBox(): Text(todayOrder?.deliveryTime==null?"":DateFormat("HH:mm:ss").parse(todayOrder?.deliveryTime??"").toString(),style: TextStyle(color: Colors.black,fontSize: 14)),
                          ],
                        ),
                      ),
                    ),
                      ],
                    ),
                  
                             SizedBox(height: 15),
                        
                             // Delivered status
                            todayOrder?.status=="5"||todayOrder?.status=="2"||todayOrder?.status=="3"?SizedBox(): Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(onPressed: (){
                      order.orderSts(orderId: todayOrder?.orderId??"",sts: "5");
                    },
                     style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightGreenAccent.shade400,
                    foregroundColor: Colors.white,
                    // minimumSize: Size.zero,
                    visualDensity: VisualDensity(vertical: -3),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                     padding: EdgeInsets.symmetric(horizontal: 16,vertical: 0)
                                  ),
                     child: Text(
                                'Delivered',
                                
                                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                                ),
                              ),
                              ),
                 SizedBox(width: 12,), 
                 ElevatedButton(
                  onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                             builder: (context) =>  NotDeliveredScreen(OrderId: todayOrder?.orderId??"",), // Replace with your next screen
                        ),
                      );
                    
                  }, 
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                     padding: EdgeInsets.symmetric(horizontal: 12,vertical: 2),
                    //  minimumSize: Size(0, 12), // control height directly
                     tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                     visualDensity: VisualDensity(vertical: -3)
                  ),
                  child: Text(
                  'Not Delivered',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                           ),
                           )
                  ],
                             )
                             ,
                             SizedBox(height: 6,),
                             Divider()
                        ],
                      ),
                    );
                  }):order.searchOrder.length==0?SizedBox( 
                    height: MediaQuery.of(context).size.height*0.8,
                    child: Center(child: Text("No Order"),)): ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 46),
                      itemCount: order.searchOrder.length??0,
                      itemBuilder: (context, index) {
                         final todayOrder = order.searchOrder[index];
                        return  Container(
                      // width: 300,
                      margin: EdgeInsets.symmetric(vertical: 4),
                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                      decoration: BoxDecoration(
                        // border: Border.all(color: Colors.grey.shade300),
                        // borderRadius: BorderRadius.circular(8),
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.black.withOpacity(0.1),
                        //     blurRadius: 4,
                        //     offset: Offset(0, 2),
                        //   ),
                        // ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                             // Order ID and Get Direction
                  Row(
                      children: [
                        const Icon(Icons.location_on_outlined, size: 24),
                        const SizedBox(width: 8),
                             
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Order ID",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                             const SizedBox(width: 6),
                       Text(todayOrder?.orderId??"", style: TextStyle(color: Colors.black54)),
                          ],
                        ),
                       
                        const Spacer(),
                        // Icon(Icons.check_circle, color: Colors.green),
                        // const SizedBox(width: 4),
                        
                      todayOrder?.status=="3"?  Row(
                          children: [
                            Icon(Icons.close, color: Colors.redAccent),
                             const SizedBox(width: 4),
                        Text("Cancelled", style: TextStyle(color: Colors.red)),
                          ],
                        ):todayOrder?.status=="5"||todayOrder?.status=="2"?  Row(
                          children: [
                            Icon(Icons.check_circle, color: Colors.green),
                             const SizedBox(width: 4),
                        Text("Delivered", style: TextStyle(color: Colors.green)),
                          ],
                        ):Column(
                          children: [
                            Image.asset("asset/image/image (5).png",height: 40,),
                            Text("Get Direction", style: TextStyle(color: Colors.orangeAccent)),
                          ],
                        ),
                       
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.account_circle_outlined, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                todayOrder?.cutomerName??"",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                               SizedBox(width: 6),
                       Text(todayOrder?.customerContactno??"", style: TextStyle(color: Colors.black54)),
                            ],
                          ),
                        
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.home_outlined, size: 24, color: Colors.orange),
                        const SizedBox(width: 8),
                        Column(
                           mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Home",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                             const SizedBox(width: 6),
                            Text(
                              todayOrder?.address??"",
                              style: TextStyle(color: Colors.black54),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    
                     
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.fastfood_outlined, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            todayOrder?.products?.map((t)=>t.productname??"").toList().join(", ").toString()??"",
                            style: TextStyle(color: Colors.black54),
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 4),
                    Row(
                      children: [
                       Expanded(
                         child: ListTile(
                          dense: true,
                  visualDensity: VisualDensity(horizontal: -4),
                          minLeadingWidth: 3,
                          contentPadding: EdgeInsets.zero,
                          // minVerticalPadding: 0,
                                         leading: const Icon(Icons.calendar_today_outlined, size: 18),
                                         title: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                            "Delivered Date",
                            style: TextStyle(color: Colors.black54,fontSize: 16),
                          ),
                          // const SizedBox(height: 4),
                         todayOrder?.deliveryDate==null?SizedBox(): Text(todayOrder?.deliveryDate==null?"": DateFormat("dd/MM/yyyy").format(DateTime.parse(todayOrder?.deliveryDate??"")).toString(),style: TextStyle(color: Colors.black,fontSize: 14),),
                          ],
                                         ),
                                       ),
                       ),
                    Expanded(
                      child: ListTile(
                        dense: true,
                  visualDensity: VisualDensity(horizontal: -4),
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(Icons.calendar_today_outlined, size: 18),
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                            "Delivered Time",
                            style: TextStyle(color: Colors.black54,fontSize: 16),
                          ),
                          // const SizedBox(height: 6),
                          todayOrder?.deliveryTime==null?SizedBox(): Text(todayOrder?.deliveryTime==null?"":DateFormat("HH:mm:ss").parse(todayOrder?.deliveryTime??"").toString(),style: TextStyle(color: Colors.black,fontSize: 14)),
                          ],
                        ),
                      ),
                    ),
                      ],
                    ),
                  
                             SizedBox(height: 15),
                        
                             // Delivered status
                            todayOrder?.status=="5"||todayOrder?.status=="2"||todayOrder?.status=="3"?SizedBox(): Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(onPressed: (){
                      order.orderSts(orderId: todayOrder?.orderId??"",sts: "5");
                    },
                     style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightGreenAccent.shade400,
                    foregroundColor: Colors.white,
                    // minimumSize: Size.zero,
                    visualDensity: VisualDensity(vertical: -3),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                     padding: EdgeInsets.symmetric(horizontal: 16,vertical: 0)
                                  ),
                     child: Text(
                                'Delivered',
                                
                                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                                ),
                              ),
                              ),
                 SizedBox(width: 12,), 
                 ElevatedButton(
                  onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                             builder: (context) =>  NotDeliveredScreen(OrderId: todayOrder?.orderId??"",), // Replace with your next screen
                        ),
                      );
                    
                  }, 
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                     padding: EdgeInsets.symmetric(horizontal: 12,vertical: 2),
                    //  minimumSize: Size(0, 12), // control height directly
                     tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                     visualDensity: VisualDensity(vertical: -3)
                  ),
                  child: Text(
                  'Not Delivered',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                           ),
                           )
                  ],
                             )
                             ,
                             SizedBox(height: 6,),
                             Divider()
                        ],
                      ),
                    );
                  }),
               ),
              
                ],
              ),
            ),
          ),
    );
  }
}