import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/src/providers/rick_and_morty_provider.dart';

class SearchingBarWidget extends StatefulWidget {
  const SearchingBarWidget({super.key});

  @override
  State<SearchingBarWidget> createState() => _SearchingBarWidgetState();
}

class _SearchingBarWidgetState extends State<SearchingBarWidget> {
  String status = "";
  String name = "";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onSubmitted: (query) async {
                if (name != query) {
                  setState(() {
                    name = query;
                  });
                  await context
                      .read<RickAndMortyProvider>()
                      .updateFilter(name: name, status: status);
                }
              },
              decoration: InputDecoration(
                hintText: 'Search characters...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
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
                    .updateFilter(name: name, status: status);
              }
            },
            icon: const Icon(Icons.filter_list, color: Colors.grey),
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: 'alive',
                padding: EdgeInsets.zero,
                child: Container(
                    decoration: status == 'alive'
                        ? BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(8.0))
                        : null,
                    child: const ListTile(title: Center(child: Text('Alive')))),
              ),
              PopupMenuItem(
                value: 'dead',
                padding: EdgeInsets.zero,
                child: Container(
                    decoration: status == 'dead'
                        ? BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(8.0))
                        : null,
                    child: const ListTile(title: Center(child: Text('Dead')))),
              ),
              PopupMenuItem(
                value: 'unknown',
                padding: EdgeInsets.zero,
                child: Container(
                    decoration: status == 'unknown'
                        ? BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(8.0))
                        : null,
                    child:
                        const ListTile(title: Center(child: Text('Unknown')))),
              ),
              PopupMenuItem(
                value: '',
                padding: EdgeInsets.zero,
                child: Container(
                    decoration: status == ''
                        ? BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(8.0))
                        : null,
                    child: const ListTile(title: Center(child: Text('None')))),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
