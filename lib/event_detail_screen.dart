import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:library_app/json/event.dart';
import 'package:library_app/super_base.dart';

class EventDetailScreen extends StatefulWidget{
  final Event event;
  const EventDetailScreen({Key? key, required this.event}) : super(key: key);

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends Superbase<EventDetailScreen> {
  
  bool _attending = false;

  String _message = "I Will Attend";
  
  Future<void> attend() async {
    setState(() {
      _attending = true;
    });
    await ajax(url: "AttendEvent",method: "POST",data: FormData.fromMap({"event_id":widget.event.id}),onValue: (s,v){
      // print(s);
      setState(() {
        _message = s['message']??'';
        showSnack(_message);
      });
    });

    setState(() {
      _attending = false;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Image(image: CachedNetworkImageProvider(widget.event.image),height: MediaQuery.of(context).size.height/2,fit: BoxFit.cover,),
          Column(
            children: [
              const SizedBox(height: 300,),
              Expanded(
                child: Card(
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)
                  ),
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: ListView(
                            padding: const EdgeInsets.all(12),
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Text(widget.event.name,style: const TextStyle(
                                          fontSize: 16
                                      )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.calendar_today,color: Color(0xffFED857),size: 40,),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 10),
                                            child: Text(widget.event.date,style: const TextStyle(
                                              color: Color(0xffFED857),
                                              fontSize: 16
                                            ),),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.my_location_sharp,color: Color(0xff02A95C),size: 40,),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 10),
                                            child: Text(widget.event.location,style: const TextStyle(
                                              color: Color(0xff02A95C),
                                              fontSize: 16
                                            ),),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(vertical: 10),
                                      child: Text("Event Details",style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700
                                      ),),
                                    ),
                                    Text(widget.event.description),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: _attending ? const Center(child: CircularProgressIndicator(),) :  ElevatedButton(onPressed: (){
                            attend();
                          },style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                              padding: MaterialStateProperty.all(const EdgeInsets.all(15)),
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)
                              ))
                          ), child: Text(_message)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}