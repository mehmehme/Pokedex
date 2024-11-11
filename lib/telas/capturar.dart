import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pokedex/banco/pokemon.dart';
import 'package:pokedex/estilos/fundoCap.dart';
import 'package:pokedex/network/pokeNet.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CapturarScreen extends StatefulWidget {
  const CapturarScreen({super.key});

  @override
  _CapturarScreenState createState() => _CapturarScreenState();
}

class _CapturarScreenState extends State<CapturarScreen> {
  Pokemon? _pokemonAleatorio;
  bool _capturadoHoje = false;
  bool _timeCheio = false;

  @override
  void initState() {
    super.initState();
    _loadCapturaStatus();
    _gerarPokemonAleatorio();
  }

  // Carregar o status de captura do SharedPreferences
  Future<void> _loadCapturaStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _capturadoHoje = prefs.getBool('capturadoHoje') ?? false;
      _timeCheio = (prefs.getInt('timeCount') ?? 0) >= 6;
    });
  }

  // Gerar um Pokémon aleatório
  Future<void> _gerarPokemonAleatorio() async {
    final randomId = Random().nextInt(151) + 1; // Pokémon ID aleatório de 1 a 151
    final pokemonNetwork = PokemonNetwork();
    final pokemons = await pokemonNetwork.fetchPokemons(page: 1, limit: 151);
    _pokemonAleatorio = pokemons.firstWhere((pokemon) => pokemon.id == randomId);

    setState(() {});
  }

  // Capturar o Pokémon e salvar o estado
  Future<void> _capturarPokemon() async {
    if (_capturadoHoje || _timeCheio) return;

    final prefs = await SharedPreferences.getInstance();
    // Salvar que o Pokémon foi capturado hoje
    await prefs.setBool('capturadoHoje', true);
    // Atualizar o time de Pokémon
    List<String> time = prefs.getStringList('time') ?? [];
    if (time.length < 6) {
      time.add(_pokemonAleatorio!.id.toString());
      await prefs.setStringList('time', time);
      setState(() {
        _capturadoHoje = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pokémon capturado!')),
      );
    } else {
      setState(() {
        _timeCheio = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('O time está cheio!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 117, 52, 106),
        title: const Text(
          'Capturar Pokémon',
          style:TextStyle(color: Colors.white),
        ),
        ),
      body: Stack(
        children: [
          GeometricBackground(),
          Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _pokemonAleatorio != null
                  ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            _pokemonAleatorio!.thumbnailUrl,
                            scale: 0.5,),
                          Text(
                            _pokemonAleatorio!.name,
                            style: const TextStyle(
                              fontSize: 40, 
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: _capturadoHoje || _timeCheio
                                ? null
                                : _capturarPokemon,
                            child: Text(_capturadoHoje
                                ? 'Já capturou hoje!'
                                : 'Capturar Pokémon'),
                          ),
                        ],
                      ),
                  )
                  : const CircularProgressIndicator(),
              if (_timeCheio)
                const Text(
                  'O time está cheio!',
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
            ],
          ),
        ),
      ],
      ),
    );
  }
}
