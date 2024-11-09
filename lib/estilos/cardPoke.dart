import 'package:flutter/material.dart';
import 'package:pokedex/banco/pokemon.dart';

class PokemonTile extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonTile({super.key, required this.pokemon});

  Color _getBackgroundColor(List<String> types) {
  // Mapeia cada tipo para uma cor específica
  Map<String, Color> typeColors = {
    'Fire': const Color.fromARGB(255, 238, 102, 69),
    'Water': const Color.fromARGB(255, 97, 116, 180),
    'Grass': const Color.fromARGB(255, 49, 150, 91),
    'Electric': const Color.fromARGB(255, 248, 238, 151),
    'Normal': const Color.fromARGB(255, 92, 89, 92),
    'Fighting': const Color.fromARGB(255, 190, 51, 149),
    'Flying': const Color.fromARGB(255, 159, 206, 200),
    'Poison': const Color.fromARGB(255, 44, 107, 72),
    'Ground': const Color.fromARGB(255, 99, 75, 53),
    'Rock': const Color.fromARGB(255, 78, 78, 72),
    'Bug': const Color.fromARGB(255, 155, 202, 68),
    'Ghost': const Color.fromARGB(255, 130, 116, 136),
    'Steel': const Color.fromARGB(255, 151, 153, 158),
    'Psychic': const Color.fromARGB(255, 148, 30, 163),
    'Ice': const Color.fromARGB(255, 182, 243, 253),
    'Dragon': const Color.fromARGB(255, 226, 149, 77),
    'Dark': const Color.fromARGB(255, 83, 59, 87),
    'Fairy': const Color.fromARGB(255, 250, 103, 164),
  };

  // Retorna a cor do primeiro tipo encontrado na lista ou uma cor padrão
  for (String type in types) {
    if (typeColors.containsKey(type)) {
      return typeColors[type]!;
    }
  }

  // Retorna uma cor padrão se nenhum tipo na lista tiver uma cor específica
  return Colors.grey;
}

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _getBackgroundColor(pokemon.types),  // Fundo baseado no tipo
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Imagem do Pokémon
          Image.network(
            pokemon.spriteUrl,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.error, color: Colors.red);
            },
          ),
          const SizedBox(height: 8.0),
          // Nome do Pokémon
          Text(
            pokemon.name,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          // Tipo do Pokémon
          Container(
            margin: const EdgeInsets.only(top: 4.0),
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              pokemon.types.join(', '),
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}