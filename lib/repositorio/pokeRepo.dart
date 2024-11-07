import 'dart:io';

import 'package:pokedex/banco/pokemon.dart';
import 'package:pokedex/dao/pokeDao.dart';
import 'package:pokedex/network/pokeNet.dart';

class PokemonRepository {
  final PokemonDao _pokemonDao;
  final PokemonNetwork _pokemonNetwork;

  PokemonRepository(this._pokemonDao, this._pokemonNetwork);

  Future<List<Pokemon>> getPokemons() async {
    try {
      if (await _hasInternetConnection()) {
        // Busca dados online se há conexão
        final pokemons = await _pokemonNetwork.fetchPokemons();
        // Armazena os dados buscados no cache
        await _pokemonDao.savePokemons(pokemons);
        return pokemons;
      } else {
        // Busca do cache local se não há conexão
        return await _pokemonDao.getPokemons();
      }
    } catch (e) {
      // Em caso de erro na rede, usa o cache local como fallback
      return await _pokemonDao.getPokemons();
    }
  }

  Future<bool> _hasInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }
}
