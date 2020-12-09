import 'package:flutter/material.dart';
import 'game.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.cyan,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 80.0),
                  child: Container(
                    child: const Text(
                      'Flags Quiz',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  decoration:
                      BoxDecoration(border: Border.all(width: 16.0), shape: BoxShape.rectangle, color: Colors.white),
                  child: Image.asset(
                    './assets/images/flags.png',
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 80.0),
                  child: Container(
                    child: const Text(
                      "@Iura's\nPlayGround",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push<GamePage>(
                    context,
                    MaterialPageRoute<GamePage>(builder: (BuildContext context) => const GamePage()),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40, bottom: 60),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.all(30),
                      color: Colors.black45,
                      child: const Center(
                        child: Text(
                          'PLAY GAME',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
