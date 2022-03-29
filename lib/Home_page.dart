import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // the first player is o
  bool OsTurn = true;

  // The variable defined below makes sure the grids returns an empty string when the game starts

  List<String> displayEx0h = ['', '', '', '', '', '', '', '', ''];
  var playerTextStyle = TextStyle(color: Colors.white, fontSize: 25.0);
  int scoreforO = 0;
  int scoreforX = 0;
  int filledBoxes = 0;

  static var newFont = GoogleFonts.pressStart2p(
      textStyle: TextStyle(color: Colors.black, letterSpacing: 1));
  static var newFontWhite = GoogleFonts.pressStart2p(
      textStyle:
          TextStyle(color: Colors.black, letterSpacing: 1, fontSize: 12));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Column(children: [
        Expanded(
            child: Container(
          child: Center(
              child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Player O",
                      style: newFontWhite,
                    ),
                    Text(
                      scoreforO.toString(),
                      style: newFontWhite,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Player X",
                      style: newFontWhite,
                    ),
                    Text(
                      scoreforX.toString(),
                      style: newFontWhite,
                    ),
                  ],
                ),
              ),
            ],
          )),
        )),
        Expanded(
          flex: 3,
          child: GridView.builder(
            itemCount: 9,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  _tapped(index);
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: Colors.grey,
                  )),
                  child: Center(
                    child: Text(
                      displayEx0h[index],
                      style: TextStyle(color: Colors.white, fontSize: 40.0),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Expanded(child: Container()),
      ]),
    );
  }

  void _tapped(int index) {
    filledBoxes += 1;

    setState(() {
      if (OsTurn && displayEx0h[index] == '') {
        displayEx0h[index] = 'o';
      } else if (!OsTurn && displayEx0h[index] == '') {
        displayEx0h[index] = 'x';
      }
      //To switch it off(making OsTurn false)
      OsTurn = !OsTurn;
      _checkWinner();
    });
  }

  void _checkWinner() {
    //checking for the first row in the grid
    if (displayEx0h[0] == displayEx0h[1] &&
        displayEx0h[0] == displayEx0h[2] &&
        displayEx0h[0] != '') {
      _showWinDialog(displayEx0h[0]);
    }
    //checking for the second row in the grid
    if (displayEx0h[3] == displayEx0h[4] &&
        displayEx0h[3] == displayEx0h[5] &&
        displayEx0h[3] != '') {
      _showWinDialog(displayEx0h[3]);
    }
    //checking for the third row in the grid
    if (displayEx0h[6] == displayEx0h[7] &&
        displayEx0h[6] == displayEx0h[8] &&
        displayEx0h[6] != '') {
      _showWinDialog(displayEx0h[6]);
    }
    //checking for the first column in the grid
    if (displayEx0h[0] == displayEx0h[3] &&
        displayEx0h[0] == displayEx0h[6] &&
        displayEx0h[0] != '') {
      _showWinDialog(displayEx0h[0]);
    }
    //checking for the second column in the grid
    if (displayEx0h[1] == displayEx0h[4] &&
        displayEx0h[1] == displayEx0h[7] &&
        displayEx0h[1] != '') {
      _showWinDialog(displayEx0h[1]);
    }
    //checking for the third column in the grid
    if (displayEx0h[2] == displayEx0h[5] &&
        displayEx0h[2] == displayEx0h[8] &&
        displayEx0h[2] != '') {
      _showWinDialog(displayEx0h[2]);
    }
    //checking the first diagonal from bottom left to top right
    if (displayEx0h[6] == displayEx0h[4] &&
        displayEx0h[6] == displayEx0h[2] &&
        displayEx0h[6] != '') {
      _showWinDialog(displayEx0h[6]);
    }
    //checking the second diagonal from top right to bottom left
    if (displayEx0h[0] == displayEx0h[4] &&
        displayEx0h[0] == displayEx0h[8] &&
        displayEx0h[0] != '') {
      _showWinDialog(displayEx0h[0]);
    } else if (filledBoxes == 9) {
      _showDrawDialog();
    }
  }

  void _showDrawDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Draw'),
          actions: [
            TextButton(
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                },
                child: Text("play Again"))
          ],
        );
      },
    );
  }

  void _showWinDialog(String winner) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('WINNER IS: ' + winner),
          actions: [
            TextButton(
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                },
                child: Text("play Again"))
          ],
        );
      },
    );

    if (winner == 'o') {
      scoreforO += 1;
    } else if (winner == 'x') {
      scoreforX += 1;
    }
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayEx0h[i] = '';
      }
    });
  }
}
