import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final String title;

  // given [game_name] and [route_name] as parameters as games[index][0] and games[index][1]
  final List<List<String>> games;

  const Home({
    Key? key,
    required this.title,
    required this.games,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView.builder(
        itemCount: games.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(games[index][0]),
            onTap: () {
              Navigator.pushNamed(
                context,
                games[index][1],
                arguments: games[index],
              );
            },
          );
        },
      ),
    );
  }
}
