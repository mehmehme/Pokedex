import 'package:flutter/material.dart';
import 'package:pokedex/repositorio/pokeImpl.dart';


class lista extends StatelessWidget {
final pokemonRepository = PokemonRepositoryImpl();

  @override
  Widget build (BuildContext context){
    return const MaterialApp(
      home: Scaffold(
        body: Column(

        ),
      ),
    );
  }
}