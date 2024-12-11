import 'package:flutter/cupertino.dart';
import 'package:rick_and_morty_app/src/models/character.dart';
import 'package:rick_and_morty_app/src/utils/http_requests.dart';

import '../utils/utils.dart';

class RickAndMortyService{
  static const String bastUrl = "https://rickandmortyapi.com/api/character";

  // Fetch characters from the API
  static Future<List<Character>> fetchCharacters(Map<String, String>? queryParams) async {
    try {
      var queryParamsStr = queryParams != null ? Utils.mapToQueryParams(queryParams) : "";
      final response = await HttpRequests.getRequest("$bastUrl?$queryParamsStr");
      print(response);
      List<Character> characters = List<dynamic>.of(response).map((json) => Character.fromJson(json)).toList();
      return characters;
    } catch (e) {
      print("fetchCharacters: $e");
      return [];
    }
  }
}
