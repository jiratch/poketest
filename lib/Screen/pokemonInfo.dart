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
        margin: EdgeInsets.only(bottom: 28),
        height: 42,
        width: 102,
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

  Color getStatColor(int stat) {
    Color color;
    if (stat < 40) {
      color = Colors.red;
    } else if (stat >= 40 && stat < 60) {
      color = Color(0xFFfa9223);
    } else if (stat >= 60 && stat < 90) {
      color = Color(0xFFFFCE4B);
    } else {
      color = Color(0xFF42d481);
    }

    return color;
  }

  int calculateCrossAxisCount(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int columns = (screenWidth / 300).floor();
    return columns > 0 ? columns : 1;
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
            child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: calculateCrossAxisCount(context),
                ),
                itemCount: 2,
                itemBuilder: (BuildContext context, int index) {
                  return index == 0
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(
                              height: 22,
                            ),
                            Text(
                              "#${pokemonDetail?.id} ${pokemonDetail?.name}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 28.5,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                            ),
                            Expanded(
                              child: Image.network(
                                "${pokemonDetail?.sprites?.other?.officialArtwork?.frontDefault}",
                              ),
                            ),
                            Row(
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
                          ],
                        )
                      : Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 0,
                              ),
                              Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  height: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Expanded(
                                          flex: 3,
                                          child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white
                                                    .withOpacity(0.475),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(20)),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      const Text("Height",
                                                          style: TextStyle(
                                                              fontSize: 17,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                      const Text("Weight",
                                                          style: TextStyle(
                                                              fontSize: 17,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Text(
                                                          "${(pokemonDetail!.height!.toDouble() * 0.1).toStringAsFixed(1)} meters",
                                                          style: TextStyle(
                                                              fontSize: 14.5)),
                                                      Text(
                                                          "${(pokemonDetail!.weight!.toDouble() * 0.1).toStringAsFixed(1)} kg",
                                                          style: TextStyle(
                                                              fontSize: 14.5)),
                                                    ],
                                                  ),
                                                ],
                                              ))),
                                      SizedBox(width: 10),
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(0.475),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(20)),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                "Abilities",
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Text(
                                                  "${pokemonDetail?.abilities![0].ability?.name}",
                                                  style:
                                                      TextStyle(fontSize: 14)),
                                              pokemonDetail!
                                                          .abilities!.length >=
                                                      2
                                                  ? Text(
                                                      "${pokemonDetail?.abilities![1].ability?.name}",
                                                      style: TextStyle(
                                                          fontSize: 14))
                                                  : Container()
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  )),
                              const SizedBox(
                                height: 4,
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 6),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.475),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      const Text("Base Stat",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500)),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount:
                                            pokemonDetail?.stats?.length ?? 0,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                4, 4, 0, 4),
                                            child: Row(children: [
                                              Expanded(
                                                flex: 1,
                                                child: Row(
                                                  children: [
                                                    Text(
                                                        "${pokemonDetail?.stats![index].stat?.name}",
                                                        style: TextStyle(
                                                            fontSize: 18)),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Row(
                                                  children: [
                                                    Container(
                                                        color: getStatColor(
                                                            pokemonDetail!
                                                                .stats![index]
                                                                .baseStat!),
                                                        height: 20,
                                                        width: (pokemonDetail!
                                                                        .stats![
                                                                            index]
                                                                        .baseStat!
                                                                        .toDouble() *
                                                                    1.05 >=
                                                                165
                                                            ? 165
                                                            : pokemonDetail!
                                                                    .stats![
                                                                        index]
                                                                    .baseStat!
                                                                    .toDouble() *
                                                                1.05))
                                                  ],
                                                ),
                                              )
                                            ]),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                })));
  }
}
