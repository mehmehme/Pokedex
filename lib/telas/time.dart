import 'package:flutter/material.dart';
import 'package:pokedex/banco/pokemon.dart';
import 'package:pokedex/estilos/fundotime.dart';
import 'package:pokedex/network/pokeNet.dart';
import 'package:pokedex/telas/descricao/meuPoke.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimeScreen extends StatefulWidget {
  const TimeScreen({super.key});

  @override
  _TimeScreenState createState() => _TimeScreenState();
}

class _TimeScreenState extends State<TimeScreen> {
  List<Pokemon> _pokemons = [];

  @override
  void initState() {
    super.initState();
    _loadTime();
  }

  // Carregar os pokémons do time a partir do SharedPreferences
  Future<void> _loadTime() async {
    final prefs = await SharedPreferences.getInstance();
    final time = prefs.getStringList('time') ?? [];
    final pokemonNetwork = PokemonNetwork();
    final pokemons = await pokemonNetwork.fetchPokemons(page: 1, limit: 151);

    setState(() {
      _pokemons = pokemons.where((pokemon) => time.contains(pokemon.id.toString())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 70, 14, 14),
        title: const Padding(
          padding: EdgeInsets.only(left:85.0),
          child: Text(
            'Meu Time',
            style:TextStyle(
              color: Color.fromARGB(255, 236, 213, 252),
            ),
          ),
        ),),
      body: Stack(
        children:[
          const CustomBackground(), 
          GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1.0,
        ),
        itemCount: _pokemons.length,
        itemBuilder: (context, index) {
          final pokemon = _pokemons[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SoltarScreen(pokemon: pokemon),
                ),
              );
            },
            child: Card(
              color: _getBackgroundColor(pokemon.types),
              child: Column(
                children: [
                  Image.network(pokemon.thumbnailUrl, width: 60, height: 60),
                  Text(
                    pokemon.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ],
    ),);
  }

  Color _getBackgroundColor(List<String> types) {
    // A lógica para escolher a cor do Pokémon com base no seu tipo
    Map<String, Color> typeColors = {
      'Fire': Colors.red,
      'Water': Colors.blue,
      'Grass': Colors.green,
      'Electric': Colors.yellow,
      'Normal': Colors.grey,
    };

    // Retorna a cor do primeiro tipo encontrado
    for (var type in types) {
      if (typeColors.containsKey(type)) {
        return typeColors[type]!;
      }
    }
    return Colors.black;
  }
}
