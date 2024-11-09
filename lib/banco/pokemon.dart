
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
    };
  }

  // Converte de JSON para um objeto `Pokemon`
  factory Pokemon.fromJson(Map<String, dynamic> json) {
    const imgUrl = 'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master';
    return Pokemon(
      id: json['id'],
      name: json['name']['english'],
      types: List<String>.from(json['type']),
      baseStats: Map<String, int>.from(json['base']),
      thumbnailUrl: '$imgUrl/thumbnails/${json['id'].toString().padLeft(3, '0')}.png',
      spriteUrl: '$imgUrl/sprites/${json['id'].toString().padLeft(3, '0')}MS.png',
    );
  }
} 

