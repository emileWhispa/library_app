import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:library_app/super_base.dart';

import 'json/user.dart';

class CreateKidProfileScreen extends StatefulWidget{
  const CreateKidProfileScreen({Key? key}) : super(key: key);

  @override
  State<CreateKidProfileScreen> createState() => _CreateKidProfileScreenState();
}

class _CreateKidProfileScreenState extends Superbase<CreateKidProfileScreen> {

  String? _range;

  final _kidController = TextEditingController();
  final _key = GlobalKey<FormState>();


  bool _loading = false;

  Future<void> login() async {
    setState(() {
      _loading = true;
    });
    await ajax(url: 'AddKidProfile',method: "POST",data: FormData.fromMap({
      "KidName":_kidController.text,
      "KidAgeRange":_range,
      "family_user_id":User.user?.id,
    }),onValue: (s,v){
      if(s['response_status'] == 200){
        goBack();
      }

      showSnack(s['message']??"Done");
    });
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Theme.of(context).textTheme.headline6?.color
        ),
        elevation: 2,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        titleTextStyle: Theme.of(context).textTheme.headline6,
        title: const Text("Create Kids Profile"),
      ),
      body: Form(
        key: _key,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: TextFormField(
                controller: _kidController,
                validator: (s)=>s?.trim().isNotEmpty == true ? null : "Field is required !",
                decoration: InputDecoration(
                    filled: true,
                    hintText: "Kid's Name",
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
              child: DropdownButtonFormField<String>(
                // obscureText: true,
                // controller: _passwordController,
                items: ["3-6","6-9","9-12","12-15","15-18"].map((e) => DropdownMenuItem(child: Text(e),value: e,)).toList(),
                onChanged: (s){
                  setState(() {
                    _range = s;
                  });
                },
                value: _range,
                validator: (s)=>s?.trim().isNotEmpty == true ? null : "Field is required !",
                decoration: InputDecoration(
                    filled: true,
                    hintText: "Select Age Range",
                    fillColor: const Color(0xffECF1F1),
                    prefixIcon: const Icon(Icons.date_range),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(12)
                    )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child:  _loading ? const Center(child: CircularProgressIndicator()) :  ElevatedButton(onPressed: (){

                var bool = _key.currentState?.validate() ?? false;

                if(bool){
login();
                }

              },style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)
                  ))
              ), child: const Text("Create Profile")),
            ),
          ],
        ),
      ),
    );
  }
}