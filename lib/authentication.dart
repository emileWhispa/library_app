import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:library_app/home_screen.dart';
import 'package:library_app/json/plan.dart';
import 'package:library_app/select_plan_screen.dart';
import 'package:library_app/super_base.dart';

import 'json/user.dart';

class Authentication extends StatefulWidget{
  const Authentication({Key? key}) : super(key: key);

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends Superbase<Authentication> {

  final _key = GlobalKey<FormState>();

  bool _loading = false;

  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> login() async {
    setState(() {
      _loading = true;
    });
    // print("xx");
    await ajax(url: 'login',method: "POST",data: FormData.fromMap({
      "email":_phoneController.text,
      "password":_passwordController.text,
    }),onValue: (s,v){
      // print(s);
      if(s['response_status'] == 200 && s['user'] is Map){
        var user = User.fromJson(s);
        save(userKey, s);
        User.user = user;

        if(s['userPlan'] is Map){
          User.user?.plan = Plan.fromJson(s['userPlan']);
          push(const HomeScreen(),replaceAll: true);
        }else{
          showSnack("Select plan first");
          push(const SelectPlanScreen(),replaceAll: true);
        }

      }

      showSnack(s['message']??"Done");
    },error: (s,v){
      print(s);
      if(s is Map){
        showSnack(s['message']??'');
      }
    });
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _key,
          child: ListView(
            padding: const EdgeInsets.all(20).copyWith(top: MediaQuery.of(context).padding.top + 40),
            children: [
              Column(
                children: const [
                  Text(
                    'ESPACE',
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        color: Color(0xffFED857)
                    ),
                  ),
                  Text(
                    'MADIBA',
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        color: Color(0xff02A95C)
                    ),
                  ),
                ],
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 40,top: 15),
                  child: Text("Login to your Library account",style: Theme.of(context).textTheme.headline6,),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: TextFormField(
                  controller: _phoneController,
                  validator: (s)=>s?.trim().isNotEmpty == true ? null : "Field is required !",
                  decoration: InputDecoration(
                      filled: true,
                      hintText: "Email Address",
                      fillColor: const Color(0xffECF1F1),
                      prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12)
                      )
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: TextFormField(
                  obscureText: true,
                  controller: _passwordController,
                  validator: (s)=>s?.trim().isNotEmpty == true ? null : "Field is required !",
                  decoration: InputDecoration(
                      filled: true,
                      hintText: "Password",
                      fillColor: const Color(0xffECF1F1),
                      prefixIcon: const Icon(Icons.key_outlined),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12)
                      )
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: _loading ? const Center(child: CircularProgressIndicator()) : ElevatedButton(onPressed: (){
                  var bool = _key.currentState?.validate() ?? false;

                  if(bool){
                    login();
                  }

                },style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)
                  ))
                ), child: const Text("Login")),
              ),
              // Align(
              //   alignment: Alignment.centerRight,
              //     child: TextButton(
              //       onPressed: (){
              //
              //       },
              //       child: const Text("Forgot Password ?"),
              //     ),
              // ),
              Center(child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text("OR",style: Theme.of(context).textTheme.headline5),
              )),              Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: ElevatedButton(onPressed: (){
                    goBack();
                  },style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(const Color(0xffFED857)),
                      padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)
                      ))
                  ), child: const Text("Create Account",style: TextStyle(
                      color: Colors.black87
                  ),),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}