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
  Future<List<Pokemon>> getPokemons({required int page, required limit}) async {
     try {
      // Verifica se o cache já tem os Pokémons necessários para essa página
      final cachedPokemons = await _pokemonDao.getPokemons();
      
      // Se o cache não estiver vazio, aplica a paginação e retorna os Pokémons
      if (cachedPokemons.isNotEmpty) {
        return _paginatePokemons(cachedPokemons, page, limit);
      }

      // Caso o cache esteja vazio, tenta buscar os dados da rede com o limite e a página
      final pokemons = await _pokemonNetwork.fetchPokemons(page: page, limit: limit);
      
      // Se a busca for bem-sucedida, salva os Pokémons no cache
      await _pokemonDao.savePokemons(pokemons);

      // Retorna os Pokémons recebidos da rede
      return pokemons;
    } catch (e) {
      // Se houver um erro (como falha de conexão), tenta retornar o cache
      final cachedPokemons = await _pokemonDao.getPokemons();
      return _paginatePokemons(cachedPokemons, page, limit);
    }
  }

  // Função para aplicar a paginação ao cache
  List<Pokemon> _paginatePokemons(List<Pokemon> allPokemons, int page, int limit) {
    int startIndex = (page - 1) * limit;
    int endIndex = startIndex + limit;

    // Verifique se o startIndex é válido e não ultrapassa o comprimento da lista
    if (startIndex >= allPokemons.length) {
      return [];
    }

    // Retorna uma fatia dos Pokémons com base na página e limite
    return allPokemons.sublist(startIndex, endIndex > allPokemons.length ? allPokemons.length : endIndex);
  }
}
