import 'package:flutter/material.dart';

class AboutScreen extends StatefulWidget{
  const AboutScreen({Key? key}) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About us"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Text("Espace Madiba is part of the network Littafcar.org, a network of centers active in the promotion of African literature and of the Caribbean. Project that receives support financing of the sector support program cultural ACP, AC Cultures +, implemented by the Secretariat of the ACP Group of States and financed by the European Union”",
        style: Theme.of(context).textTheme.subtitle1,),
      ),
    );
  }
}