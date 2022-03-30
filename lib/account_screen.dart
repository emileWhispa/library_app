import 'package:flutter/material.dart';
import 'package:library_app/intro_slider_screen.dart';
import 'package:library_app/super_base.dart';

import 'json/user.dart';

class AccountScreen extends StatefulWidget{
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends Superbase<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1.0,
        title: Text("My Account",style: Theme.of(context).textTheme.headline6,),
      ),
      body: Center(
        child: ListView(
          children: [
            Center(child: Padding(
              padding: const EdgeInsets.all(8.0).copyWith(top: 30),
              child: CircleAvatar(
                child: Text(User.user?.fName??"",style: const TextStyle(
                    fontSize: 29
                ),),
                radius: 70,
              ),
            ),),
            Center(child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("${User.user?.lName}",style: Theme.of(context).textTheme.headline4,textAlign: TextAlign.center,),
                  Text("${User.user?.phone??''}${User.user?.hasPhoneAndEmail == true ? '/':''}${User.user?.email??''}",style: Theme.of(context).textTheme.headline6,textAlign: TextAlign.center,),
                ],
              ),
            )),
            // Card(
            //   margin: const EdgeInsets.only(bottom: 0.5,top: 30),
            //   shape: const RoundedRectangleBorder(),
            //   child: InkWell(
            //     onTap: ()async{
            //
            //     },
            //     child: Padding(
            //       padding: const EdgeInsets.all(15.0),
            //       child: Row(
            //         children: [
            //           const Icon(Icons.person),
            //           const SizedBox(width: 7),
            //           Text("Update Profile Info",style: Theme.of(context).textTheme.subtitle1,),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            Card(
              margin: const EdgeInsets.only(bottom: 10),
              shape: const RoundedRectangleBorder(),
              child: InkWell(
                onTap: ()async{
                  var b = await confirmDialog();
                  if(b){
                    (await prefs).clear();
                    push(const IntroSliderScreen(),replaceAll: true);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      const Icon(Icons.lock),
                      const SizedBox(width: 7),
                      Text("Sign out",style: Theme.of(context).textTheme.subtitle1,),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}