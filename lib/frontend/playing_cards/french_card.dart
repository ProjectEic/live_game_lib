import 'abstarct_card.dart';

class Card extends AbstractCard {
  final Map<String, String> wordToSymbol = {
    'spades': '♠',
    'hearts': '♥',
    'diamonds': '♦',
    'clubs': '♣',
  };

  Card(
      {required super.value,
      required super.icon,
      required super.text,
      required super.x,
      required super.y,
      super.width,
      super.height}) {
    super.icon = wordToSymbol[icon]!;
  }
}
