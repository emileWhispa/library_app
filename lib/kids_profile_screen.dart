import 'dart:math';

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
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _key.currentState?.show();
    });
    super.initState();
  }

  List<Kid> _list = [];


  Future<void> loadData(){
    return ajax(url: "ShowKidsProfile",method: "POST",onValue: (obj,url){
      setState(() {
        _list = (obj['KidsProfile'] as Iterable).map((e) => Kid.fromJson(e)).toList();
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
                }
              },
              child: CircleAvatar(
                radius: 53,
                backgroundColor: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                child: index < 0 ? const Icon(Icons.person_add,color: Color(0xffFED857),size: 40,) : Text(_list[index].subName,textAlign: TextAlign.center,style: const TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.w500
                ),),
              ),
            ),
          );
        }),
      ),
    );
  }
}