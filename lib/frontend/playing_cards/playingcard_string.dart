import 'package:flutter/material.dart';
import 'package:playing_cards/playing_cards.dart';

class PlayingCardString extends StatelessWidget {
  final String suit;
  final String value;
  final double width;
  final double height;
  final bool showBack;

  const PlayingCardString({
    Key? key,
    required this.suit,
    required this.value,
    this.width = 100.0,
    this.height = 150.0,
    this.showBack = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Suit suitEnum;
    CardValue valueEnum;
    switch (suit) {
      case "hearts":
        suitEnum = Suit.hearts;
        break;
      case "diamonds":
        suitEnum = Suit.diamonds;
        break;
      case "clubs":
        suitEnum = Suit.clubs;
        break;
      case "spades":
        suitEnum = Suit.spades;
        break;
      case "joker":
        suitEnum = Suit.joker;
        break;
      default:
        suitEnum = Suit.hearts;
    }

    switch (value) {
      case "two":
        valueEnum = CardValue.two;
        break;
      case "three":
        valueEnum = CardValue.three;
        break;
      case "four":
        valueEnum = CardValue.four;
        break;
      case "five":
        valueEnum = CardValue.five;
        break;
      case "six":
        valueEnum = CardValue.six;
        break;
      case "seven":
        valueEnum = CardValue.seven;
        break;
      case "eight":
        valueEnum = CardValue.eight;
        break;
      case "nine":
        valueEnum = CardValue.nine;
        break;
      case "ten":
        valueEnum = CardValue.ten;
        break;
      case "jack":
        valueEnum = CardValue.jack;
        break;
      case "queen":
        valueEnum = CardValue.queen;
        break;
      case "king":
        valueEnum = CardValue.king;
        break;
      case "ace":
        valueEnum = CardValue.ace;
        break;
      case "joker_1":
        valueEnum = CardValue.joker_1;
        break;
      case "joker_2":
        valueEnum = CardValue.joker_2;
        break;
      default:
        valueEnum = CardValue.two;
    }

    return SizedBox(
      width: width,
      height: height,
      child: PlayingCardView(
        showBack: showBack,
        card: PlayingCard(suitEnum, valueEnum),
      ),
    );
  }
}
