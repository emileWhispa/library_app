import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:library_app/create_kid_profile_screen.dart';
import 'package:library_app/json/kid.dart';
import 'package:library_app/super_base.dart';

class KidsProfileScreen extends StatefulWidget{
  const KidsProfileScreen({Key? key}) : super(key: key);

  @override
  State<KidsProfileScreen> createState() => _KidsProfileScreenState();
}

class _KidsProfileScreenState extends Superbase<KidsProfileScreen> {

  final _key = GlobalKey<RefreshIndicatorState>();


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _key.currentState?.show();
    });
    super.initState();
  }

  List<Kid> _list = [];


  Future<void> loadData() async {
    var key = (await prefs).getString("active_profile");

    return ajax(url: "ShowKidsProfile",method: "POST",onValue: (obj,url){
      setState(() {
        _list = (obj['KidsProfile'] as Iterable).map((e) => Kid.fromJson(e,activeId: key)).toList();
      });
    });
  }
  
  Future<void> activateProfile(Kid kid){
    setState(() {
      kid.loading = true;
    });
    return ajax(url: "ActiveProfile",method: "POST",data: FormData.fromMap({"profile_id":kid.id}),onValue: (obj,url){

      setState(() {
        saveVal("active_profile", "${kid.id}");
        showSnack(obj['message']??'');
        for (var element in _list) {
          element.active = false;
        }
        kid.active = true;
      });
    },onEnd: (){
      setState(() {
        kid.loading = false;
      });
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
        title: const Text("My Kids"),
      ),
      body: RefreshIndicator(
        key: _key,
        onRefresh: loadData,
        child: GridView.builder(itemCount: _list.length+1,padding: const EdgeInsets.all(20),gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10
        ), itemBuilder: (context,index){
          index = index - 1;
          return Center(
            child: GestureDetector(
              onTap: () async {
                if(index < 0) {
                  await push(const CreateKidProfileScreen());
                  _key.currentState?.show();
                }else{
                  activateProfile(_list[index]);
                }
              },
              child: Container(
                decoration: index >= 0 && _list[index].active ? BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.black,
                    width: 3
                  )
                ) : null,
                child: CircleAvatar(
                  radius: 53,
                  backgroundColor: index < 0 ? null : _list[index].active ? Colors.amber : Colors.primaries[Random().nextInt(Colors.primaries.length)],
                  child: index < 0 ? const Icon(Icons.person_add,color: Colors.white,size: 40,) : _list[index].loading ? const CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ) : Text(_list[index].subName,textAlign: TextAlign.center,style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
shadows: _list[index].active ? [
  const BoxShadow(
    color: Colors.black,
    spreadRadius: 200,
    offset: Offset(2.5,.5),
    blurRadius: 5
  )
] : null,
                    fontWeight: FontWeight.w500
                  ),),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}