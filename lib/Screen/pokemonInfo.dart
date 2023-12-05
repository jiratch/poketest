import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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


  Future<List<PokemonDetail>> fetchAllPokemonDetails() async {
    try {
      final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon'));

      if (response.statusCode == 200) {
        final List<dynamic> results = json.decode(response.body)['results'];
        List<Pokemon> pokemons = results.map((json) => Pokemon.fromJson(json)).toList();

        List<Future<PokemonDetail>> futures = pokemons.map((pokemon) {
          return fetchPokemonDetail(pokemon.url);
        }).toList();

        List<PokemonDetail> pokemonDetails = await Future.wait(futures);
        return pokemonDetails;
      } else {
        throw Exception('Failed to load pokemons');
      }
    } catch (e) {
      throw Exception('Failed to load Pokemon details: $e');
    }
  }

  Future<PokemonDetail> fetchPokemonDetail(String url) async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return PokemonDetail.fromJson(data);
      } else {
        throw Exception('Failed to load pokemon detail');
      }
    } catch (e) {
      throw Exception('Failed to load Pokemon detail: $e');
    }
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
      body: FutureBuilder<List<PokemonDetail>>(
          future: fetchAllPokemonDetails(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final List<PokemonDetail> pokemons = snapshot.data!;
              return ListView.builder(
                itemCount: pokemons.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(pokemons[index].name),
                  );
                },
              );
            }
          },
        ), 
      
      // Container(
      
      //   margin: const EdgeInsets.all(8),
      //   child: GridView.builder(
      //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //       crossAxisCount: calculateCrossAxisCount(context), // Dynamically calculate columns
      //       crossAxisSpacing: 8.0,
      //       mainAxisSpacing: 8.0,
      //     ),
      //     itemCount: 11, // Adjust the number of items as needed
      //     itemBuilder: (BuildContext context, int index) {
      //       return Container(

      //         decoration: BoxDecoration(
      //         color: Colors.black,  // Set the background color
      //         borderRadius: BorderRadius.circular(20.0),  // Set the border radius
      //       ),
      //         child: Center(
      //           child: Text(
      //             'Item ${index+1}',
      //             style: TextStyle(fontSize: 18,color: Colors.white),
      //           ),
      //         ),
      //       );
      //     },
      //   ),
      // ),
    );
  }
   
  }

  class Pokemon {
  final String name;
  final String url;

  Pokemon({required this.name, required this.url});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'],
      url: json['url'],
    );
  }
}

class PokemonDetail {
  final String name;
  final int baseExperience;

  PokemonDetail({required this.name, required this.baseExperience});

  factory PokemonDetail.fromJson(Map<String, dynamic> json) {
    return PokemonDetail(
      name: json['name'],
      baseExperience: json['base_experience'],
    );
  }
}




