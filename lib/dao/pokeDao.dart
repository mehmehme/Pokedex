import 'dart:convert';
import 'package:pokedex/banco/pokemon.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PokemonDao {
  static const String _pokemonsKey = 'pokemons';

  Future<void> savePokemons(List<Pokemon> pokemons) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> pokemonsJson = pokemons.map((p) => jsonEncode(_pokemonToJson(p))).toList();
    await prefs.setStringList(_pokemonsKey, pokemonsJson);
  }

  Future<List<Pokemon>> getPokemons() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? pokemonsJson = prefs.getStringList(_pokemonsKey);

    if (pokemonsJson == null) return [];

    return pokemonsJson.map((pJson) => _pokemonFromJson(jsonDecode(pJson))).toList();
  }

  Map<String, dynamic> _pokemonToJson(Pokemon pokemon) {
    return {
      'id': pokemon.id,
      'name': pokemon.name,
      'types': pokemon.types,
      'baseStats': pokemon.baseStats,
      'thumbnailUrl': pokemon.thumbnailUrl,
      'spriteUrl': pokemon.spriteUrl,
    };
  }

  Pokemon _pokemonFromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'],
      name: json['name'],
      types: List<String>.from(json['types']),
      baseStats: Map<String, int>.from(json['baseStats']),
      thumbnailUrl: json['thumbnailUrl'],
      spriteUrl: json['spriteUrl'],
    );
  }
}
