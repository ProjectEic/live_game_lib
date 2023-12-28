import 'package:flutter/material.dart';

class CreateLobbyOptionsScreen extends StatelessWidget {
  const CreateLobbyOptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lobby Options',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {},
              child: const Text('Lobby Options'),
            ),
          ],
        ),
      ),
    );
  }
}
