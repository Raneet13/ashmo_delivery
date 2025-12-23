import 'package:ashmo_delivery/data/app_url.dart';
import 'package:ashmo_delivery/screen/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../viewmodel/auth_viewmodel.dart';

class ProfileScreen extends StatelessWidget {
      final login = Get.find<AuthViewmodel>();
    void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Stack(
            children: [
             
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                     Center(child: Text("Logout",style: TextStyle(fontSize: 24),),),
                    SizedBox(height: 10),
                    Text(
                      "Are you sure you want to logout?",
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Cancel"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Handle logout
                            login.logout().then((v){
                              if (v) {
                                Navigator.pop(context);
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                              }
                            })
                            ;
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            child: Text("Yes"),
                          ),
                        ),
                        
                      ],
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              // Close icon at top right
              Positioned(
                right: 0,
                child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Info Section
            Column(
              children: [
                Obx(
                  ()=>login.isLoading.value?SizedBox(height: 20,width: 20, child: Center(child: CircularProgressIndicator(),)): Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey[300],
                        backgroundImage: login.profile.value.messages?.status?.storeImage != null
                          ? NetworkImage("${AppUrl.imageApi}${login.profile.value.messages?.status?.storeImage}")
                          : null,
                      child: login.profile.value.messages?.status?.storeImage == null
                          ? Icon(
                              Icons.person,
                              size: 40,
                              color: Colors.grey[600],
                            )
                          : null,
                      ),
                      SizedBox(width: 16),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${login.profile.value.messages?.status?.fullname??""}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                      Text(
                        '(+91) ${login.profile.value.messages?.status?.contact??""}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[700],
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '${login.profile.value.messages?.status?.email??""}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[700],
                        ),
                      ),
                        ],
                      ),
                      Spacer(),
                  //     SizedBox(
                  //       height: 38,
                  //       width: 38,
                  //       child: IconButton.filled(
                  //         style: IconButton.styleFrom(
                  //       backgroundColor: Colors.orange,
                  //       foregroundColor: Colors.white, // icon color
                  //                         ),
                  //         onPressed: (){
                  //            showModalBottomSheet(
                  // context: context,
                  // isScrollControlled: true,
                  // builder: (context) => ChangeInfoBottomSheet(),
                  //               );
                  //         }, icon: Icon(Icons.edit)),
                  //     )
                  
                    ],
                  ),
                ),
                SizedBox(height: 12,),
              SizedBox(
                height: 45,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: ElevatedButton(onPressed: (){
                    _showLogoutDialog(context);
                  },
                   style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade50,
                        foregroundColor: Colors.orange, // icon color
                      ), child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.logout,size: 24,),
                      Text("Logout",style: TextStyle(fontSize: 16),),
                    ],
                  )),
                ),
              )
              ],
            ),
            
            SizedBox(height: 32),
            
            // Menu Items
            // _buildMenuItem('Logout', Icons.logout),
            // Divider(height: 1),
            _buildMenuItem(context,'Help Center', Icons.help_outline),
            Divider(height: 1),
            _buildMenuItem(context,'Term of Service',null ),//Icons.description_outlined
            // Divider(height: 1),
            _buildMenuItem(context,'Privacy Policy', null ),//Icons.privacy_tip_outlined
            // Divider(height: 1),
            _buildMenuItem(context,'Return Policy', null ),//Icons.assignment_return_outlined
          ],
        ),
      ),
    );
  }
  void showSupportBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) {
      return SafeArea(
        child: Column(
        
              mainAxisSize: MainAxisSize.min,
              // fit: StackFit.expand,
              //  alignment: Alignment.topCenter,
              children: [
                IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white, // background color
                    foregroundColor: Colors.black, // icon color
                    surfaceTintColor: Colors.white,
                    shape: CircleBorder(), // circular button
                  ),
                  icon: Icon(Icons.close,size: 18,),
                  onPressed: () => Navigator.pop(context),
                ),
                SizedBox(height: 8,),
                Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            // color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
              boxShadow: [
                // BoxShadow(
                //   color: Colors.grey.shade300,
                //   blurRadius: 10,
                //   spreadRadius: 2,
                // ),
              ],
            ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top close button
                      
                      // SizedBox(height: 10),
                      // Title
                      Text(
                        "Contact for Support",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(height: 2),
                      Divider(
                        height: 2,thickness: 1,
                      ),
                      SizedBox(height: 2),
                      // Subtext
                      Column(
                         mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "We are available",
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "From 9 AM - 11 PM",
                            style: TextStyle(color: Colors.grey,fontSize: 14),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      // Contact Icons
                      Row(
                        //  mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          contactButton(Icons.phone, () {
                            // handle phone tap
                          }),
                          SizedBox(width: 16),
                          contactButton(Icons.group, () {
                            // handle WhatsApp tap
                          }),
                          SizedBox(width: 16),
                          contactButton(Icons.email_outlined, () {
                            // handle email tap
                          }),
                        ],
                      ),
                      SizedBox(height: 2),
                    ],
                  ),
                ),)
              ],
            
        ),
      );
    },
  );
}
Widget contactButton(IconData icon, VoidCallback onTap) {
  return InkWell(
    onTap: onTap,
    child: Container(
      width: 46,
      height: 46,
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: Colors.white),
    ),
  );
}


  Widget _buildMenuItem(BuildContext context,String title, IconData? icon) {
    return ListTile(
      visualDensity: VisualDensity(horizontal: -4,vertical: -4),
      dense:true,
      contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 0),
      
      leading:icon==null?null: Icon(
        icon,
        color: Colors.grey[700],
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey,
      ),
      onTap: () {
        // Handle menu item tap
        if (title=="Help Center") {
          showSupportBottomSheet(context);
        }
        
      },
    );
  }
}
class ChangeInfoBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom, // Adjust for keyboard
      ),
      child: Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Title
            Text(
              'Change User Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            
            SizedBox(height: 24),
            IntlPhoneField(
              controller: TextEditingController(text: '7864512488'),
              keyboardType: TextInputType.phone,
              showDropdownIcon: true,
  flagsButtonPadding: const EdgeInsets.only(right: 0),
  disableLengthCheck: true,
  // dropdownIconPosition: IconPosition.trailing,
  decoration: InputDecoration(
    // labelText: 'Phone Number'
    // ,
    hintText: "Enter Phone Number",
     hintStyle: TextStyle(color: Colors.grey.shade400),
    fillColor: Colors.grey.shade200,
    filled: true,
    
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.transparent, width: 0),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.transparent, width: 0),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.transparent, width: 0),
    ),
  ),
  initialCountryCode: 'IN',
  onChanged: (phone) {
    print(phone.completeNumber);
  },
),
            
            // Phone Number Field
    //         TextField(
    //           decoration: InputDecoration(
    //             fillColor: Colors.grey.shade200,
    //             filled: true,
    //             // labelText: 'Phone Number',
    //             prefixIcon: Icon(Icons.person),
    //               border: OutlineInputBorder(
    //   borderRadius: BorderRadius.circular(12),
    //   borderSide: BorderSide(color: Colors.transparent, width: 0),
    // ),
    // enabledBorder: OutlineInputBorder(
    //   borderRadius: BorderRadius.circular(12),
    //   borderSide: BorderSide(color: Colors.transparent, width: 0),
    // ),
    // focusedBorder: OutlineInputBorder(
    //   borderRadius: BorderRadius.circular(12),
    //   borderSide: BorderSide(color: Colors.transparent, width: 0),
    // ),
    //             prefixText: '+91 ',
    //             contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
    //           ),
    //           controller: TextEditingController(text: '7864512488'),
    //           keyboardType: TextInputType.phone,
    //         ),
            
            SizedBox(height: 16),
            
            // Email Field
            TextField(
              decoration: InputDecoration(
                hintText: 'Email',
                 hintStyle: TextStyle(color: Colors.grey.shade400),
                fillColor: Colors.grey.shade200,
                filled: true,
                prefixIcon: Icon(Icons.mail),
                  border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.transparent, width: 0),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.transparent, width: 0),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.transparent, width: 0),
    ),),
              controller: TextEditingController(text: 'jayesh_patel@gmail.com'),
              keyboardType: TextInputType.emailAddress,
            ),
            
            SizedBox(height: 16),
            
            // Name Field
            SizedBox(
              height: 55,
              child: TextField(
                decoration: InputDecoration(
                  fillColor: Colors.grey.shade200,
                  filled: true,
                  hintText: 'Name',
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.transparent, width: 0),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.transparent, width: 0),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.transparent, width: 0),
    ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                ),
                // style: TextStyle(color: Colors.grey.shade400),
                controller: TextEditingController(text: 'Jayesh Patel'),
              ),
            ),
            
            SizedBox(height: 24),
            
            // Buttons Row
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    // Save logic here
                    Navigator.pop(context);
                  },
                   style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 32),
                              backgroundColor: Colors.orange,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                  child: Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}