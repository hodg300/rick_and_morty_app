// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:rick_and_morty_app/src/models/character.dart';
//
// import '../providers/rick_and_morty_provider.dart';
// import '../screens/character_details_screen.dart';
// import 'character_card.dart';
//
// class CharactersListViewWidget extends StatefulWidget {
//   const CharactersListViewWidget({super.key});
//
//   @override
//   State<CharactersListViewWidget> createState() => _CharactersListViewWidgetState();
// }
//
// class _CharactersListViewWidgetState extends State<CharactersListViewWidget> {
//   final List<Character> _items = [];
//   bool _hasMore = true;
//   bool _loading = false;
//   int _page = 1;
//   Map<String, String> params = {};
//
//   @override
//   void initState() {
//     super.initState();
//     fetchMoreItems();
//   }
//
//   resetParams(){
//     params.addAll(widget.queryParams);
//   }
//
//   Future<void> fetchMoreItems() async {
//     if (_loading || !_hasMore) return;
//
//     setState(() {
//       _loading = true;
//     });
//
//     try {
//       List<Character> newItems = await context.read<RickAndMortyRepo>().fetchAllCharacters(params); // Pass the current page number
//       setState(() {
//         _items.addAll(newItems);
//         _loading = false;
//         if (newItems.isEmpty) {
//           _hasMore = false;
//           _showToast();
//         }
//       });
//
//       _page++;
//     } catch (error) {
//       setState(() {
//         _loading = false;
//       });
//     }
//   }
//
//   void _showToast() {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text('No more data to load.'),
//         duration: Duration(seconds: 2),
//       ),
//     );
//   }
//
//   void _onCharacterTap(Character character) {
//     // Navigate to the character details screen
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => CharacterDetailsScreen(character: character)),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return NotificationListener<ScrollNotification>(
//       onNotification: (scrollInfo) {
//         if (_loading || !_hasMore) return false;
//
//         if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
//           fetchMoreItems();
//         }
//         return false;
//       },
//       child: ListView.builder(
//         itemCount: _items.length + 1,
//         itemBuilder: (context, index) {
//           if (index == _items.length) {
//             return _loading
//                 ? const Padding(
//               padding: EdgeInsets.symmetric(vertical: 16.0),
//               child: Center(child: CircularProgressIndicator()),
//             )
//                 : Container();
//           }
//           final character = _items[index];
//           return GestureDetector(
//             onTap: () => _onCharacterTap(character),
//             child: CharacterCard(character: character),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/src/widgets/searching_bar_widget.dart';

import '../providers/rick_and_morty_provider.dart';
import '../screens/character_details_screen.dart';
import 'character_card.dart';

class CharactersListViewWidget extends StatelessWidget {
  const CharactersListViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RickAndMortyProvider>(
      builder: (context, characterProvider, child) {
        // Fetch initial data when the widget is first built
        if (characterProvider.characters.isEmpty &&
            characterProvider.errorMessage == null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            // This ensures that any state-changing operation happens after the build phase
            characterProvider.fetchCharacters();
          });
        }

        // if (characterProvider.errorMessage != null) {
        //   // Show toast with the error message
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(
        //       content: Text(
        //         'Error: ${characterProvider.errorMessage}',
        //         style: const TextStyle(color: Colors.white),
        //       ),
        //       backgroundColor: Colors.red,
        //       duration: const Duration(seconds: 2),
        //     ),
        //   );
        // }
        // } else if (!characterProvider.hasMore) {
        //   // Show toast with the error message
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     const SnackBar(
        //       content: Text(
        //         'No more data',
        //         style: TextStyle(color: Colors.white),
        //       ),
        //       backgroundColor: Colors.red,
        //       duration: Duration(seconds: 2),
        //     ),
        //   );
        // }

        return Column(
          children: [
            const SearchingBarWidget(),
            Expanded(
              child: NotificationListener<ScrollNotification>(
                onNotification: (scrollInfo) {
                  if (characterProvider.loading || !characterProvider.hasMore)
                    return false;

                  if (scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent) {
                    characterProvider.fetchCharacters();
                  }
                  return false;
                },
                child: ListView.builder(
                  itemCount: characterProvider.characters.length + 1,
                  itemBuilder: (context, index) {
                    if (index == characterProvider.characters.length) {
                      return characterProvider.loading
                          ? const Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.0),
                              child: Center(child: CircularProgressIndicator()),
                            )
                          : Container();
                    }
                    final character = characterProvider.characters[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CharacterDetailsScreen(character: character)),
                        );
                      },
                      child: CharacterCard(character: character),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

// class CharactersListViewWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<RickAndMortyRepo>(
//       builder: (context, characterProvider, child) {
//         // Fetch initial data when the widget is first built
//         if (characterProvider.characters.isEmpty && characterProvider.errorMessage == null) {
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             // This ensures that any state-changing operation happens after the build phase
//             characterProvider.fetchCharacters();
//           });
//         }
//
//         if (characterProvider.errorMessage != null) {
//           // Show toast with the error message
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(
//                 'Error: ${characterProvider.errorMessage}',
//                 style: const TextStyle(color: Colors.white),
//               ),
//               backgroundColor: Colors.red,
//               duration: const Duration(seconds: 2),
//             ),
//           );
//         } else if (!characterProvider.hasMore) {
//           // Show toast with the error message
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text(
//                 'No more data',
//                 style: TextStyle(color: Colors.white),
//               ),
//               backgroundColor: Colors.red,
//               duration: Duration(seconds: 2),
//             ),
//           );
//         }
//
//         return Column(
//           children: [
//             _buildSearchBar(characterProvider),
//             Expanded(
//               child: NotificationListener<ScrollNotification>(
//                 onNotification: (scrollInfo) {
//                   if (characterProvider.loading || !characterProvider.hasMore) return false;
//
//                   if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
//                     characterProvider.fetchCharacters();
//                   }
//                   return false;
//                 },
//                 child: ListView.builder(
//                   itemCount: characterProvider.characters.length + 1,
//                   itemBuilder: (context, index) {
//                     if (index == characterProvider.characters.length) {
//                       return characterProvider.loading
//                           ? const Padding(
//                         padding: EdgeInsets.symmetric(vertical: 16.0),
//                         child: Center(child: CircularProgressIndicator()),
//                       )
//                           : Container();
//                     }
//                     final character = characterProvider.characters[index];
//                     return GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => CharacterDetailsScreen(character: character)),
//                         );
//                       },
//                       child: CharacterCard(character: character),
//                     );
//                   },
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   Widget _buildSearchBar(RickAndMortyRepo characterProvider) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//       child: Row(
//         children: [
//           Expanded(
//             child: TextField(
//               onChanged: (query) {
//                 characterProvider.filterCharacters(query);
//               },
//               decoration: InputDecoration(
//                 hintText: 'Search characters...',
//                 prefixIcon: const Icon(Icons.search),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//               ),
//             ),
//           ),
//           PopupMenuButton<String>(
//             onSelected: (String value) {
//               characterProvider.filterByStatus(value);
//             },
//             icon: const Icon(Icons.filter_list, color: Colors.grey),
//             itemBuilder: (BuildContext context) => [
//               PopupMenuItem(
//                 value: 'alive',
//                 child: Text('Alive'),
//               ),
//               PopupMenuItem(
//                 value: 'dead',
//                 child: Text('Dead'),
//               ),
//               PopupMenuItem(
//                 value: 'unknown',
//                 child: Text('Unknown'),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
