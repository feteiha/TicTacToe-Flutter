import 'package:flutter/material.dart';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';

class OnePlayer extends StatefulWidget {
  @override
  _OnePlayer createState() => _OnePlayer();
}

class _OnePlayer extends State<OnePlayer> {
  int yourWins = 0;
  int pcWins = 0;
  bool _cantap = true;

  List<String> _matrix = ['', '', '', '', '', '', '', '', ''];
  Future<void> _tapped(int index) async {
    if (!_cantap) return;
    if (_matrix[index] != '') return;
    setState(() {
      _matrix[index] = 'x';
    });
    bool isFinishd = checkWinner('x');
    if (isFinishd) {
      _showWinDialog("x");
      yourWins++;
    } else {
      bool isDraw = checkDraw();
      if (isDraw) {
        _showDrawDialog();
        return;
      }
      setState(() {
        _cantap = false;
      });
      await Future.delayed(Duration(milliseconds: 500));
      _oturn();
      setState(() {
        _cantap = true;
      });

      isFinishd = checkWinner('o');
      if (isFinishd) {
        _showWinDialog("o");
        pcWins++;
      }
    }
  }

  void _oturn() {
    var rng = new Random();
    int choice = rng.nextInt(9);
     bool inserted = false;
    while (!inserted) {
      if (_matrix[choice] == '') {
        setState(() {
          _matrix[choice] = 'o';
        });
        inserted = true;
      } else {
        choice = rng.nextInt(9);
      }
    }
  }

  bool checkWinner(String player) {
    if ((_matrix[0] == player &&
            _matrix[1] == player &&
            _matrix[2] == player) ||
        (_matrix[3] == player &&
            _matrix[4] == player &&
            _matrix[5] == player) ||
        (_matrix[6] == player &&
            _matrix[7] == player &&
            _matrix[8] == player) ||
        (_matrix[0] == player &&
            _matrix[3] == player &&
            _matrix[6] == player) ||
        (_matrix[1] == player &&
            _matrix[4] == player &&
            _matrix[7] == player) ||
        (_matrix[2] == player &&
            _matrix[5] == player &&
            _matrix[8] == player) ||
        (_matrix[0] == player &&
            _matrix[4] == player &&
            _matrix[8] == player) ||
        (_matrix[2] == player &&
            _matrix[4] == player &&
            _matrix[6] == player)) {
      return true;
    }
    return false;
  }

  bool checkDraw() {
    for (int i = 0; i < 9; i++) {
      if (_matrix[i] == '') return false;
    }
    return true;
  }

  void _showWinDialog(String winner) {
    String text = '';
    if (winner == 'x') {
      text = "YOU WIN!";
    } else {
      text = "YOU LOSE!";
    }
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(text),
            actions: <Widget>[
              FlatButton(
                child: Text('Play Again!'),
                onPressed: () {
                  setState(() {
                    _matrix = ['', '', '', '', '', '', '', '', ''];
                  });
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void _showDrawDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('DRAW!'),
            actions: <Widget>[
              FlatButton(
                child: Text('Play Again!'),
                onPressed: () {
                  setState(() {
                    _matrix = ['', '', '', '', '', '', '', '', ''];
                  });
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  bool movesLeft(List<String> board) {
    for (int i = 0; i < 9; i++) {
      if (board[i] == '') return true;
    }
    return false;
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
      Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF73AEF5),
              Color(0xFF61A4F1),
              Color(0xFF478DE0),
              Color(0xFF398AE5),
            ],
            stops: [0.1, 0.4, 0.7, 0.9],
          ),
        ),
      ),
      Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Your score',
                          style: GoogleFonts.pressStart2P(
                            textStyle:
                                TextStyle(color: Colors.white, fontSize: 12),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        yourWins.toString(),
                        style: GoogleFonts.pressStart2P(
                          textStyle:
                              TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('PC score',
                          style: GoogleFonts.pressStart2P(
                            textStyle:
                                TextStyle(color: Colors.white, fontSize: 12),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Text(pcWins.toString(),
                          style: GoogleFonts.pressStart2P(
                            textStyle:
                                TextStyle(color: Colors.white, fontSize: 12),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: GridView.builder(
                itemCount: 9,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      _tapped(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white60)),
                      child: Center(
                        child: Text(
                          _matrix[index],
                          style: TextStyle(color: Colors.white, fontSize: 42),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Expanded(
              child: Container(
                  child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'By: Hussien 😅💃',
                style: TextStyle(color: Colors.white38),
              ),
            ],
          ))),
        ],
      )
    ]));
  }
}
