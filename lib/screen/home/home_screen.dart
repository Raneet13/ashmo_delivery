import 'package:ashmo_delivery/screen/home/not_deliver_screen.dart';
import 'package:ashmo_delivery/screen/home/serch_order_deliveryboy.dart';
import 'package:ashmo_delivery/screen/notification/notification_screen.dart';
import 'package:ashmo_delivery/screen/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../data/app_url.dart';
import '../../viewmodel/allorder_viewmodel.dart';
import '../../viewmodel/auth_viewmodel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late TabController _tabController;
  final login = Get.find<AuthViewmodel>();
final order = Get.find<AllorderViewmodel>();
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_){
      order.viewAllorder();
      login.profileData();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final orders = [
    {
      'id': '#523623',
      'user': 'Dibya',
      'phone': '+91 1111111111',
      'address': '#744, UE, Phase-II, Ludhiana',
      'items': 'Besan-2kg, Condensed milk(3 pack), Cheese-1/2kg, Butter-1/2kg',
      'date': '25/05/2025',
      'time': '01:45 PM',
    },
    {
      'id': '#523623',
      'user': 'Ranjan',
      'phone': '+91 2222222222',
      'address': '#744, UE, Phase-II, Ludhiana',
      'items': 'Besan-2kg, Condensed milk(3 pack), Cheese-1/2kg, Butter-1/2kg',
      'date': '25/05/2025',
      'time': '01:45 PM',
    },
    {
      'id': '#523623',
      'user': 'Dibya',
      'phone': '+91 1111111111',
      'address': '#744, UE, Phase-II, Ludhiana',
      'items': 'Besan-2kg, Condensed milk(3 pack), Cheese-1/2kg, Butter-1/2kg',
      'date': '25/05/2025',
      'time': '01:45 PM',
    },
    {
      'id': '#523623',
      'user': 'Ranjan',
      'phone': '+91 2222222222',
      'address': '#744, UE, Phase-II, Ludhiana',
      'items': 'Besan-2kg, Condensed milk(3 pack), Cheese-1/2kg, Butter-1/2kg',
      'date': '25/05/2025',
      'time': '01:45 PM',
    },
  ];


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool? exitApp = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Exit App"),
            content: const Text("Are you sure you want to close the application?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false), // Stay
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true), // Exit
                child: const Text("Yes"),
              ),
            ],
          ),
        );
        return exitApp ?? false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar:_selectedIndex==1?null: AppBar(
          toolbarHeight: 70,
          backgroundColor: Colors.white,
          elevation: 0.5,
          title: Row(
            children: [
              Image.asset('asset/logo/image.png', height: 30),
              const SizedBox(width: 16),
        
         
            ],
          ),
          actions: [
      
            IconButton(
               padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
              // style: IconButton.styleFrom(
              //   backgroundColor: Colors.white,
              //   shape: CircleBorder(),
              //   padding: EdgeInsets.zero
              // ),
              icon: Icon(Icons.notifications_none, color: Colors.black), onPressed: () {
              
               Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const NotificationScreen(), // Replace with your next screen
          ),
        );
            }),
          Obx(
            ()=>login.isLoading.value?SizedBox(height: 20,width: 20, child: Center(child: CircularProgressIndicator(),)): login.profile.value.messages?.status?.storeImage==null||login.profile.value.messages?.status?.storeImage==""?  IconButton(
                 padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                icon: Icon(Icons.person_outline, color: Colors.black), onPressed: () {
                    //       Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) =>  ProfileScreen(), // Replace with your next screen
                    //   ),
                    // );
                    setState(() {
            _selectedIndex=1;
                    });
                
              }):CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.grey[300],
                          backgroundImage: login.profile.value.messages?.status?.storeImage != null
                            ? NetworkImage("${AppUrl.imageApi}${login.profile.value.messages?.status?.storeImage}")
                            : null,),
          ),
                          SizedBox(width: 14,)
          ],
        ),
        body:_selectedIndex==1?ProfileScreen(): Column(
          children: [
            SizedBox(height: 12,),
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
                          readOnly: true,
                            // controller: _searchProduct,
                            // onChanged: (value) {
                            //   // setState(() {
                            //   // });
                             
                            // },
                            // readOnly: true,
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>SerchOrderDeliveryboy()));
                            },
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
            // Tab Bar
            Container(
              color: Colors.white,
              child: TabBar(
                padding: EdgeInsets.zero,
                controller: _tabController,
                indicatorColor: Colors.orange,
                
                labelColor: Colors.black,
                labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                unselectedLabelStyle: TextStyle(fontSize: 18),
                unselectedLabelColor: Colors.black54,
                // labelStyle: TextStyle(fontWeight: FontWeight.bold),
                dividerColor: Colors.transparent,
                tabs: const [
                  Tab(text: "Today's Order"),
                  Tab(text: "Delivered Order"),
                ],
              ),
            ),
        
            // Tab Content
            Expanded(
              child: Obx(
                ()=>order.isLoading.value?SizedBox(height: 20,width: 20, child: Center(child: CircularProgressIndicator(),)):  TabBarView(
                  controller: _tabController,
                  children: [
                    _todayorder(),
                    _buildOrderListView(),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16,)
          ],
        ),
      
        // Bottom Navigation Bar
        bottomSheet: Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            // border: Border(top: BorderSide(color: Colors.grey.shade300, width: 0.5)),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
            boxShadow: [
              BoxShadow(
                color: Colors.white,
                blurRadius: 4,
                offset: Offset(0, -2),
              ),
            ]
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    // Action for the first button
                    // print('Button 1 tapped');
                    setState(() {
                      _selectedIndex=0;
                    });
                  },
                  child: Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
             color:_selectedIndex==0? Colors.orange:Colors.white,
            // border: Border(top: BorderSide(color: Colors.grey.shade300, width: 0.5)),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(12), bottomLeft: Radius.circular(12)
            )),
                   
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.home_outlined,color: _selectedIndex==0? Colors.white:Colors.grey,size: 26,),
                        SizedBox(width: 4,),
                        Text(
                        'Home',
                        style: TextStyle(color:_selectedIndex==0? Colors.white:Colors.grey, fontSize: 18),
                      ),
                      ],
                      
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    // Action for the second button
                    // print('Button 2 tapped');
                    setState(() {
                      _selectedIndex=1;
                    });
                  },
                  child: Container(
                    width: 150,
                    height: 50,
                    // color: _selectedIndex==1? Colors.orange:Colors.white,
                      decoration: BoxDecoration(
             color:_selectedIndex==1? Colors.orange:Colors.white,
            // border: Border(top: BorderSide(color: Colors.grey.shade300, width: 0.5)),
            borderRadius: BorderRadius.only(topRight: Radius.circular(12), bottomRight: Radius.circular(12)
            )),
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.account_circle_outlined,color: _selectedIndex==1? Colors.white:Colors.grey,size: 26,),
                        SizedBox(width: 4,),
                        Text(
                        'Profile',
                        style: TextStyle(color:_selectedIndex==1? Colors.white:Colors.grey, fontSize: 18),
                      ),
                      ],
                      
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
  Widget _todayorder(){
    return order.allorder.value.data?.length==0?Center(child: Text("No Order"),): ListView.builder(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 46),
      itemCount: order.allorder.value.data?.length??0,
      itemBuilder: (context, index) {
         final todayOrder = order.allorder.value.data?[index];
        return todayOrder?.status=="5"||todayOrder?.status=="3"||todayOrder?.status=="2"?SizedBox(): Container(
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
                  Column(
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
          Row(
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
  });
  }

  Widget _buildOrderListView() {
    return order.allorder.value.data?.length==0?Center(child: Text("No Order"),):  ListView.builder(
        padding: const EdgeInsets.only(left: 26, right: 26, top: 8, bottom: 46),
      itemCount: order.allorder.value.data?.length??0,
      itemBuilder: (context, index) {
        final completeOrder = order.allorder.value.data?[index];
        return completeOrder?.status=="5"||completeOrder?.status=="2"?Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.only(bottom: 12),
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.black12)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                 Text(completeOrder?.orderId??"", style: TextStyle(color: Colors.black54)),
                    ],
                  ),
                  
                 
                  const Spacer(),
                  Icon(Icons.check_circle, color: Colors.green),
                  const SizedBox(width: 4),
                  Text("Delivered", style: TextStyle(color: Colors.green)),
                ],
              ),
              const SizedBox(height: 8),
               
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
                          completeOrder?.cutomerName??"",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                         SizedBox(width: 6),
                completeOrder?.customerContactno==null?SizedBox(): Text(completeOrder?.customerContactno??"", style: TextStyle(color: Colors.black54)),
                      ],
                    ),
                  
                  ),
                ],
              ),
              const SizedBox(height: 4),
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
                        completeOrder?.address??"",
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
                      completeOrder?.products?.map((t)=>t.productname??"").toList().join(", ").toString()??"",
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              
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
                  completeOrder?.deliveryDate==null?SizedBox():  Text(completeOrder?.deliveryDate==null?"": DateFormat("dd/MM/yyyy").format(DateTime.parse(completeOrder?.deliveryDate??"")).toString(),style: TextStyle(color: Colors.black,fontSize: 14),),
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
                   completeOrder?.deliveryTime==null?SizedBox(): Text(completeOrder?.deliveryTime==null?"":DateFormat("HH:mm:ss").parse(completeOrder?.deliveryTime??"").toString(),style: TextStyle(color: Colors.black,fontSize: 14)),
                    ],
                  ),
                ),
              ),
                ],
              )
            ],
          ),
        ):SizedBox();
      },
    );
  }
}
