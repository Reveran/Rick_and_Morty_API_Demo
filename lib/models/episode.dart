import 'character.dart';

class Episode {
  late String id;
  late String name;
  late String airDate;
  late String episode;
  late List<Character> characters;

  Episode(this.id, this.name, this.airDate, this.episode, this.characters);

  Episode.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    name = json['name'];
    airDate = json['air_date'] ?? 'Unknown';
    episode = json['episode'] ?? 'Unknown';
    characters = ((json['characters'] ?? []) as List)
        .map((character) => Character.fromJson(character))
        .toList();
  }
}
