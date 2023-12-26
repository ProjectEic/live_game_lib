import 'package:flutter/material.dart';

class CreateLobbyOptionsScreen extends StatelessWidget {
  final ThemeData theme;

  const CreateLobbyOptionsScreen({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lobby Options'),
        backgroundColor: theme.primaryColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Lobby Options Screen',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              child: Text('Lobby Options'),
            ),
          ],
        ),
      ),
    );
  }
}
