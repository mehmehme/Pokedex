import 'package:flutter/material.dart';
import 'package:pokedex/banco/pokemon.dart';
import 'package:pokedex/estilos/cardPoke.dart';
import 'package:pokedex/repositorio/pokeImpl.dart';
import 'package:provider/provider.dart';

class Lista extends StatefulWidget {
  const Lista({super.key});

  @override
  State<Lista> createState() => _ListaState();
}

class _ListaState extends State<Lista> {
  late final PokemonRepositoryImpl pokemonRepository;
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;  // Página inicial
  final int _limit = 15;  // Limite de Pokémons por página
  List<Pokemon> _pokemons = []; // Lista de Pokémons carregados

  @override
  void initState() {
    super.initState();
    pokemonRepository = Provider.of<PokemonRepositoryImpl>(context, listen: false);
    _loadPokemons(); // Carregar os Pokémons inicialmente

    // Adiciona o listener para carregar mais Pokémons quando o usuário rolar até o final
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _loadMorePokemons();
      }
    });
  }

  // Função para carregar os Pokémons para a página atual
  Future<void> _loadPokemons() async {
    final pokemons = await pokemonRepository.getPokemons(page: _currentPage, limit: _limit);
    setState(() {
      _pokemons = pokemons;
    });
  }

  // Função para carregar mais Pokémons ao atingir o final da lista
  Future<void> _loadMorePokemons() async {
    setState(() {
      _currentPage++;  // Incrementa a página
    });
    final pokemons = await pokemonRepository.getPokemons(page: _currentPage, limit: _limit);
    setState(() {
      _pokemons.addAll(pokemons);  // Adiciona os Pokémons à lista existente
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 181, 209, 219),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 223, 157, 15),
        title: const Center(
          child: Text(
            "Pokedex",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top:8.0,left: 16.0, right: 16.0),
        child: _pokemons.isEmpty
            ? const Center(child: CircularProgressIndicator())  // Exibe carregamento até a primeira carga
            : GridView.builder(
                controller: _scrollController,  // Controller para o scroll
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // Número de colunas
                  childAspectRatio: 0.75, // Proporção largura/altura dos itens
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: _pokemons.length + 1,  // Adiciona 1 para o loader de mais Pokémons
                itemBuilder: (context, index) {
                  if (index == _pokemons.length) {
                    // Se for o último item, mostra um indicador de carregamento
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    final pokemon = _pokemons[index];
                    return PokemonTile(pokemon: pokemon);
                  }
                },
              ),
      ),
      );
  }
}
