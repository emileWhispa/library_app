import 'package:flutter/material.dart';
import 'package:library_app/about_screen.dart';
import 'package:library_app/borrowed_book_screen.dart';
import 'package:library_app/intro_slider_screen.dart';
import 'package:library_app/super_base.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
                child: Text(User.user?.shortName??"",style: const TextStyle(
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
                  Text("${User.user?.phone??''}${User.user?.hasPhoneAndEmail == true ? '\n':''}${User.user?.email??''}",style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    color: Theme.of(context).textTheme.headline4?.color
                  ),textAlign: TextAlign.center,),
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
              margin: const EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    margin: const EdgeInsets.only(bottom: 1),
                    shape: const RoundedRectangleBorder(),
                    child: InkWell(
                      onTap: ()async{

                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: [
                            Image.asset("assets/refresh.png"),
                            const SizedBox(width: 7),
                            Expanded(child: Text(User.user?.plan?.name??"",style: Theme.of(context).textTheme.subtitle1,)),
                            Text("Expires on ${User.user?.plan?.date??""}",style: const TextStyle(
                              color: Color(0xff02A95C)
                            ),)
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    margin: const EdgeInsets.only(bottom: 0),
                    shape: const RoundedRectangleBorder(),
                    child: InkWell(
                      onTap: ()async{
                        push(const BorrowedBookScreen());
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: [
                            Image.asset("assets/my_book.png"),
                            const SizedBox(width: 7),
                            Text("My Books",style: Theme.of(context).textTheme.subtitle1,),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Card(
              margin: const EdgeInsets.all(20).copyWith(top: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    margin: const EdgeInsets.only(bottom: 1),
                    shape: const RoundedRectangleBorder(),
                    child: InkWell(
                      onTap: ()async{
                        push(const AboutScreen());
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: [
                            Image.asset("assets/about.png"),
                            const SizedBox(width: 7),
                            Text("About",style: Theme.of(context).textTheme.subtitle1,),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    margin: const EdgeInsets.only(bottom: 1),
                    shape: const RoundedRectangleBorder(),
                    child: InkWell(
                      onTap: ()async{
                        launchUrlString("tel:+250788606765");
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: [
                            Image.asset("assets/support.png"),
                            const SizedBox(width: 7),
                            Text("Support",style: Theme.of(context).textTheme.subtitle1,),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    margin: const EdgeInsets.only(bottom: 0),
                    shape: const RoundedRectangleBorder(),
                    child: InkWell(
                      onTap: ()async{
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: [
                            Image.asset("assets/terms.png"),
                            const SizedBox(width: 7),
                            Text("Terms & Conditions",style: Theme.of(context).textTheme.subtitle1,),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0).copyWith(top: 10),
              child: ElevatedButton(style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)
                )),
                padding: MaterialStateProperty.all(const EdgeInsets.all(15)),
                backgroundColor: MaterialStateProperty.all(const Color(0xffAD0909))
              ),onPressed: ()async{
                var b = await confirmDialog();
                if(b){
                  (await prefs).clear();
                  User.user = null;
                  push(const IntroSliderScreen(),replaceAll: true);
                }
              }, child: const Text("Sign Out")),
            )
          ],
        ),
      ),
    );
  }
}