import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictactoe/screens/one_player.dart';
import 'package:flutter/services.dart';

final kBoxDecorationStyle = BoxDecoration(
  color: Color(0xFF6CA8F1),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

class DifficultyScreen extends StatefulWidget {
  @override
  _DifficultyScreenState createState() => _DifficultyScreenState();
}

class _DifficultyScreenState extends State<DifficultyScreen>
    with SingleTickerProviderStateMixin {
  Widget _buildBtn(String text) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 25.0),
        width: double.infinity,
        child: RaisedButton(
          elevation: 5.0,
          onPressed: () => text == 'Easy'
              ? {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                          transitionDuration: Duration(milliseconds: 500),
                          transitionsBuilder:
                              (context, animation, animationTime, child) {
                            return ScaleTransition(
                              alignment: Alignment.center,
                              scale: animation,
                              child: child,
                            );
                          },
                          pageBuilder: (context, animation, animationTime) {
                            return OnePlayer(true);
                          }))
                }
              : Navigator.push(
                  context,
                  PageRouteBuilder(
                      transitionDuration: Duration(milliseconds: 500),
                      transitionsBuilder:
                          (context, animation, animationTime, child) {
                        return ScaleTransition(
                          alignment: Alignment.center,
                          scale: animation,
                          child: child,
                        );
                      },
                      pageBuilder: (context, animation, animationTime) {
                        return OnePlayer(false);
                      })),
          padding: EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          color: Colors.white,
          child: Text(
            text,
            style: GoogleFonts.pressStart2P(
                textStyle: TextStyle(
                    color: Color(0xFF527DAA),
                    fontSize: 18,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.bold)),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
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
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 40.0,
                  vertical: 70.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'One Player',
                      style: GoogleFonts.pressStart2P(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold)),
                    ),
                    _buildBtn('Easy'),
                    _buildBtn('Hard'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
