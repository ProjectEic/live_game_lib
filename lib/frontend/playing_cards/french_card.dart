import 'package:flutter/material.dart';
import 'package:playing_cards/playing_cards.dart';

/// A Flutter widget representing a French playing card.
class FrenchCard extends StatelessWidget {
  /// The suit of the card.
  final Suit suit;

  /// The value of the card.
  final CardValue cardValue;

  /// Creates a FrenchCard widget.
  const FrenchCard(this.suit, this.cardValue, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // Display the playing card using the PlayingCardView widget.
        PlayingCardView(
          card: PlayingCard(suit, cardValue),
        ),
        // Positioned text widget at the bottom-left corner of the card.
        const Positioned(
          left: 15,
          bottom: 15,
          child: Text(
            'Your Text Here',
            style: TextStyle(fontSize: 28),
          ),
        ),
      ],
    );
  }
}
