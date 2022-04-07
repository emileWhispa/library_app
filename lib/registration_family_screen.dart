import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:library_app/select_plan_screen.dart';
import 'package:library_app/super_base.dart';

import 'json/user.dart';

class RegistrationFamilyScreen extends StatefulWidget{
  final String type;
  const RegistrationFamilyScreen({Key? key, this.type = "Family"}) : super(key: key);

  @override
  State<RegistrationFamilyScreen> createState() => _RegistrationFamilyScreenState();
}

class _RegistrationFamilyScreenState extends Superbase<RegistrationFamilyScreen> {

  final _key = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _firstController = TextEditingController();
  final _lastController = TextEditingController();
  final _passwordController = TextEditingController();


  bool _loading =false;

  Future<void> login() async {
    setState(() {
      _loading = true;
    });
    await ajax(url: 'UserRegistration',method: "POST",data: FormData.fromMap({
      "name":_firstController.text,
      "phone_number":_phoneController.text,
      "email":_emailController.text,
      "password":_passwordController.text,
      "ConfirmPassword":_passwordController.text,
      "role":widget.type
    }),onValue: (s,v){
      if(s['response_status'] == 200){
        User.user = User.fromJson(s,userKey: "UserInfo");
        save(userKey, User.user);
        push(const SelectPlanScreen());
      }

      showSnack(s['message']);
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
                  child: Text("Create your ${widget.type == "Family" ? "family":"adult"} account",style: Theme.of(context).textTheme.headline6,),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: TextFormField(
                  controller: _firstController,
                  validator: (s)=>s?.trim().isNotEmpty == true ? null : "Field is required !",
                  decoration: InputDecoration(
                      filled: true,
                      hintText: "First Name",
                      fillColor: const Color(0xffECF1F1),
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
                  controller: _lastController,
                  validator: (s)=>s?.trim().isNotEmpty == true ? null : "Field is required !",
                  decoration: InputDecoration(
                      filled: true,
                      hintText: "Last Name",
                      fillColor: const Color(0xffECF1F1),
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
                  controller: _phoneController,
                  validator: (s)=>s?.trim().isNotEmpty == true ? null : "Field is required !",
                  decoration: InputDecoration(
                      filled: true,
                      hintText: "Phone Number",
                      fillColor: const Color(0xffECF1F1),
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
                  controller: _emailController,
                  validator: (s)=>s?.trim().isNotEmpty == true ? null : "Field is required !",
                  decoration: InputDecoration(
                      filled: true,
                      hintText: "Email Address",
                      fillColor: const Color(0xffECF1F1),
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
                  controller: _passwordController,
                  obscureText: true,
                  validator: (s)=>s?.trim().isNotEmpty == true ? null : "Field is required !",
                  decoration: InputDecoration(
                      filled: true,
                      hintText: "Password",
                      fillColor: const Color(0xffECF1F1),
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
                  validator: (s)=>s == _passwordController.text ? null : "Confirm password is not correct !",
                  decoration: InputDecoration(
                      filled: true,
                      hintText: "Confirm Password",
                      fillColor: const Color(0xffECF1F1),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12)
                      )
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: _loading ? const Center(child: CircularProgressIndicator(),) : ElevatedButton(onPressed: (){
                  bool v = _key.currentState?.validate() ?? false;

                  if(v){
                    login();
                  }
                },style: ButtonStyle(
                    padding: MaterialStateProperty.all(const EdgeInsets.all(15)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)
                    ))
                ), child: const Text("Sign Up")),
              ),
              const SizedBox(height: 30,),
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already Have an account"),
                    TextButton(
                      onPressed: goBack,
                      child: const Text("Login"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}