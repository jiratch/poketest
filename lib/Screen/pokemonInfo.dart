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

  Widget pokemonType(String type,Color color){
    return Container   (child: 
                       Align( alignment: Alignment.center,child: Text(type , textAlign: TextAlign.center, style: TextStyle(fontSize: 20),)),  
                        height: 50,
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black,width: 2),
                        color: color,
                        borderRadius: BorderRadius.circular(20.0),
                                          )
                                        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(        
        body: 

        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                 getColor(0),
                 pokemonDetail!.types!.length >= 2 ? getColor(1) : Colors.white,                
                
              ],
            ),),
        child:
        MediaQuery.of(context).size.width <= 500 ?
        Padding(
           padding: EdgeInsets.all(20),
          child: Column(
          
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
          SizedBox(height: 30,),
          Text("No. ${pokemonDetail?.id}",style: TextStyle(color: 
          Colors.white,fontSize: 32,fontWeight: FontWeight.w500), 
          textAlign: TextAlign.center,),
          Container(
            
            height: MediaQuery.of(context).size.width*(60/100),
            width: MediaQuery.of(context).size.width*(60/100),
            child: Image.network(
              "${pokemonDetail?.sprites?.other?.officialArtwork?.frontDefault}",
            ),
          ),
           Text("${pokemonDetail?.name}",style: TextStyle(color: 
          Colors.white,fontSize: 34,fontWeight: FontWeight.w500), 
          textAlign: TextAlign.center,),
          Padding(
            padding: EdgeInsets.all(4),
            child: Row( mainAxisAlignment: MainAxisAlignment.center,
            
               children: [
                pokemonType("${pokemonDetail?.types![0].type?.name}", getColor(0)),
                SizedBox(width: 8,),
                pokemonDetail!.types!.length >=2? pokemonType("${pokemonDetail?.types![1].type?.name}", getColor(1)) : Container()
            ],),
          )
         
          
               
              ],
            ),
        ) : Container()
    ));
  }
}
