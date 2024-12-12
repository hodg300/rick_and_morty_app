import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/src/widgets/characters_listview_widget.dart';
import 'package:rick_and_morty_app/src/widgets/searching_bar_widget.dart';
import '../providers/rick_and_morty_provider.dart';
import '../utils/constants.dart';

class SearchCharactersWidget extends StatefulWidget {
  const SearchCharactersWidget({super.key});

  @override
  State<SearchCharactersWidget> createState() => _SearchCharactersWidgetState();
}

class _SearchCharactersWidgetState extends State<SearchCharactersWidget> {
  @override
  void initState() {
    super.initState();
    // Fetch initial data when the widget is first built
    var provider = context.read<RickAndMortyProvider>();
    if (provider.characters.isEmpty && provider.errorMessage == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // This ensures that any state-changing operation happens after the build phase
        // this method contains notifyListeners and because of that I should to call this method after the build phase finished
        provider.fetchCharacters();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RickAndMortyProvider>(
      builder: (context, characterProvider, child) {
        if (characterProvider.errorMessage != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  '${characterProvider.errorMessage}',
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.black.withOpacity(0.5),
                duration: const Duration(seconds: 3),
              ),
            );
          });
        }

        if (!characterProvider.hasMore) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text(
                  NO_MORE_DATA,
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.black.withOpacity(0.5),
                duration: const Duration(seconds: 3),
              ),
            );
          });
        }

        return Column(
          children: [
            const SearchingBarWidget(),
            Expanded(
              child: CharactersListviewWidget(characterProvider: characterProvider,)
            ),
          ],
        );
      },
    );
  }
}
