import 'package:flutter/material.dart';
import 'package:live_game_lib/backend/room.dart';
import 'package:live_game_lib/frontend/playing_cards/playingcard_string.dart';
import 'package:live_game_lib/frontend/text/sub_heading.dart';
import 'package:live_game_lib/frontend/wrapper/flex/column_space_between.dart';
import 'package:live_game_lib/frontend/wrapper/scaffold_min_width.dart';
import 'package:playing_cards/playing_cards.dart';
import 'dart:math';

Widget mauMau(BuildContext context, Room room) {
  return MauMau(room: room);
}

/// Number of cards each player receives at the beginning of the game.
const int amountOfCards = 7;
bool initialized = false;

class MauMau extends StatefulWidget {
  final Room room;

  const MauMau({Key? key, required this.room}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MauMau createState() => _MauMau();
}

class _MauMau extends State<MauMau> {
  late Room room = widget.room;
  final int amountOfCards = 7;
  bool initalised = false;
  int selectedIdx = -1;
  String currentPlayingCard = "clubs:seven";

  /// Initializes the game, distributes cards to players, and creates the initial card stack.
  /// It also sets the current player and initializes the game state.
  void initGame(Room room) {
    try {
      List<String> players = room.players;

      // Populate the unUsedCards list with a standard deck of playing cards.
      for (Suit s in Suit.values) {
        for (CardValue c in CardValue.values) {
          // remove jokers (don't exist in mau mau)
          if (s == Suit.joker ||
              c == CardValue.joker_1 ||
              c == CardValue.joker_2) {
            continue;
          }

          room.addToList(
            "unUsedCards",
            "${s.toString().split(".")[1]}:${c.toString().split(".")[1]}",
          );
        }
      }

      print(room.getList("unUsedCards").length);
      List<dynamic> unUsedCards = List.from(room.getList("unUsedCards"));

      for (String player in players) {
        if (room.getList("hands/$player").length > 6) {
          initialized = true;
          return;
        }

        for (int i = 0; i < amountOfCards; i++) {
          if (unUsedCards.isNotEmpty) {
            int randomNumber = Random().nextInt(unUsedCards.length);

            try {
              room.addToList("hands/$player", unUsedCards[randomNumber - 1]);
              room.removeFromList("unUsedCards", unUsedCards[randomNumber - 1]);
              unUsedCards.remove(unUsedCards[randomNumber - 1]);
            } catch (e) {
              print("Error while adding/removing cards: $e");
              // Handle the error, you might want to log it or take appropriate action.
            }
          }
        }
      }

      // Set the initial player and create the card stack.
      room.set("currentPlayer", players[0]);
      createStack(room);
    } catch (e) {
      print("Error during game initialization: $e");
      // Handle the error, you might want to log it or take appropriate action.
    }
  }

  /// Creates a stack of cards and consumes all unUsedCards.
  /// Result: unUsedCards = [] and stack contains every card that isn't in the hand of a player.
  void createStack(Room room) {
    List<dynamic> unUsedCards = List.from(room.getList("unUsedCards"));

    for (String leftOverCard in unUsedCards) {
      room.addToList("stack", leftOverCard);
      room.removeFromList("unUsedCards", leftOverCard);
    }

    unUsedCards = [];
    shuffleList(List.from(room.getList("stack")));
  }

  /// Draws a card from the stack of cards, giving it to the player.
  /// Result updates Unused cards, Stack, and the player's Hand.
  void drawCard(Room room) {
    // If there are no cards to draw from anymore, create a new stack.
    if (List.from(room.getList("stack")).isEmpty) {
      createStack(room);
    }

    List<dynamic> cardStack = List.from(room.getList("stack"));
    shuffleList(cardStack);
    String drawnCard = cardStack.removeLast(); // Same as remove first

    room.addToList("unUsedCards", drawnCard);
    room.removeFromList("stack", drawnCard);

    String player = room.gameManager.username;
    room.addToList("hands/$player", drawnCard);

    nextTurn(room);
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

  /// Plays a card from the player's hand. If the card is valid, it removes it from the hand.
  void playCard(Room room, String cardSuit, String cardValue,
      String currentSuit, String currentValue) {
    print(
        " cardSuit $cardSuit cardValue $cardValue currentSuit $currentSuit currentValue $currentValue");
    String player = room.gameManager.username;
    // If the card is valid, remove it from the hand and set it as the current card.
    if (cardValue == currentValue ||
        cardSuit == currentSuit ||
        cardValue == "jack") {
      print({"$cardSuit:$cardValue"});
      print(room.getList("hands/$player").toString());
      room.removeFromList("hands/$player", "$cardSuit:$cardValue");

      room.set("currentCard", "$cardSuit:$cardValue");

      setState(() {
        currentPlayingCard = "$cardSuit:$cardValue";
      });

      int skip = 1;
      bool draw = false;
      if (cardValue == "eight") skip = 2;
      if (cardValue == "seven") {
        draw = true;
        skip = 2;
      }
      nextTurn(room, skip: skip, draw: draw);
    }
  }

  /// Advances the game to the next player's turn.
  void nextTurn(Room room, {int skip = 1, bool draw = false}) {
    List<String> players = room.players;
    String currentPlayer = room.getString("currentPlayer") as String;

    if (players.contains(currentPlayer)) {
      int currentPlayerIndex = players.indexOf(currentPlayer);
      int nextPlayerIndex = (currentPlayerIndex + skip) % players.length;
      String nextPlayer = players[nextPlayerIndex];

      if (draw) {
        drawCard(room);
        drawCard(room);
      }
      room.set("currentPlayer", nextPlayer);
    }
  }

  /// Builds and returns the main Mau Mau game screen.
  /// Displays the current player's hand, the top card on the stack, and other relevant information.
  @override
  Widget build(BuildContext context) {
    String player = room.gameManager.username;
    List<dynamic> yourHand = room.getList("hands/$player");
    // Initialize the game if not already initialized.
    print("yourHand ${yourHand.length}");
    if (!initialized) initGame(room);
    String currentPlayer = room.getString("currentPlayer") ?? "Error";
    if (player == currentPlayer) {
      currentPlayer = "";
    }

    print("currentPlayer $currentPlayer");
    return ScaffoldMinWidth(
      title: const Text("Mau Mau"),
      automaticallyImplyLeading: false,
      body: ColumnSpaceBetween(
        children: [
          SubHeading(
            text: currentPlayer.trim() == ""
                ? "Your turn"
                : "$currentPlayer's turn",
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  if (currentPlayer != "") return;
                  if (selectedIdx < 0) return;
                  String c = room.getString("currentCard") ?? "clubs:eight";

                  print("currentCard $c");
                  playCard(
                    room,
                    yourHand[selectedIdx].split(":")[0],
                    yourHand[selectedIdx].split(":")[1],
                    c.split(":")[0],
                    c.split(":")[1],
                  );
                },
                child: showCurrentPlayingCard(currentPlayingCard.split(":")[0],
                    currentPlayingCard.split(":")[1]),
              ),
              GestureDetector(
                onTap: () {
                  if (currentPlayer != "") return;
                  drawCard(room);
                },
                child: const PlayingCardString(
                  suit: "clubs", // values don't matter: only the back is shown
                  value: "2", // => save loading time
                  showBack: true,
                ),
              ),
            ],
          ),
          Flexible(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              controller: ScrollController(),
              shrinkWrap: true,
              itemCount: yourHand.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIdx = selectedIdx == index ? -1 : index;
                    });
                  },
                  child: Transform.translate(
                    offset: Offset(0.0, selectedIdx == index ? -20.0 : 0.0),
                    child: SizedBox(
                      width: 150.0,
                      child: ListTile(
                        title: PlayingCardString(
                          suit: yourHand[index].split(":")[0],
                          value: yourHand[index].split(":")[1],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Builds and returns a widget representing the current playing card.
  Widget showCurrentPlayingCard(String suit, String value) {
    return PlayingCardString(
      suit: suit,
      value: value,
    );
  }
}
