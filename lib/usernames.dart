import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';


/// Build a ListView with each row as a randomly generated username
class WordList extends StatefulWidget {
  @override
  WordsListState createState() => WordsListState();
}

class WordsListState extends State<WordList> {
  // Just some filler data for now
  final _listItems = <WordPair>[];

  // Store saved items
  final _savedUsernames = Set<String>();

  Widget _generateList() {
    return ListView.builder(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        itemBuilder: (context, item) {
          if(item.isOdd) return Divider();

          // Get  the current index minus the dividers
          final index = item ~/ 2;

          // Create new list items when scrolling down
          if(index >= _listItems.length) {
            _listItems.addAll(generateWordPairs().take(10));
          }

          return _generateUsernameRow(_listItems[index].toString());
        }
    );
  }

  /// Generates a random row with a randomly generated username
  Widget _generateUsernameRow(String username) {
    final saved = _savedUsernames.contains(username);

    return ListTile(
      title: Text(username, style: TextStyle(fontSize: 20.0)),
      trailing: Icon(saved ? Icons.playlist_add_check : Icons.playlist_add),
      onTap: () {
        setState(() {
          if(saved)
            _savedUsernames.remove(username);
          else
            _savedUsernames.add(username);
        });
      },
    );
  }

  /// View the saved usernames on a different page
  /// Retrieve the saved items and display a simple list
  void _viewSavedUsernames() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          // Get List Tiles
          final Iterable<ListTile> listTiles = _savedUsernames.map(
            (String username) {
              return ListTile(
                title: Text(username, style: TextStyle(fontSize: 20.0))
              );
            }
          );

          // Add 1px spacing between them
          final List<Widget> dividedList = ListTile.divideTiles(
            context: context,
            tiles: listTiles
          ).toList();

          return Scaffold(
            appBar: AppBar(title: Text('Saved Usernames')),
            body: ListView(children: dividedList)
          );
        })
    );
  }

  /// Return a scaffold with an appbar and a list body
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Random Username Generator List'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.playlist_play),
              onPressed: _viewSavedUsernames,
            )
          ],
        ),
        body: _generateList()
    );
  }
}