import 'dart:convert';
import 'package:pokedex/banco/pokemon.dart';
import 'package:http/http.dart' as http;

class PokemonNetwork {
  final String apiUrl = 'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master';

  Future<List<Pokemon>> fetchPokemons() async {
    final response = await http.get(Uri.parse('$apiUrl/pokedex.json'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => _pokemonFromJson(json)).toList();
    } else {
      throw Exception('Failed to load Pokémon data');
    }
  }

  Pokemon _pokemonFromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'],
      name: json['name'],
      types: List<String>.from(json['type']),
      baseStats: Map<String, int>.from(json['base']),
      thumbnailUrl: '$apiUrl/thumbnails/${json['id'].toString().padLeft(3, '0')}.png',
      spriteUrl: '$apiUrl/sprites/${json['id'].toString().padLeft(3, '0')}MS.png',
    );
  }
}
