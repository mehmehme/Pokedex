import 'package:pokedex/banco/pokemon.dart';

abstract class PokemonRepository {

  Future<List<Pokemon>> getPokemons({required int page, required limit});
}
