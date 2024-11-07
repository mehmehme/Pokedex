import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pokedex/banco/pokemon.dart';
import 'package:pokedex/repositorio/pokeImpl.dart';
import 'package:pokedex/repositorio/pokeRepo.dart';


class lista extends StatefulWidget {
  @override
  State<lista> createState() => _listaState();
}

class _listaState extends State<lista> {
static const _limit = 20;
final pokemonRepository = PokemonRepositoryImpl();
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pokedex"),
      ),
      body: Scaffold(),
      
      );

  // Função para mapear os tipos de Pokémon para cores
  /*Color _getCardColorForType(String types) {
    switch (types.toLowerCase()) {
      case 'fire':
        return const Color.fromARGB(255, 124, 66, 62);
      case 'water':
        return const Color.fromARGB(255, 63, 83, 100);
      case 'grass':
        return const Color.fromARGB(255, 42, 71, 43);
      case 'electric':
        return const Color.fromARGB(255, 156, 120, 20);
      case 'bug':
        return const Color.fromARGB(255, 40, 51, 41);
      case 'ghost':
        return const Color.fromARGB(255, 48, 42, 49);
      case 'psychic':
        return Colors.pink;
      default:
        return Colors.grey;
    }*/
  }
}