import 'package:json_annotation/json_annotation.dart';

part 'origin.g.dart'; // The generated file


@JsonSerializable()
class Origin {
  final String name;
  final String url;

  Origin({required this.name, required this.url});

  factory Origin.fromJson(Map<String, dynamic> json) => _$OriginFromJson(json);

  Map<String, dynamic> toJson() => _$OriginToJson(this);
}