import 'package:flutter/cupertino.dart';
import 'package:rick_and_morty_app/src/models/character.dart';

import '../services/rick_and_morty_service.dart';

// class RickAndMortyRepo extends ChangeNotifier {
//   List<Character> characters = [];
//
//   Future<List<Character>> fetchAllCharacters(Map<String, String>? queryParams) async{
//     characters = await RickAndMortyService.fetchCharacters(queryParams);
//     notifyListeners();
//     return characters;
//   }
// }

class RickAndMortyProvider with ChangeNotifier {
  late List<Character> _characters = [];
  bool _hasMore = true;
  bool _loading = false;
  int _page = 1;
  String? _errorMessage;
  Map<String, String> _params = {"page": "1", "name": "", "status": ""};

  List<Character> get characters => _characters;

  bool get hasMore => _hasMore;

  bool get loading => _loading;

  String? get errorMessage => _errorMessage;

  Map<String, String> get params => _params;

  Future<void> fetchCharacters() async {
    if (_loading || !_hasMore) return;

    _loading = true;
    notifyListeners();

    try {
      List<Character> newCharacters =
          await RickAndMortyService.fetchCharacters(_params);
      _characters.addAll(newCharacters);
      if (newCharacters.isEmpty) {
        _hasMore = false;
      }
    //   here - add logic to handle errors
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _loading = false;
      _page++;
      _params["page"] = _page.toString();
      notifyListeners();
    }
    filterCharacters(_params["name"]!);
  }

  void reset() {
    _characters.clear();
    _hasMore = true;
    _page = 1;
    _loading = false;
    _errorMessage = null;
    _params = {"page": "1"};
    notifyListeners();
  }

  updateFilter({String name = "", String status = ""}) async {
    reset();
    _params = {"page": "1", "name": name, "status": status};
    await fetchCharacters();
  }

  // Ensures that the search filters characters whose names fully contain the entered query
  // string by using the contains method,
  // matching the exact sequence of characters in a case-insensitive manner.
  void filterCharacters(String query) {
    final lowerCaseQuery = query.toLowerCase();

    _characters = characters.where((character) {
      return character.name.toLowerCase().contains(lowerCaseQuery);
    }).toList();

    notifyListeners();
  }
}
