
class Pokemon {
  final int id;
  final String name;
  final List<String> types;
  final Map<String, int> baseStats;
  final String thumbnailUrl;
  final String spriteUrl;

  Pokemon({
    required this.id,
    required this.name,
    required this.types,
    required this.baseStats,
    required this.thumbnailUrl,
    required this.spriteUrl,
  });

  // Converte um Pokémon para um Map para armazenamento em JSON
   Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'types': types,
      'baseStats': baseStats,
      'thumbnailUrl': thumbnailUrl,
      'spriteUrl': spriteUrl,
    };
  }

  // Converte de JSON para um objeto `Pokemon`
  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'],
      name: json['name'],
      types: List<String>.from(json['types']),
      baseStats: Map<String, int>.from(json['baseStats']),
      thumbnailUrl: json['thumbnailUrl'],
      spriteUrl: json['spriteUrl'],
    );
  }
} 

