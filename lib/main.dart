import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PokeTest',
      theme: ThemeData(   
        primarySwatch: Colors.red,
      ),
      home: const Pokedex(title: 'Pokedex'),
    );
  }
}

class Pokedex extends StatefulWidget {
  const Pokedex({super.key, required this.title});


  final String title;

  @override
  State<Pokedex> createState() => _PokedexState();
}

class _PokedexState extends State<Pokedex> {

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
