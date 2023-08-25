import 'package:rick_and_morty_demo/models/character.dart';

class Location {
  late String id;
  late String name;
  late String type;
  late String dimension;
  late List<Character> residents;

  Location(this.id, this.name, this.type, this.dimension, this.residents);

  Location.fromJson(Map<String, dynamic> json) {
    /// Asignation and fallbak data
    id = json['id'] ?? '';
    name = json['name'];
    type = json['type'] ?? 'Unknown';
    dimension = json['dimension'] ?? 'Unknown';
    residents = ((json['residents'] ?? []) as List)
        .map((character) => Character.fromJson(character))
        .toList();
  }
}
