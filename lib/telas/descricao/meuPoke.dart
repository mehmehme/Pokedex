import 'package:flutter/material.dart';
import 'package:pokedex/banco/pokemon.dart';
import 'package:pokedex/estilos/quemEessePoke.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SoltarScreen extends StatelessWidget {
  final Pokemon pokemon;

  const SoltarScreen({super.key, required this.pokemon});

  // Soltar o Pokémon do time
  Future<void> _soltarPokemon(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> time = prefs.getStringList('time') ?? [];
    time.remove(pokemon.id.toString());
    await prefs.setStringList('time', time);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Pokémon solto!')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left:85.0),
          child: Text(pokemon.name),
        ),
        backgroundColor: const Color.fromARGB(255, 182, 87, 87),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Background(
          child: Center(
          child: Padding(
          padding: const EdgeInsets.only(top:20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Thumbnail em um círculo centralizado
                CircleAvatar(
                  radius: 80,
                  backgroundImage: 
                  NetworkImage(
                    pokemon.thumbnailUrl,
                    scale: 50.0,
                    ),
                  backgroundColor: const Color.fromARGB(255, 102, 28, 28),
                ),
                const SizedBox(height: 20),
                Text(
                  pokemon.types.join(', '),
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 20),
                // Mostra os dados base do Pokémon em barras de progresso
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView(
                      children: pokemon.baseStats.entries.map((entry) {
                        final statName = entry.key;
                        final statValue = entry.value;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              statName,
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                            const SizedBox(height: 6),
                            LinearProgressIndicator(
                              value: statValue / 100,
                              backgroundColor: const Color.fromARGB(255, 223, 87, 87),
                              color: const Color.fromARGB(255, 121, 10, 10),
                            ),
                            const SizedBox(height: 16),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
      ),
    );
  }
}
