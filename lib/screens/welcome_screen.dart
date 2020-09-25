import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/services.dart';
import 'difficulty.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictactoe/screens/two_player.dart';

final kHintTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

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

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = new AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    animation = new Tween(begin: 0.0, end: 200.0).animate(controller);
    animation.addListener(() {
      setState(() {
        //The state of the animation has changed
      });
    });

    controller.forward();
  }

  Widget _buildBtn(String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () => text == '2-Players'
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
                          return TwoPlayer();
                        }))
              }
            :
            {
              Navigator.push(
                  context,
                  PageRouteBuilder(
                      transitionDuration: Duration(milliseconds: 500),
                      transitionsBuilder:
                          (context, animation, animationTime, child) {
                        return SlideTransition(
                          position: Tween(begin: Offset(1.0, 0.0), end: Offset.zero).animate(CurvedAnimation(
                            parent: animation,
                            curve: Curves.ease,
                          )),
                          child: child,
                        );
                      },
                      pageBuilder: (context, animation, animationTime) {
                        return DifficultyScreen();
                      }))
            },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(text,
            style: GoogleFonts.pressStart2P(
                textStyle: TextStyle(
                    color: Color(0xFF527DAA),
                    fontSize: 16,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.bold))),
      ),
    );
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
                height: double.infinity,
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 70.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Tic Tac Toe',
                        style: GoogleFonts.pressStart2P(
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                letterSpacing: 1.5,
                                fontWeight: FontWeight.bold)),
                      ),
                      new Container(
                        padding: new EdgeInsets.all(32.0),
                        height: animation.value,
                        width: animation.value,
                        child: new Center(
                          child: new Image(
                              image: new AssetImage('images/TTTWelcome.png')),
                        ),
                      ),
                      _buildBtn('1-Player'),
                      _buildBtn('2-Players'),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
