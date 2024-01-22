import 'package:flutter/material.dart';
import 'package:playing_cards/playing_cards.dart';

class FrenchCard extends StatelessWidget {
  final Suit suit;
  final CardValue cardValue;

  const FrenchCard(this.suit, this.cardValue, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        PlayingCardView(
          card: PlayingCard(suit, cardValue),
        ),
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
