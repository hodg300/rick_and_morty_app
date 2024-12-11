import 'package:json_annotation/json_annotation.dart';
import 'package:rick_and_morty_app/src/models/location.dart';
import 'package:rick_and_morty_app/src/models/origin.dart';

part 'character.g.dart';

@JsonSerializable()
class Character {
  final int id;
  final String name;
  final String status;
  final String species;
  final String gender;
  final String image;
  final Location location;
  final Origin origin;

  Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.gender,
    required this.image,
    required this.location,
    required this.origin
  });

  /// A factory constructor for creating a new `Character` instance
  /// from a map. Pass the map to the generated `_$CharacterFromJson()` constructor.
  /// The constructor is named after the source class, in this case, `Character`.
  factory Character.fromJson(Map<String, dynamic> json) =>
      _$CharacterFromJson(json);

  /// A method for converting a `Character` instance into a map.
  /// Pass the map to the generated `_$CharacterToJson()` method.
  Map<String, dynamic> toJson() => _$CharacterToJson(this);
}
