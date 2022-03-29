import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:library_app/home_screen.dart';
import 'package:library_app/super_base.dart';

class IntroSliderScreen extends StatefulWidget{
  const IntroSliderScreen({Key? key}) : super(key: key);

  @override
  State<IntroSliderScreen> createState() => _IntroSliderScreenState();
}

class _IntroSliderScreenState extends Superbase<IntroSliderScreen> {

  int _index = 0;

  final _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    var c = Theme.of(context).primaryTextTheme.headline6?.color;
    return Scaffold(
      body: Stack(
        children: [
          CarouselSlider(carouselController: _controller,items: [
            SliderItem("family.png", "Title Goes here.....", "Short description will go here Short description will go here Short descriptionShort description will go here will go here"),
            SliderItem("family2.png", "Title Goes here.....", "Short description will go here Short description will go here Short descriptionShort description will go here will go here"),
            SliderItem("family3.png", "Title Goes here.....", "Short description will go here Short description will go here Short descriptionShort description will go here will go here")
          ].map((e) => Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/${e.path}"),fit: BoxFit.cover)
            ),
            child: Padding(
              padding: const EdgeInsets.all(20).copyWith(
                top: MediaQuery.of(context).padding.top,
                bottom: 70
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'ESPACE',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Color(0xffFED857)
                    ),
                  ),
                  Text(
                    'MADIBA',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: c
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(e.title,style: TextStyle(
                    fontSize: 20,
                    color: c
                  ),),
                  Text(e.description,style: TextStyle(
                      fontSize: 16,
                      color: c
                  )),
                  const Spacer(),
                  ElevatedButton(onPressed: (){},style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                    )),
                    backgroundColor: MaterialStateProperty.all(Theme.of(context).scaffoldBackgroundColor)
                  ), child: const Text("Families, Start Reading",style: TextStyle(
                    color: Color(0xff4393DF)
                  ),),),
                  TextButton(onPressed: (){}, child: Text("Adult",style: TextStyle(
                    color: c
                  ),)),
                  TextButton(onPressed: (){}, child: Text("School",style: TextStyle(
                      color: c
                  ))),
                  TextButton(onPressed: (){}, child: Text("Have an account? Login",style: TextStyle(
                      color: c
                  ))),
                ],
              ),
            ),
          )).toList(), options: CarouselOptions(onPageChanged: (index,i){
            setState(() {
              _index = index;
            });
          },height: double.infinity,viewportFraction: 1)),
          Positioned(bottom: 30,left: 0,right: 0,child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 60),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [0,1,2].map((e) => Container(
                      height: 10,
                      width: 10,
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: _index == e ? Colors.amber : Colors.grey,
                        shape: BoxShape.circle
                      ),
                    )).toList(),
                  ),
                ),
              ),
              OutlinedButton(style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                  )),
              ),onPressed: (){
                if(_index >= 2){
                  push(const HomeScreen(),replace: true);
                }else{
                  _controller.animateToPage(_index+1);
                }
              }, child: Text(_index == 2 ? "Done" : "Next",style: TextStyle(
                  color: c
              ),)),
              const SizedBox(width: 10,),
            ],
          ))
        ],
      ),
    );
  }
}


class SliderItem{
  String path;
  String title;
  String description;
  
  SliderItem(this.path,this.title,this.description);
}