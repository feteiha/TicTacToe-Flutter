import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TwoPlayer extends StatefulWidget {
  @override
  _TwoPlayer createState() => _TwoPlayer();
}

class _TwoPlayer extends State<TwoPlayer> {
  int xWins = 0;
  int oWins = 0;
  bool xTurn = true;

  List<String> _matrix = ['', '', '', '', '', '', '', '', ''];

  _tapped(int index){
    String play;
    if (_matrix[index] != '') return;
    if (xTurn){
      play = 'x';
    }
    else{
      play = 'o';
    }
    xTurn = !xTurn;
    setState(() {
      _matrix[index] = play;
    });
    bool isFinishd = checkWinner(play);
    if (isFinishd) {
      _showWinDialog(play);
      if (play == 'x'){
        xWins++;
      }
      else{
        oWins++;
      }
    } else {
      bool isDraw = checkDraw();
      if (isDraw) {
        _showDrawDialog();
        return;
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
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Congratulations! Player $winner won!"),
            actions: <Widget>[
              FlatButton(
                child: Text('Play Again!'),
                onPressed: () {
                  setState(() {
                    _matrix = ['', '', '', '', '', '', '', '', ''];
                    xTurn = true;
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
                    xTurn = true;
                  });
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xFF478DE0),
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
                          Text('X Score',
                              style: GoogleFonts.pressStart2P(
                                textStyle:
                                TextStyle(color: Colors.white, fontSize: 12),
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            xWins.toString(),
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
                          Text('O Score',
                              style: GoogleFonts.pressStart2P(
                                textStyle:
                                TextStyle(color: Colors.white, fontSize: 12),
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          Text(oWins.toString(),
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
              Expanded(child: Container(
                  child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('By: Hussien 😅💃', style: TextStyle(color: Colors.white38),),
                    ],
                  )
              )),
            ],
          )
        ]));
  }
}
