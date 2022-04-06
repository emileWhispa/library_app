import 'package:flutter/material.dart';
import 'package:library_app/create_kid_profile_screen.dart';
import 'package:library_app/super_base.dart';

class KidsProfileScreen extends StatefulWidget{
  const KidsProfileScreen({Key? key}) : super(key: key);

  @override
  State<KidsProfileScreen> createState() => _KidsProfileScreenState();
}

class _KidsProfileScreenState extends Superbase<KidsProfileScreen> {
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
      body: GridView.builder(itemCount: 10,padding: const EdgeInsets.all(20),gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10
      ), itemBuilder: (context,index){
        return Center(
          child: GestureDetector(
            onTap: (){
              if(index == 0) {
                push(const CreateKidProfileScreen());
              }
            },
            child: CircleAvatar(
              radius: 40,
              child: index == 0 ? const Icon(Icons.person_add,color: Color(0xffFED857),size: 40,) : const Text("Hub",style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500
              ),),
            ),
          ),
        );
      }),
    );
  }
}