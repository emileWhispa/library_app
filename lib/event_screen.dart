import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:library_app/event_detail_screen.dart';
import 'package:library_app/json/event.dart';
import 'package:library_app/super_base.dart';

import 'json/user.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({Key? key}) : super(key: key);

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends Superbase<EventScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      loadData();
    });
  }


  List<Event> _list = [];

  void loadData(){
    ajax(url: "MobileEvents",method: "POST",data: FormData.fromMap({
      "role":"Adults"
    }),onValue: (s,v){
      setState(() {
        _list = (s['Events'] as Iterable?)?.map((e) => Event.fromJson(e)).toList()??[];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        titleSpacing: 10,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: CircleAvatar(
                child: Text(
                    (User.user?.fName ?? "XA").toUpperCase().substring(0, 1)),
                radius: 14,
              ),
            ),
            Text(
              "Hi, ${User.user?.fName ?? ""}",
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
        iconTheme:
            IconThemeData(color: Theme.of(context).textTheme.headline6?.color),
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(15),
          itemCount: _list.length + 1,
          itemBuilder: (context, index) {
            index = index - 1;
            if (index < 0) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 250,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: _list.length,
                      itemBuilder: (context, index) {
                        var item = _list[index];
                        return SizedBox(
                          width: 300,
                          child: Card(
                            margin: const EdgeInsets.all(6).copyWith(left: 0),
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: InkWell(
                              onTap: (){
                                push(EventDetailScreen(event: item));
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                      child: Image(image: CachedNetworkImageProvider(item.image),
                                          frameBuilder: frameBuilder,
                                          fit: BoxFit.cover)),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                          item.name,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Text(item.location,
                                            style: const TextStyle(
                                                color: Color(0xffFED857)))
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      "Upcoming Events",
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                ],
              );
            }


            var item = _list[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: InkWell(
                onTap: (){
                  push(EventDetailScreen(event: item));
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image(
                        image: CachedNetworkImageProvider(item.image),
                        frameBuilder: frameBuilder,
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                      ),
                    ),
                    Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children:  [
                          Text(
                            item.name,
                            style: const TextStyle(fontSize: 16),
                          ),
                          Text(
                            item.date,
                            style: const TextStyle(fontSize: 12, color: Color(0xffFED857)),
                          ),
                          Text(
                            item.location,
                            style: const TextStyle(fontSize: 12, color: Colors.black38),
                          ),
                      ],
                    ),
                        ))
                  ],
                ),
              ),
            );
          }),
    );
  }
}
