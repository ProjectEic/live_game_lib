import 'package:flutter/material.dart';
import 'package:live_game_lib/backend/room.dart';
import 'package:live_game_lib/frontend/text/sub_heading.dart';
import 'package:live_game_lib/frontend/wrapper/flex/column_space_between.dart';
import 'package:live_game_lib/frontend/wrapper/scaffold_min_width.dart';
import 'package:playing_cards/playing_cards.dart';
import 'dart:math';

/// List of unused cards in the game.
List<PlayingCard> unUsedCards = [];

/// List of cards that have been drawn.
List<PlayingCard> drawnCards = [];

/// Number of cards each player receives at the beginning of the game.
const int amountOfCards = 7;

/// Queue representing the stack of cards.
List<PlayingCard> cardStack = [];

/// Initializes the game, distributes cards to players, and creates the initial card stack.
/// It also sets the current player and initializes the game state.
void initGame(Room room) {
  // Populate the unUsedCards list with a standard deck of playing cards.
  for (Suit s in Suit.values) {
    for (CardValue c in CardValue.values) {
      room.addToList("unUsedCards", PlayingCard(s, c));
    }
  }

  // Distribute cards to each player in the room.
  List<String> players = room.players;
  for (String player in players) {
    for (int i = 0; i < amountOfCards; i++) {
      int randomNumber = Random().nextInt(unUsedCards.length);
      room.addToList("hands/$player", unUsedCards[randomNumber - 1]);
      room.removeFromList("unUsedCards", unUsedCards[randomNumber - 1]);
    }
  }

  // Set the initial player and create the card stack.
  room.set("currentPlayer", players[0]);
  createStack(room);
}

/// Shuffles the provided list using the Fisher-Yates shuffle algorithm.
void shuffleList(List list) {
  final random = Random();
  for (int i = list.length - 1; i > 0; i--) {
    int j = random.nextInt(i + 1);
    var temp = list[i];
    list[i] = list[j];
    list[j] = temp;
  }
}

/// Creates a stack of cards and consumes all unUsedCards.
/// Result: unUsedCards = [] and stack contains every card that isn't in the hand of a player.
void createStack(Room room) {
  for (PlayingCard leftOverCard in unUsedCards) {
    cardStack.add(leftOverCard);
    room.removeFromList("unUsedCards", leftOverCard);
  }

  unUsedCards = [];
  shuffleList(cardStack);
  for (var listItem in cardStack) {
    room.addToList("stack", listItem);
  }
  room.set("stack", cardStack);
  room.set("unUsedCards", unUsedCards);
}

/// Draws a card from the stack of cards, giving it to the player.
/// Result updates Unused cards, Stack, and the player's Hand.
void drawCard(Room room) {
  // If there are no cards to draw from anymore, create a new stack.
  if (List.from(room.getList("stack")).isEmpty) {
    createStack(room);
  }

  PlayingCard drawnCard = List.from(room.getList("stack")).removeLast();
  room.addToList("unUsedCards", drawnCard);
  room.removeFromList("stack", drawnCard);

  String player = room.gameManager.username;
  room.addToList("hands/$player", drawnCard);
  unUsedCards.add(drawnCard);

  nextTurn(room);
}

/// Plays a card from the player's hand. If the card is valid, it removes it from the hand.
void playCard(Room room, PlayingCard card, PlayingCard currentCard) {
  String player = room.gameManager.username;
  // If the card is valid, remove it from the hand and set it as the current card.
  if (card.suit == currentCard.suit || card.value == currentCard.value) {
    room.addToList("hands/$player", card);

    // TODO: RELOAD AND UPDATE THE CURRENT PLAYING CARD !!!

    nextTurn(room);
  }
}

/// Advances the game to the next player's turn.
void nextTurn(Room room) {
  List<String> players = room.players;
  String currentPlayer = room.getString("currentPlayer") as String;
  int currentPlayerIndex = players.indexOf(currentPlayer);
  int nextPlayerIndex = (currentPlayerIndex + 1) % players.length;
  String nextPlayer = players[nextPlayerIndex];
  room.set("currentPlayer", nextPlayer);
}

/// Builds and returns a widget representing the current playing card.
Widget currentPlayingCard(BuildContext context, Suit suit, CardValue value) {
  return PlayingCardView(
    card: PlayingCard(suit, value),
  );
}

/// Builds and returns the main Mau Mau game screen.
/// Displays the current player's hand, the top card on the stack, and other relevant information.
Widget mauMau(BuildContext context, Room room) {
  String player = room.gameManager.username;
  List<PlayingCard> yourHand = room.getList<PlayingCard>("hands/$player");

  // Initialize the game if not already initialized.
  initGame(room);
  if (player == room.getString("currentPlayer") as String) {
    return currentTurnView(context, room, yourHand);
  }
  return notCurrentTurnView(context, room, yourHand);
}

Widget notCurrentTurnView(
    BuildContext context, Room room, List<PlayingCard> yourHand) {
  return ScaffoldMinWidth(
    appBar: null,
    body: ColumnSpaceBetween(
      children: [
        SubHeading(text: "${room.getString("currentPlayer")}'s turn"),
        Expanded(
          child: Row(
            children: [
              currentPlayingCard(context, Suit.clubs, CardValue.eight),
              GestureDetector(
                onTap: () {
                  drawCard(room);
                },
                child: Stack(
                  children: cardStack.map((element) {
                    return Positioned(
                      child: PlayingCardView(card: element),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: yourHand.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListTile(
                  leading: PlayingCardView(card: yourHand[index]),
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}

Widget currentTurnView(
    BuildContext context, Room room, List<PlayingCard> yourHand) {
  return ScaffoldMinWidth(
    appBar: null,
    body: ColumnSpaceBetween(
      children: [
        const SubHeading(text: "Your turn"),
        Expanded(
          child: Row(
            children: [
              currentPlayingCard(context, Suit.clubs, CardValue.eight),
              GestureDetector(
                onTap: () {
                  drawCard(room);
                },
                child: Stack(
                  children: cardStack.map((element) {
                    return Positioned(
                      child: PlayingCardView(card: element),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: yourHand.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListTile(
                  leading: PlayingCardView(card: yourHand[index]),
                  onTap: () {
                    playCard(room, yourHand[index], cardStack.last);
                  },
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}
