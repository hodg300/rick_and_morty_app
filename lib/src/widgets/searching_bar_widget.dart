import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/src/providers/rick_and_morty_provider.dart';
import '../utils/constants.dart';

class SearchingBarWidget extends StatefulWidget {
  const SearchingBarWidget({super.key});

  @override
  State<SearchingBarWidget> createState() => _SearchingBarWidgetState();
}

class _SearchingBarWidgetState extends State<SearchingBarWidget> {
  String status = "";
  String name = "";
  // Prevent click search with same filters
  bool hasChanged = false;

  _onPressSearch() async {
    if (hasChanged) {
      // Close keyboard
      FocusManager.instance.primaryFocus?.unfocus();
      await context
          .read<RickAndMortyProvider>()
          .updateFilterAndRefreshListView(name: name, status: status);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  onChanged: (query) async {
                    if (name != query) {
                      setState(() {
                        name = query;
                        hasChanged = true;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    hintText: SEARCH_HINT,
                    hintStyle: const TextStyle(fontSize: hintFontSize),
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(borderRadius),
                    ),
                  ),
                ),
              ),
              PopupMenuButton<String>(
                onSelected: (String value) async {
                  if (status != value) {
                    setState(() {
                      status = value;
                    });
                    await context
                        .read<RickAndMortyProvider>()
                        .updateFilterAndRefreshListView(
                            name: name, status: status);
                  }
                },
                icon: const Icon(Icons.filter_list, color: Colors.grey),
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem(
                    value: ALIVE.toLowerCase(),
                    padding: EdgeInsets.zero,
                    child: Container(
                        decoration: status == ALIVE.toLowerCase()
                            ? BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius:
                                    BorderRadius.circular(borderRadius))
                            : null,
                        child:
                            const ListTile(title: Center(child: Text(ALIVE)))),
                  ),
                  PopupMenuItem(
                    value: DEAD.toLowerCase(),
                    padding: EdgeInsets.zero,
                    child: Container(
                        decoration: status == DEAD.toLowerCase()
                            ? BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius:
                                    BorderRadius.circular(borderRadius))
                            : null,
                        child:
                            const ListTile(title: Center(child: Text(DEAD)))),
                  ),
                  PopupMenuItem(
                    value: UNKNOWN.toLowerCase(),
                    padding: EdgeInsets.zero,
                    child: Container(
                        decoration: status == UNKNOWN.toLowerCase()
                            ? BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius:
                                    BorderRadius.circular(borderRadius))
                            : null,
                        child: const ListTile(
                            title: Center(child: Text(UNKNOWN)))),
                  ),
                  PopupMenuItem(
                    value: '',
                    padding: EdgeInsets.zero,
                    child: Container(
                        decoration: status == ''
                            ? BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius:
                                    BorderRadius.circular(borderRadius))
                            : null,
                        child:
                            const ListTile(title: Center(child: Text(NONE)))),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0),
            child: TextButton(
              onPressed: _onPressSearch,
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue, // Button background color
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(borderRadius), // Border radius
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    SEARCH,
                    style: TextStyle(color: Colors.white),
                  ),
                  Icon(Icons.search)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
