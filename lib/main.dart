import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:poketest/Const/colorsType.dart' as Const;
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
  int offset = 20;

  bool halfwayReached = false;
  bool isFirstUpdatePokemon = true;
  final colorType = Const.colortypes;

     @override
  void initState() {
    super.initState();

    getPokemonDetails(limit:20); //getPokemonDetails first time

    _scrollController.addListener(() {
     if (!halfwayReached) {

        double halfwayPoint = (_scrollController.position.maxScrollExtent +
                _scrollController.position.minScrollExtent) / 2;

        if((_scrollController.position.pixels >= halfwayPoint - 50 &&
            _scrollController.position.pixels <= halfwayPoint + 50 ) || _scrollController.position.maxScrollExtent == _scrollController.offset){
       
         if(isFirstUpdatePokemon){
            offset = offset + 30;
            isFirstUpdatePokemon = false;
          }else{
             offset = offset + 50;
          }

         if(offset <= 1000){
           getPokemonDetails(offset:offset);
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


   Future<void> getPokemonDetails({int offset = 0,int limit = 50}) async {
    try {

    
        List<Pokemon> pokemons = await getPokemons(offset:offset,limit: limit);

        List<Future<PokemonDetail>> futures = pokemons.map((pokemon) {
          return fetchPokemonDetail(pokemon.url);
        }).toList();

        List<PokemonDetail> pokemonDetails = await Future.wait(futures);
        setState(() {
          allPokemom.addAll(pokemonDetails);
          halfwayReached = false;
        }); 
  
    } catch (e) {
   
      throw Exception('err Pokemon details: $e');
    }
  }


  Future<List<Pokemon>> getPokemons({int offset = 0,int limit = 50}) async {
  List<Pokemon> pokemons = [];

  try {
 
      final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/?offset=$offset&limit=$limit'));

      if (response.
      statusCode == 200) {
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
    int columns = (screenWidth/150).floor(); 
    return columns > 0 ? columns : 1; 
  }

  Color getColor(int index, double opacity){

    String? color = colorType.firstWhere((element) => element['type'] == allPokemom[index].types![0].type?.name)['color'];

    return Color(int.parse("0xFF${color!.substring(1)}")).withOpacity(opacity);


  }


  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(  
      // backgroundColor: Colors.amberAccent[50],
      body: Container(
                      margin: const EdgeInsets.all(8),
                      child: allPokemom.isNotEmpty? 
                           GridView.builder(
                              controller: _scrollController,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: calculateCrossAxisCount(context), 
                                crossAxisSpacing: 8.0,
                                mainAxisSpacing: 8.0,
                              ),
                              itemCount: allPokemom.length+1, 
                                 itemBuilder: (BuildContext context, int index) {
                                return index < allPokemom.length ?
                               Container(    
                                    padding: const EdgeInsets.all(10),                    
                                  decoration: BoxDecoration(
                                  color: getColor(index,1),
                                  // border: Border.all(width: 4, color: 
                                  // HSLColor.fromColor(getColor(index, 0.5)).withLightness(0.5).toColor()),
                                  
                                  borderRadius: BorderRadius.circular(20.0),  
                                ),
                                  child: Center(
                      child:  
                       
                          Column(
                          
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [          
                            Align(child: Text("# ${allPokemom[index].order}",style: 
                            TextStyle(fontSize: orientation == Orientation.landscape? 16 : 22, 
                            fontWeight: FontWeight.w500,color: Colors.white),),
                            alignment: Alignment.topRight,),              
                            Image.network("${allPokemom[index].sprites?.other?.officialArtwork?.frontDefault}",  
                            //  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                            //     if (loadingProgress == null) {
                            //       return child;
                            //     } else {
                            //       return Container(
                            //         width: 100, 
                            //         height: 100,
                            //         color: Colors.transparent, 
                                
                            //       );
                            //     }
                            //   },                         
                            width: orientation == Orientation.landscape? 90 : 100,),
                           Text(
                                '${allPokemom[index].name}',
                                style:  TextStyle(fontWeight: FontWeight.w400, fontSize: orientation == Orientation.landscape? 16 : 20,color: Colors.white),
                              ),
                            
                          ],
                        ),
                 
                        
                                  ),
                                ):
                                 
                                  const Center(child: CircularProgressIndicator());
                              },
                            ): const Center(child: CircularProgressIndicator()),
                    ),
                
                );
                
            
              }
           // },
        //  ),
    //   );
        
    // }
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
  int? height;
  String? name;
  int? order;
  Sprites? sprites;
  List<Types>? types;
  int? weight;

  PokemonDetail(
      {this.height,
      this.name,
      this.order,
      this.sprites,
      this.types,
      this.weight});

  PokemonDetail.fromJson(Map<String, dynamic> json) {
    height = json['height'];
    name = json['name'];
    order = json['order'];
    sprites =
        json['sprites'] != null ? new Sprites.fromJson(json['sprites']) : null;
    if (json['types'] != null) {
      types = <Types>[];
      json['types'].forEach((v) {
        types!.add(new Types.fromJson(v));
      });
    }
    weight = json['weight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['height'] = this.height;
    data['name'] = this.name;
    data['order'] = this.order;
    if (this.sprites != null) {
      data['sprites'] = this.sprites!.toJson();
    }
    if (this.types != null) {
      data['types'] = this.types!.map((v) => v.toJson()).toList();
    }
    data['weight'] = this.weight;
    return data;
  }
}

class Sprites {
  Other? other;

  Sprites({this.other});

  Sprites.fromJson(Map<String, dynamic> json) {
    other = json['other'] != null ? new Other.fromJson(json['other']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.other != null) {
      data['other'] = this.other!.toJson();
    }
    return data;
  }
}

class Other {
  OfficialArtwork? officialArtwork;

  Other({this.officialArtwork});

  Other.fromJson(Map<String, dynamic> json) {
    officialArtwork = json['official-artwork'] != null
        ? new OfficialArtwork.fromJson(json['official-artwork'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.officialArtwork != null) {
      data['official-artwork'] = this.officialArtwork!.toJson();
    }
    return data;
  }
}

class OfficialArtwork {
  String? frontDefault;
  String? frontShiny;

  OfficialArtwork({this.frontDefault, this.frontShiny});

  OfficialArtwork.fromJson(Map<String, dynamic> json) {
    frontDefault = json['front_default'];
    frontShiny = json['front_shiny'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['front_default'] = this.frontDefault;
    data['front_shiny'] = this.frontShiny;
    return data;
  }
}

class Types {
  int? slot;
  Type? type;

  Types({this.slot, this.type});

  Types.fromJson(Map<String, dynamic> json) {
    slot = json['slot'];
    type = json['type'] != null ? new Type.fromJson(json['type']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slot'] = this.slot;
    if (this.type != null) {
      data['type'] = this.type!.toJson();
    }
    return data;
  }
}

class Type {
  String? name;
  String? url;

  Type({this.name, this.url});

  Type.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}

