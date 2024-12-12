import 'package:rick_and_morty_app/src/models/character.dart';
import 'package:rick_and_morty_app/src/utils/http_requests.dart';
import '../utils/server_status.dart';
import '../utils/utils.dart';

class RickAndMortyService {
  static const String bastUrl = "https://rickandmortyapi.com/api/character";

  // Fetch characters from the API
  static Future<dynamic> fetchCharacters(
      Map<String, String>? queryParams) async {
    try {
      var queryParamsStr =
          queryParams != null ? Utils.mapToQueryParams(queryParams) : "";
      final response =
          await HttpRequests.getRequest("$bastUrl?$queryParamsStr");
      if (response["status"] == "success") {
        var hasMoreData = response["result"]["info"]["next"] != null ? true : false;
        List<Character> characters = List<dynamic>.of(response["result"]["results"])
            .map((json) => Character.fromJson(json))
            .toList();
        response["result"] = characters;
        response["hasMoreData"] = hasMoreData;
        return response;
      } else {
        response["details"] = "Not found";
        return response;
      }
    } catch (e) {
      return {
        "status": "failure",
        "details": ResponseStatus.serverError
      };
    }
  }
}
