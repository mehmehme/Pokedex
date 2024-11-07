import 'dart:io';

import 'package:pokedex/banco/pokemon.dart';
import 'package:pokedex/dao/pokeDao.dart';
import 'package:pokedex/network/pokeNet.dart';
import 'package:pokedex/repositorio/pokeRepo.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonDao _pokemonDao;
  final PokemonNetwork _pokemonNetwork;

  PokemonRepositoryImpl()
      : _pokemonDao = PokemonDao(),
        _pokemonNetwork = PokemonNetwork();

  @override
  Future<List<Pokemon>> getPokemons() async {
    try {
      if (await _hasInternetConnection()) {
        // Busca dados online e atualiza o cache
        final pokemons = await _pokemonNetwork.fetchPokemons();
        await _pokemonDao.savePokemons(pokemons);
        return pokemons;
      } else {
        // Busca do cache local
        return await _pokemonDao.getPokemons();
      }
    } catch (e) {
      // Usa o cache em caso de erro de rede
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
