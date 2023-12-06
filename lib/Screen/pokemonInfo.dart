import 'package:flutter/material.dart';
import 'package:poketest/Model/PokemonDetail.dart';
import 'package:poketest/Const/colorsType.dart' as Const;

class PokemonInfo extends StatelessWidget {
  final PokemonDetail? pokemonDetail;
  const PokemonInfo({this.pokemonDetail}) : super();
  final colorType = Const.colortypes;

  Color getColor(int index) {
    String? color = colorType.firstWhere((element) =>
        element['type'] == pokemonDetail?.types![index].type?.name)['color'];

    return Color(int.parse("0xFF${color!.substring(1)}"));
  }

  Widget pokemonType(String type, Color color) {
    return Container(
        height: 45,
        width: 100,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1),
          color: color,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Align(
            alignment: Alignment.center,
            child: Text(
              type,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  getColor(0),
                  pokemonDetail!.types!.length >= 2
                      ? getColor(1)
                      : Color.fromARGB(77, 179, 177, 177),
                ],
              ),
            ),
            child: MediaQuery.of(context).size.width <= 500
                ? Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          "No. ${pokemonDetail?.id}",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                        Container(
                          height:
                              MediaQuery.of(context).size.width * (60 / 100),
                          width: MediaQuery.of(context).size.width * (60 / 100),
                          child: Image.network(
                            "${pokemonDetail?.sprites?.other?.officialArtwork?.frontDefault}",
                          ),
                        ),
                        Text(
                          "${pokemonDetail?.name}",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 34,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                        Padding(
                          padding: EdgeInsets.all(4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              pokemonType(
                                  "${pokemonDetail?.types![0].type?.name}",
                                  getColor(0)),
                              const SizedBox(
                                width: 8,
                              ),
                              pokemonDetail!.types!.length >= 2
                                  ? pokemonType(
                                      "${pokemonDetail?.types![1].type?.name}",
                                      getColor(1))
                                  : Container()
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            height: 100,
                            decoration: BoxDecoration(
                             // color: Colors.white.withOpacity(0.475),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                    flex: 3,
                                    child: Container(
                                        decoration: BoxDecoration(  
                                          color: Colors.white.withOpacity(0.475),                                        
                                          borderRadius:
                                              const BorderRadius.all(Radius.circular(20)),
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                const Text("Height"),
                                                const Text("Weight"),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                 Text("${(pokemonDetail!.height!.toDouble() * 0.1).toStringAsFixed(1)} meters"),
                                                 Text("${(pokemonDetail!.weight!.toDouble() * 0.1).toStringAsFixed(1)} kg"),
                                              ],
                                            ),
                                          ],
                                        ))
                                        ),
                                        SizedBox( width: 14),
                                Expanded(
                                  flex: 4,
                                    child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.475),                                       

                                          borderRadius:
                                              const BorderRadius.all(Radius.circular(20)),

                                        ),
                                        child: 
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: const [
                                                Text("Abilities"),                                             
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                               pokemonDetail!.abilities!.length >=2 ? MainAxisAlignment.spaceAround: 
                                               MainAxisAlignment.center,
                                              children: [
                                                 Text("${pokemonDetail?.abilities![0].ability?.name}"),
                                                pokemonDetail!.abilities!.length >= 2 ? 
                                                 Text("${pokemonDetail?.abilities![1].ability?.name}"): Container()                                             ],
                                            ),
                                          ],
                                        )))
                              ],
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(
                            child: Container(
                                decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.475),
                          borderRadius: BorderRadius.circular(20.0),
                        )))
                      ],
                    ),
                  )
                : Container()));
  }
}
