import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'pokemon.dart';

class PokemonDatabase {
  static const String _pokemonsKey = 'pokemons';

  /// Salva uma lista de Pokémons no `SharedPreferences`.
  Future<void> savePokemons(List<Pokemon> pokemons) async {
    final prefs = await SharedPreferences.getInstance();
    // Converte a lista de Pokémons para uma lista de JSON Strings
    final List<String> pokemonsJson = pokemons.map((p) => jsonEncode(p.toJson())).toList();
    await prefs.setStringList(_pokemonsKey, pokemonsJson);
  }

  /// Recupera todos os Pokémons salvos.
  Future<List<Pokemon>> getPokemons() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? pokemonsJson = prefs.getStringList(_pokemonsKey);

    if (pokemonsJson == null) return [];

    return pokemonsJson.map((pJson) => Pokemon.fromJson(jsonDecode(pJson))).toList();
  }

  /// Salva um Pokémon individual na lista.
  Future<void> savePokemon(Pokemon pokemon) async {
    final List<Pokemon> pokemons = await getPokemons();
    // Verifica se o Pokémon já existe para atualizar ou adicionar
    final existingIndex = pokemons.indexWhere((p) => p.id == pokemon.id);
    if (existingIndex != -1) {
      pokemons[existingIndex] = pokemon; // Atualiza se já existir
    } else {
      pokemons.add(pokemon); // Adiciona novo
    }
    await savePokemons(pokemons);
  }

  /// Remove um Pokémon pelo ID.
  Future<void> removePokemon(int id) async {
    final List<Pokemon> pokemons = await getPokemons();
    pokemons.removeWhere((p) => p.id == id);
    await savePokemons(pokemons);
  }
}
