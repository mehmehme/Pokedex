import 'dart:convert';
import 'package:pokedex/banco/pokemon.dart';
import 'package:http/http.dart' as http;

class PokemonNetwork {
  final String apiUrl = 'http://192.168.0.23:3000/pokemon';
  final String imgUrl = 'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master';

   Future<List<Pokemon>> fetchPokemons({required int page, required int limit}) async {
    final response = await http.get(Uri.parse('$apiUrl/pokedex.json'));

  //final response = await http.get(Uri.parse('$apiUrl/pokedex.json'));

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);

    print('JSON Response: $data');

    // Aplique a paginação corretamente
    int startIndex = (page - 1) * limit;
    int endIndex = startIndex + limit;

    if (startIndex >= data.length) {
      return [];
    }

    final paginatedData = data.sublist(startIndex, endIndex > data.length ? data.length : endIndex);
    return paginatedData.map((json) => _pokemonFromJson(json)).toList();
  } else {
    throw Exception('Failed to load Pokémon data');
  }
}


  Pokemon _pokemonFromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'],
      name: json['name']['english'],
      types: List<String>.from(json['type']),
      baseStats: Map<String, int>.from(json['base']),
      thumbnailUrl: '$imgUrl/thumbnails/${json['id'].toString().padLeft(3, '0')}.png',
      spriteUrl: '$imgUrl/sprites/${json['id'].toString().padLeft(3, '0')}MS.png',
    );
  }
}
