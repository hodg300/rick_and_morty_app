import 'package:flutter_test/flutter_test.dart';
import 'package:rick_and_morty_app/src/providers/rick_and_morty_provider.dart';

void main() {
  group('RickAndMortyProvider Tests', () {
    late RickAndMortyProvider provider;

    setUp(() {
      provider = RickAndMortyProvider();
    });

    test('Initial state is correct', () {
      expect(provider.characters, []);
      expect(provider.loading, false);
      expect(provider.hasMore, true);
      expect(provider.errorMessage, null);
    });

    test('fetchCharacters adds characters to the list and the first pagination',
        () async {
      await provider.fetchCharacters();

      expect(provider.characters.length, 20);
      expect(provider.characters.first.name, 'Rick Sanchez');
      expect(provider.hasMore, true);
      expect(provider.errorMessage, null);
    });

    test(
        'fetchCharacters adds characters to the list and the second pagination',
        () async {
      await provider.fetchCharacters();
      await provider.fetchCharacters();

      expect(provider.characters.length, 40);
      expect(provider.characters.first.name, 'Rick Sanchez');
      expect(provider.hasMore, true);
      expect(provider.errorMessage, null);
    });

    test('fetchCharacters adds characters to the list with filters', () async {
      await provider.updateFilterAndRefreshListView(
          name: 'Mechanical Summer', status: 'Unknown');
      await provider.fetchCharacters();

      expect(provider.characters.first.name, 'Mechanical Summer');
      expect(provider.hasMore, false);
      expect(provider.errorMessage, null);
    });

    test('Fetch the last page of characters', () async {
      provider.queryParams["page"] = "42";
      await provider.fetchCharacters();

      expect(provider.hasMore, false);
      expect(provider.errorMessage, null);
    });
  });
}
