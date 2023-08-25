import 'episode.dart';
import 'location.dart';

class Character {
  late String id;
  late String name;
  late String status;
  late String image;
  late String species;
  late String type;
  late String gender;
  late Location origin;
  late Location location;
  late List<Episode> episodes;

  Character(
    this.id,
    this.name,
    this.status,
    this.image,
    this.species,
    this.type,
    this.gender,
    this.origin,
    this.location,
    this.episodes,
  );

  Character.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> unknownLocation = {
      'id': '-1',
      'name': 'Unknown Location',
    };

    /// Asignation and fallbak data
    id = json['id'] ?? '';
    name = json['name'] ?? 'Unknown';
    status = json['status'] ?? 'Unknown';
    image = json['image'] ??
        'https://rickandmortyapi.com/api/character/avatar/19.jpeg';
    species = json['species'] ?? 'Unknown';
    type = json['type'] ?? '';
    gender = json['gender'] ?? 'Unknown';
    origin = Location.fromJson(json['origin'] ?? unknownLocation);
    location = Location.fromJson(json['location'] ?? unknownLocation);
    episodes = ((json['episode'] ?? []) as List)
        .map((episode) => Episode.fromJson(episode))
        .toList();
  }
}
