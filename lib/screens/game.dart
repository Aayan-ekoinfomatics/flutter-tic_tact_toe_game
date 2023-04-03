import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:information_app/constants/colors.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  bool oTurn = true;
  List<String> displayXO = ['', '', '', '', '', '', '', '', ''];

  List<int> matchedIndexes = [];
  int attempts = 0;

  int oScore = 0;
  int xScore = 0;
  int filledBoxes = 0;

  bool winnerFound = false;

  String resultDeclaration = '';

  static const maxSeconds = 30;
  int seconds = maxSeconds;

  Timer? timer;

  static var customFontWhite = GoogleFonts.coiny(
    textStyle: const TextStyle(
      color: Colors.white,
      letterSpacing: 3,
      fontSize: 28,
    ),
  );

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else {
          stopTimer();
        }
      });
    });
  }

  void stopTimer() {
    resetTimer();
    timer?.cancel();
  }

  void resetTimer() {
    seconds = maxSeconds;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MainColor.primaryColor,
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Player O',
                            style: customFontWhite,
                          ),
                          Text(
                            oScore.toString(),
                            style: customFontWhite,
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Player X',
                            style: customFontWhite,
                          ),
                          Text(
                            xScore.toString(),
                            style: customFontWhite,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                  flex: 3,
                  child: GridView.builder(
                    itemCount: 9,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          tapped(index);
                        },
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              width: 5,
                              color: MainColor.primaryColor,
                            ),
                            color: matchedIndexes.contains(index)
                                ? MainColor.accentColor
                                : MainColor.secondaryColor,
                          ),
                          child: Center(
                            child: Text(
                              // 'O',
                              displayXO[index],
                              style: GoogleFonts.coiny(
                                  textStyle: TextStyle(
                                      fontSize: 64,
                                      color: MainColor.primaryColor)),
                            ),
                          ),
                        ),
                      );
                    },
                  )),
              Expanded(
                  flex: 1,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          resultDeclaration,
                          style: customFontWhite,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        builtTimer(),
                      ],
                    ),
                  )),
            ],
          ),
        ));
  }

  void tapped(int index) {
    final isRunning = timer == null ? false : timer!.isActive;
    if (isRunning) {
      setState(() {
        if (oTurn && displayXO[index] == '') {
          displayXO[index] = 'O';
          filledBoxes++;
        } else if (!oTurn && displayXO[index] == '') {
          displayXO[index] = 'X';
          filledBoxes++;
        }
        oTurn = !oTurn;

        checkWinner();
      });
    }
    ;
  }

  void checkWinner() {
    // first row
    if (displayXO[0] == displayXO[1] &&
        displayXO[0] == displayXO[2] &&
        displayXO[0] != '') {
      setState(() {
        resultDeclaration = 'Player ${displayXO[0]} wins!';
        matchedIndexes.addAll([0, 1, 2]);
        stopTimer();
        updateScore(displayXO[0]);
      });
    }

    // second row
    if (displayXO[3] == displayXO[4] &&
        displayXO[3] == displayXO[5] &&
        displayXO[3] != '') {
      setState(() {
        resultDeclaration = 'Player ${displayXO[3]} wins!';
        matchedIndexes.addAll([3, 4, 5]);
        stopTimer();
        updateScore(displayXO[3]);
      });
    }

    // third row
    if (displayXO[6] == displayXO[7] &&
        displayXO[6] == displayXO[8] &&
        displayXO[6] != '') {
      setState(() {
        resultDeclaration = 'Player ${displayXO[6]} wins!';
        matchedIndexes.addAll([6, 7, 8]);
        stopTimer();
        updateScore(displayXO[6]);
      });
    }

    // first column
    if (displayXO[0] == displayXO[3] &&
        displayXO[0] == displayXO[6] &&
        displayXO[0] != '') {
      setState(() {
        resultDeclaration = 'Player ${displayXO[0]} wins!';
        matchedIndexes.addAll([0, 3, 6]);
        stopTimer();
        updateScore(displayXO[0]);
      });
    }

    // second column
    if (displayXO[1] == displayXO[4] &&
        displayXO[1] == displayXO[7] &&
        displayXO[1] != '') {
      setState(() {
        resultDeclaration = 'Player ${displayXO[1]} wins!';
        matchedIndexes.addAll([1, 4, 7]);
        stopTimer();
        updateScore(displayXO[1]);
      });
    }

    // third column
    if (displayXO[2] == displayXO[5] &&
        displayXO[2] == displayXO[8] &&
        displayXO[2] != '') {
      setState(() {
        resultDeclaration = 'Player ${displayXO[2]} wins!';
        matchedIndexes.addAll([2, 5, 8]);
        stopTimer();
        updateScore(displayXO[2]);
      });
    }

    // first diagonal
    if (displayXO[0] == displayXO[4] &&
        displayXO[0] == displayXO[8] &&
        displayXO[0] != '') {
      setState(() {
        resultDeclaration = 'Player ${displayXO[0]} wins!';
        matchedIndexes.addAll([0, 4, 8]);
        stopTimer();
        updateScore(displayXO[0]);
      });
    }

    // second diagonal
    if (displayXO[6] == displayXO[4] &&
        displayXO[6] == displayXO[2] &&
        displayXO[6] != '') {
      setState(() {
        resultDeclaration = 'Player ${displayXO[6]} wins!';
        matchedIndexes.addAll([6, 4, 2]);
        stopTimer();
        updateScore(displayXO[6]);
      });
    }

    if (!winnerFound && filledBoxes == 9) {
      setState(() {
        resultDeclaration = 'Draw';
      });
    }
  }

  void updateScore(String winner) {
    if (winner == 'O') {
      oScore++;
    } else if (winner == 'X') {
      xScore++;
    }
    winnerFound = true;
  }

  void clearboard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayXO[i] = '';
      }
      resultDeclaration = '';
    });
    filledBoxes = 0;
    matchedIndexes = [];
  }

  Widget builtTimer() {
    final isRunning = timer == null ? false : timer!.isActive;
    return isRunning
        ? SizedBox(
            height: 100,
            width: 100,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: 1 - seconds / maxSeconds,
                  valueColor: const AlwaysStoppedAnimation(Colors.white),
                  strokeWidth: 8,
                  backgroundColor: MainColor.accentColor,
                ),
                Center(
                  child: Text(
                    '${seconds}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          )
        : ElevatedButton(
            onPressed: () {
              startTimer();
              clearboard();
              attempts++;
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                )),
            child: Text(
              attempts == 0 ? 'Start' : 'Play Again!',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ));
  }
}
