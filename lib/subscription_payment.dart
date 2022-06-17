import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:library_app/super_base.dart';

class SubscriptionPayment extends StatefulWidget{
  const SubscriptionPayment({Key? key}) : super(key: key);

  @override
  State<SubscriptionPayment> createState() => _SubscriptionPaymentState();
}

class _SubscriptionPaymentState extends Superbase<SubscriptionPayment> {
  final _kidController = TextEditingController();
  final _key = GlobalKey<FormState>();





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
        title: const Text("Pay for subscription"),
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
                validator: validateMobile,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                    filled: true,
                    hintText: " Enter Phone Number",
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
              child:   ElevatedButton(onPressed: (){

                var bool = _key.currentState?.validate() ?? false;

                if(bool){
                  goBack(_kidController.text);
                }

              },style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)
                  ))
              ), child: const Text("Confirm Payment")),
            ),
          ],
        ),
      ),
    );
  }
}