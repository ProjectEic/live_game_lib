import 'package:flutter/material.dart';

class GameNotFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Not Found'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '404 Game Not Found',
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'The game you are looking for could not be found.',
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
