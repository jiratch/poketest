import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


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

    int calculateCrossAxisCount(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    // Adjust the column count based on your preferences
    int columns = (screenWidth/150).floor(); // Change 150 to your desired item width
    return columns > 0 ? columns : 1; // Ensure at least 1 column
  }
    return Scaffold(  
      backgroundColor: Colors.amber,
      body: Container(
      
        margin: const EdgeInsets.all(8),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: calculateCrossAxisCount(context), // Dynamically calculate columns
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: 11, // Adjust the number of items as needed
          itemBuilder: (BuildContext context, int index) {
            return Container(

              decoration: BoxDecoration(
              color: Colors.black,  // Set the background color
              borderRadius: BorderRadius.circular(20.0),  // Set the border radius
            ),
              child: Center(
                child: Text(
                  'Item ${index+1}',
                  style: TextStyle(fontSize: 18,color: Colors.white),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
   
  }




