import 'package:flutter/cupertino.dart';
import 'package:rick_and_morty_app/src/models/character.dart';

import '../services/rick_and_morty_service.dart';

class RickAndMortyProvider with ChangeNotifier {
  late List<Character> _characters = [];

  // Bool param for present snack bar when _hasMore = false
  bool _hasMore = true;

  // Bool param for present progress bar
  bool _loading = false;
  int _page = 1;
  String? _errorMessage;
  Map<String, String> _queryParams = {"page": "1", "name": "", "status": ""};

  List<Character> get characters => _characters;

  bool get hasMore => _hasMore;

  bool get loading => _loading;

  String? get errorMessage => _errorMessage;

  Map<String, String> get queryParams => _queryParams;

  /// This function asynchronously fetches characters from the `RickAndMortyService`,
  /// updates the local state with the retrieved data, and handles errors by setting an error message.
  /// It ensures state updates notify listeners, manages pagination,
  /// and filters characters based on a name parameter.
  Future<void> fetchCharacters() async {
    if (_loading || !_hasMore) return;

    _loading = true;
    notifyListeners();

    try {
      var response = await RickAndMortyService.fetchCharacters(_queryParams);
      if (response["status"] == "failure") {
        throw Exception(response["details"]);
      }
      // When the response status is success...
      List<Character> newCharacters = response["result"];
      _characters.addAll(newCharacters);
      if (response["hasMoreData"] == false) {
        _hasMore = false;
      }
    } catch (error) {
      _errorMessage = error.toString();
    }
    _loading = false;
    incrementPagination();
    notifyListeners();
  }

  incrementPagination() {
    // Update pagination number for the next API call
    _page++;
    _queryParams["page"] = _page.toString();
  }

  void reset() {
    _characters.clear();
    _hasMore = true;
    _page = 1;
    _loading = false;
    _errorMessage = null;
    _queryParams = {"page": "1", "name": "", "status": ""};
    notifyListeners();
  }

  updateFilterAndRefreshListView({String name = "", String status = ""}) async {
    reset();
    _queryParams = {"page": "1", "name": name, "status": status};
    await fetchCharacters();
  }
}
