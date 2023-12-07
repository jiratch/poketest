import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:poketest/Const/colorsType.dart' as Const;
import 'package:poketest/Model/Pokemon.dart';
import 'package:poketest/Model/PokemonDetail.dart';
import 'package:poketest/Screen/pokemonInfo.dart';

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
  final ScrollController _scrollController = ScrollController();
  List<PokemonDetail> allPokemom = [];
  int offset = 0;

  bool halfwayReached = false;
  bool isFirstUpdatePokemon = true;
  final colorType = Const.colortypes;

  @override
  void initState() {
    super.initState();

    getPokemonDetails(limit: 20); //getPokemonDetails first 20 pokemon

    _scrollController.addListener(() {
      if (!halfwayReached) {
        if ((_scrollController.offset >=
                _scrollController.position.maxScrollExtent / 2) ||
            (_scrollController.position.maxScrollExtent ==
                    _scrollController.offset) &&
                !_scrollController.position.outOfRange) {
          if (isFirstUpdatePokemon) {
            offset = offset + 20;
            isFirstUpdatePokemon = false;
          } else {
            offset = offset + 60;
          }

          if (offset < 980) {
            getPokemonDetails(offset: offset);
          } else if (offset == 980) {
            getPokemonDetails(offset: offset, limit: 37);
          
          }

          halfwayReached = true; // Set the flag to true
        }
      }
    });
  }

  @override
  void dispose() {
    // Dispose of the scroll controller when the widget is disposed
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> getPokemonDetails({int offset = 0, int limit = 60}) async {
    int _offset = offset;
    int _limit = limit;
    try {
      List<Pokemon> pokemons = await getPokemons(offset: offset, limit: limit);

      List<Future<PokemonDetail>> futures = pokemons.map((pokemon) {
        return fetchPokemonDetail(pokemon.url);
      }).toList();

      List<PokemonDetail> pokemonDetails = await Future.wait(futures);
      setState(() {
        allPokemom.addAll(pokemonDetails);
        halfwayReached = false;
      });
    } catch (e) {
      //throw Exception('err Pokemon details: $e');
      getPokemonDetails(offset: _offset, limit: _limit);
    }
  }

  Future<List<Pokemon>> getPokemons({int offset = 0, int limit = 60}) async {
    List<Pokemon> pokemons = [];

    try {
      final response = await http.get(Uri.parse(
          'https://pokeapi.co/api/v2/pokemon/?offset=$offset&limit=$limit'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['results'];
        pokemons = data.map((json) => Pokemon.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load pokemons');
      }

      return pokemons;
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

  int calculateCrossAxisCount(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int columns = (screenWidth / 150).floor();
    return columns > 0 ? columns : 1;
  }

  Color getColor(int index) {
    String? color = colorType.firstWhere((element) =>
        element['type'] == allPokemom[index].types![0].type?.name)['color'];

    return Color(int.parse("0xFF${color!.substring(1)}"));
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      backgroundColor: Colors.white,
     
      body: Container(
        margin: const EdgeInsets.all(8),
        child: allPokemom.isNotEmpty
            ? GridView.builder(
                controller: _scrollController,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: calculateCrossAxisCount(context),
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: allPokemom.length,
                itemBuilder: (BuildContext context, int index) {
                  return
                      GestureDetector(
                        onTap: () => {
                      Navigator.push( context,
                                    MaterialPageRoute(
                                      builder: (context) => PokemonInfo(pokemonDetail: allPokemom[index]),
                                    ),
                                  )
                        },
                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                        color: getColor(index),
                        borderRadius: BorderRadius.circular(20.0),
                                          ),
                                          child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "# ${allPokemom[index].id}",
                                style: TextStyle(
                                    fontSize: orientation == Orientation.landscape
                                        ? 14
                                        : 22,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                            ),
                            SizedBox(
                                width: orientation == Orientation.landscape
                                    ? 90
                                    : 100,
                                height: orientation == Orientation.landscape
                                    ? 90
                                    : 100,
                                child: allPokemom[index]
                                            .sprites
                                            ?.other
                                            ?.officialArtwork?.frontDefault !=
                                        null
                                    ? Stack(
                                      children: [
                                         Align(
                                            alignment: Alignment.center,
                                            child: 
                                             Opacity(opacity: 0.7, child: Image.asset(
                                              'assets/images/bgpokeball.jpg',
                                              height: ((MediaQuery.of(context).size.width - 20) / calculateCrossAxisCount(context))),) 
                                                 
                                          ),
                                        Image.network(
                                            "${allPokemom[index].sprites?.other?.officialArtwork?.frontDefault}",
                                            width:
                                                orientation == Orientation.landscape
                                                    ? 90
                                                    : 100,
                                          ),
                                      ],
                                    )
                                    :  Align(
                                            alignment: Alignment.center,
                                            child: 
                                             Opacity(opacity: 0.55, child: Image.asset(
                                              'assets/images/bgpokeball.jpg',
                                              height: ((MediaQuery.of(context).size.width - 20) / calculateCrossAxisCount(context))),) 
                                                 
                                    )
                                    ),
                            LayoutBuilder(
                              builder: (BuildContext context,
                                  BoxConstraints constraints) {
                                double fontSize = 16;
                      
                                TextPainter textPainter = TextPainter(
                                  text: TextSpan(
                                      text: '${allPokemom[index].name}',
                                      style: TextStyle(fontSize: 16.0)),
                                  maxLines: 1,
                                  textDirection: TextDirection.ltr,
                                )..layout(maxWidth: constraints.maxWidth);
                      
                                if (textPainter.didExceedMaxLines) {
                                  // Handle overflow
                                  fontSize = 13.5;
                                }
                      
                                return Text(
                                  maxLines: 1,
                                  '${allPokemom[index].name}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize:
                                          orientation == Orientation.landscape
                                              ? 16
                                              : 20,
                                      color: Colors.white),
                                );
                              },
                            )
                          ],
                        ),
                                          ),
                                        ),
                      );

                  // const Center(child: CircularProgressIndicator());
                },
              )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
  // },
  //  ),
  //   );

  // }
}



