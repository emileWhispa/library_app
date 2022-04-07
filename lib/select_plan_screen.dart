import 'package:flutter/material.dart';
import 'package:library_app/home_screen.dart';
import 'package:library_app/json/plan.dart';
import 'package:library_app/json/user.dart';
import 'package:library_app/super_base.dart';

class SelectPlanScreen extends StatefulWidget{
  const SelectPlanScreen({Key? key}) : super(key: key);

  @override
  State<SelectPlanScreen> createState() => _SelectPlanScreenState();
}

class _SelectPlanScreenState extends Superbase<SelectPlanScreen> {

  final _key = GlobalKey<RefreshIndicatorState>();

  List<Plan> _list = [];

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _key.currentState?.show();
    });
    super.initState();
  }


  Future<void> loadPlans(){
    return ajax(url: "AllPlans",method: "POST",error: (s,v)=>print(s),onValue: (object,url){
      print(object);
      setState(() {
        _list = (object['AllPlan'] as Iterable).map((e) => Plan.fromJson(e)).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Card(
            margin: EdgeInsets.zero,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              )
            ),
            color: Color(0xff02A95C),
            child: SizedBox(
              height: 300,
              width: double.infinity,
            ),
          ),
          RefreshIndicator(
            key: _key,
            onRefresh: loadPlans,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 120),
                  child: Center(child: Text("Select Your Subscription Plan",textAlign: TextAlign.center,style: Theme.of(context).primaryTextTheme.headline6,)),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: _list.map((e) => Card(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: InkWell(
                      onTap: ()async{
                        await save("plan", e);
                        User.user?.plan = e;
                        push(const HomeScreen(),replaceAll: true);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(e.name,style: const TextStyle(
                                    color: Color(0xff02A95C),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700
                                  ),),
                                  Text("${e.allowedBooks} Book",style: const TextStyle(fontWeight: FontWeight.w400,fontSize: 16),),
                                   Text("${e.period} Months",style: const TextStyle(fontWeight: FontWeight.w400,fontSize: 16),),

                                  Padding(
                                    padding: const EdgeInsets.only(top: 6),
                                    child: Text("${fmtNbr(e.amount)} RWF",style: const TextStyle(fontWeight: FontWeight.w700,color: Color(0xffB10707),fontSize: 16),),
                                  ),
                                ],
                              ),
                            ),
                            Image.asset("assets/cash.png")
                          ],
                        ),
                      ),
                    ),
                  )).toList(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}