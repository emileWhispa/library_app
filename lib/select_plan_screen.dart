import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:library_app/home_screen.dart';
import 'package:library_app/json/plan.dart';
import 'package:library_app/json/user.dart';
import 'package:library_app/subscription_payment.dart';
import 'package:library_app/super_base.dart';

class SelectPlanScreen extends StatefulWidget {
  const SelectPlanScreen({Key? key}) : super(key: key);

  @override
  State<SelectPlanScreen> createState() => _SelectPlanScreenState();
}

class _SelectPlanScreenState extends Superbase<SelectPlanScreen> {
  final _key = GlobalKey<RefreshIndicatorState>();

  List<Plan> _list = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _key.currentState?.show();
    });
    super.initState();
  }

  Future<void> loadPlans() {
    return ajax(
        url: "AllPlans",
        method: "POST",
        onValue: (object, url) {
          setState(() {
            _list = (object['AllPlan'] as Iterable)
                .map((e) => Plan.fromJson(e))
                .toList();
          });
        });
  }

  Future<void> savePlan(Plan e) async {
    String? phone;

    var bool = e.amount > 0;
    if (bool) {
      phone = await push<String?>(const SubscriptionPayment());
    }

    showMd();

    return ajax(
        url: "AddUserMemberShipPlan",
        method: "POST",
        data: FormData.fromMap({"PhoneNumber": phone, "membership_id": e.id}),
        onValue: (obj, url) async {
          closeMd();
          if(obj is Map && obj.containsKey("userPlan")){
            e = Plan.fromJson(obj['userPlan']);
          }
          await Future.delayed(const Duration(seconds: 2));
          if(!bool && (obj is Map && obj['response_status'] == 200)){
            continueHome(e);
          }else if( obj is Map){
            if(obj.containsKey("transaction_id")) {
              showMd("Waiting for payment status");
              checkStatus(obj['transaction_id'],e);
              if(obj.containsKey("message")){
                showSnack(obj['message']);
              }
            }else{

              showSnack(obj['message']??"Payment Failed !!!");
            }
          }else{
            showSnack("Payment Failed !!!");
          }
          // push(const HomeScreen(), replaceAll: true);
        },error: (s,v) {
          if( s is Map){
            showSnack(s['message']??"");
          }
          closeMd();
    });
  }

  void continueHome(Plan e)async{
    await save("plan", e);
    User.user?.plan = e;
    push(const HomeScreen(),replaceAll: true);
  }
  
  void checkStatus(String id,Plan e){
    ajax(url: "CheckPaymentStatus",method: "POST",data: FormData.fromMap({"transactionid":id}),onValue: (obj,url) async {
      // print(obj);
      if(obj is Map && obj['payment_status'] == "PENDING") {
        Timer(const Duration(seconds: 5), () => checkStatus(id,e));
      }else{
        if(obj['payment_status'] == "SUCCESSFUL"){
          if(obj is Map && obj.containsKey("userPlan")){
            e = Plan.fromJson(obj['userPlan']);
          }
          continueHome(e);
        }else{
          showSnack("Payment Failed !");
          closeMd();
        }
      }
    },error: (s,v)=>
        Timer(const Duration(seconds: 5), ()=>checkStatus(id,e)));
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
            )),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 120),
                  child: Center(
                      child: Text(
                    "Select Your Subscription Plan",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).primaryTextTheme.headline6,
                  )),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: _list
                      .map((e) => Card(
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: InkWell(
                              onTap: () async {
                                savePlan(e);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(32.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Text(
                                            e.name,
                                            style: const TextStyle(
                                                color: Color(0xff02A95C),
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Text(
                                            "${e.allowedBooks} Book",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16),
                                          ),
                                          Text(
                                            "${e.period} Months",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 6),
                                            child: Text(
                                              "${fmtNbr(e.amount)} RWF",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  color: Color(0xffB10707),
                                                  fontSize: 16),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Image.asset("assets/cash.png")
                                  ],
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
