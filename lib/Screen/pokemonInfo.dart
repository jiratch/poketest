import 'package:flutter/material.dart';

class PokemonInfo extends StatefulWidget {
  final String? username;
  final String? userId;
  final String? defaultStoreID;
  PokemonInfo({this.username, this.userId, this.defaultStoreID});
  @override
  PokemonInfoState createState() => PokemonInfoState();
}

class PokemonInfoState extends State<PokemonInfo> {

  @override
  void initState() {
 
    super.initState();

  }
  

  @override
  Widget build(BuildContext context) {

   
    return Scaffold(body: Column( children: [Container()],));
  }
   
  }

  


