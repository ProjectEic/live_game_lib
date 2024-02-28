import 'package:flutter/material.dart';
import 'package:live_game_lib/backend/room.dart';
import 'package:live_game_lib/frontend/playing_cards/playingcard_string.dart';
import 'package:live_game_lib/frontend/text/headline.dart';
import 'package:live_game_lib/frontend/text/sub_heading.dart';
import 'package:live_game_lib/frontend/text/text_button.dart';
import 'package:live_game_lib/frontend/wrapper/flex/column_space_around.dart';
import 'package:live_game_lib/frontend/wrapper/flex/column_space_between.dart';
import 'package:live_game_lib/frontend/wrapper/flex/row_space_evenly.dart';
import 'package:live_game_lib/frontend/wrapper/scaffold_min_width.dart';
import 'package:playing_cards/playing_cards.dart';
import 'dart:math';

Widget mauMau(BuildContext context, Room room) {
  return MauMau(room: room);
}

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
  bool initialized = false;
  int selectedIdx = -1;
  final ScrollController controller = ScrollController();

  /// Initializes the game, distributes cards to players, and creates the initial card stack.
  /// It also sets the current player and initializes the game state.
  void initGame(Room room) {
    try {
      List<String> players = room.players;

      // Check if the first player already has cards (then all have cards)
      if (room.getList("hands/${players[0]}").isNotEmpty) {
        initialized = true;
        return;
      }
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
        for (int i = 0; i < amountOfCards; i++) {
          if (unUsedCards.isNotEmpty) {
            int randomNumber = Random().nextInt(unUsedCards.length);

            try {
              room.addToList("hands/$player", unUsedCards[randomNumber - 1]);
              room.removeFromList("unUsedCards", unUsedCards[randomNumber - 1]);
              unUsedCards.remove(unUsedCards[randomNumber - 1]);
            } catch (e) {
              // ignore: avoid_print
              print("Error while adding/removing cards: $e");
            }
          }
        }
      }

      // Set the initial player and create the card stack.
      room.set("currentPlayer", players[0]);
      createStack(room);
    } catch (e) {
      // ignore: avoid_print
      print("Error during game initialization: $e");
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
  void drawCard(Room room, {String? player = ""}) {
    print("PLAYERR $player");
    if (player == "") player = room.getString("currentPlayer");

    // If there are no cards to draw from anymore, create a new stack.
    if (List.from(room.getList("stack")).isEmpty) {
      createStack(room);
    }

    List<dynamic> cardStack = List.from(room.getList("stack"));
    shuffleList(cardStack);
    String drawnCard = cardStack.removeLast(); // Same as remove first

    room.addToList("unUsedCards", drawnCard);
    room.removeFromList("stack", drawnCard);

    print("PLAYERR $player");
    room.addToList("hands/$player", drawnCard);
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

  /// Plays a card from the player's hand, if it is a valid move.
  void playCard(Room room, String cardSuit, String cardValue,
      String currentSuit, String currentValue) {
    print(
        "cardSuit $cardSuit cardValue $cardValue currentSuit $currentSuit currentValue $currentValue");
    String player = room.gameManager.username;

    String? lastCard = room.getString("lastCard");
    if (lastCard != null) {
      if (room.getString("jackSuit") != "") {
        room.set("jackSuit", "");
      }

      String lastCardValue = lastCard.split(":")[1];
      String? canPlay = room.getString("canPlay");

      if (canPlay != null &&
          cardSuit == canPlay &&
          lastCardValue == "jack" &&
          cardValue != "jack") {
        room.removeFromList("hands/$player", "$cardSuit:$cardValue");
        room.set("currentCard", "$cardSuit:$cardValue");

        int skip = 1;
        bool draw = false;
        if (cardValue == "eight") skip = 2;
        if (cardValue == "seven") draw = true;
        print(skip);
        nextTurn(room, skip: skip, draw: draw);
        return;
      }
    }

    if (cardValue == "jack") {
      // Open a dialog to choose the suit for the jack
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const SubHeading(text: "Choose a suit"),
            content: SizedBox(
              height: MediaQuery.of(context).size.height / 4,
              child: ColumnSpaceAround(
                children: [
                  RowSpaceEvenly(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context, "hearts");
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(4.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text(
                          "♥",
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context, "diamonds");
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(4.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text(
                          "♦",
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ],
                  ),
                  RowSpaceEvenly(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context, "spades");
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(4.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text(
                          "♠",
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context, "clubs");
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(4.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text(
                          "♣",
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ).then((chosenSuit) {
        if (chosenSuit != null) {
          room.set("canPlay", chosenSuit);
          room.set("lastCard", "$cardSuit:$cardValue");

          room.set("jackSuit", chosenSuit);

          // Rest of your existing code
          print({"$cardSuit:$cardValue"});
          print(room.getList("hands/$player").toString());
          room.removeFromList("hands/$player", "$cardSuit:$cardValue");

          room.set("currentCard", "$cardSuit:$cardValue");

          int skip = 1;
          bool draw = false;
          if (cardValue == "eight") skip = 2;
          if (cardValue == "seven") draw = true;
          print(skip);
          nextTurn(room, skip: skip, draw: draw);
          return;
        }
      });
    } else if (cardValue == currentValue || cardSuit == currentSuit) {
      if (room.getString("jackSuit") != "") {
        room.set("jackSuit", "");
      }

      // Rest of your existing code
      print({"$cardSuit:$cardValue"});
      print(room.getList("hands/$player").toString());
      room.removeFromList("hands/$player", "$cardSuit:$cardValue");

      room.set("currentCard", "$cardSuit:$cardValue");

      int skip = 1;
      bool draw = false;
      if (cardValue == "eight") skip = 2;
      if (cardValue == "seven") draw = true;
      print(skip);
      room.set("lastCard", "$cardSuit:$cardValue");
      nextTurn(room, skip: skip, draw: draw);
      return;
    }
  }

  /// Advances the game to the next player's turn.
  void nextTurn(Room room, {int skip = 1, bool draw = false}) {
    List<String> players = room.players;
    String currentPlayer = room.getString("currentPlayer") as String;
    if (room.getList("hands/" + currentPlayer).length <= 1) {
      room.set("winner", currentPlayer);
      return;
    }
    if (players.contains(currentPlayer)) {
      int currentPlayerIndex = players.indexOf(currentPlayer);
      int nextPlayerIndex = (currentPlayerIndex + skip) % players.length;

      room.set("currentPlayer", players[nextPlayerIndex]);
      print(players);
      if (draw) {
        // draws a card to the next player
        print("nextPlayer $nextPlayerIndex");
        print(players[nextPlayerIndex]);

        print("currentPlayer $currentPlayerIndex");
        print(players[currentPlayerIndex]);
        drawCard(room, player: players[nextPlayerIndex]);
        drawCard(room, player: players[nextPlayerIndex]);
      }

      for (var player in players) {
        print(room.getList("hands/$player"));
        if (room.getList("hands/$player").isEmpty) {
          room.set("winner", player);
          print(room.getString("winner"));
          return;
        }
      }
    }
  }

  /// Builds and returns the main Mau Mau game screen.
  /// Displays the current player's hand, the top card on the stack, and other relevant information.
  @override
  Widget build(BuildContext context) {
    String hasWon = room.getString("winner") ?? "";

    // Initialize the game if not already initialized.
    if (!initialized && room.amAdmin) initGame(room);

    print("hasWON: $hasWon");
    return ScaffoldMinWidth(
      title: const Text("Mau Mau"),
      automaticallyImplyLeading: false,
      body: hasWon != ""
          ? gameOverMauMau(context, hasWon)
          : gameViewMaumMau(
              context,
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

  /// Builds and returns a widget representing the Game Over screen of MauMau
  Widget gameOverMauMau(BuildContext context, String player) {
    return Center(
      child: ColumnSpaceAround(children: [
        Headline(
          text: "$player has won the Game!",
        ),
        TextButtonWidget(
          text: 'Quit',
          onPressed: () => room.goBackToLobby(),
        ),
      ]),
    );
  }

  Widget gameViewMaumMau(BuildContext context) {
    String player = room.gameManager.username;
    List<dynamic> yourHand = room.getList("hands/$player");
    print("yourHand ${yourHand.length}");
    String currentPlayingCard = room.getString("currentCard") ?? "clubs:seven";
    String snackBarText = room.getString("jackSuit") ?? "";

    String currentPlayer = room.getString("currentPlayer") ?? "Error";
    if (player == currentPlayer) {
      currentPlayer = "";
    }

    return ColumnSpaceBetween(
      children: [
        SubHeading(
          text: currentPlayer.trim() == ""
              ? "Your turn"
              : "$currentPlayer's turn",
        ),
        Text(snackBarText.trim().isNotEmpty
            ? "Joker suit chosen: $snackBarText"
            : ""),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                if (currentPlayer != "") return;
                if (selectedIdx < 0) return;
                String c = room.getString("currentCard") ?? "clubs:seven";

                print("currentCard $c");
                playCard(
                  room,
                  yourHand[selectedIdx].split(":")[0],
                  yourHand[selectedIdx].split(":")[1],
                  c.split(":")[0],
                  c.split(":")[1],
                );
                setState(() {
                  selectedIdx = -1;
                });
              },
              child: showCurrentPlayingCard(currentPlayingCard.split(":")[0],
                  currentPlayingCard.split(":")[1]),
            ),
            GestureDetector(
              onTap: () {
                if (currentPlayer != "") return;
                drawCard(room);
                nextTurn(room);
                setState(() {
                  selectedIdx = -1;
                });
              },
              child: const PlayingCardString(
                suit: "clubs", // values don't matter: only the back is shown
                value: "2", // => save loading time
                showBack: true,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 200,
          width: double.maxFinite,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            controller: controller,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: yourHand.length,
            itemBuilder: (BuildContext context, int index) {
              String card = yourHand[index];
              bool isSelected = selectedIdx == index;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 150.0,
                transform: Matrix4.translationValues(
                  0.0,
                  isSelected ? -20.0 : 0.0,
                  0.0,
                ),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIdx = selectedIdx == index ? -1 : index;
                    });
                  },
                  child: ListTile(
                    title: PlayingCardString(
                      suit: card.split(":")[0],
                      value: card.split(":")[1],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
