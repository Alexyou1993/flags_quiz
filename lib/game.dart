import 'dart:async';
import 'dart:math';
import 'package:flags_quiz/results.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: GamePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class GamePage extends StatefulWidget {
  const GamePage({
    Key key,
  }) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  bool isLoading = false;
  final List<String> countriesName = <String>[];
  final List<String> listOfFlags = <String>[];
  List<String> listAns = <String>[];
  String flag, correctAns, randomAns, randomAns1, randomAns2;
  double indexT = 1.0;
  Timer timer;
  int ans1,
      ans2,
      ans3,
      ans4,
      point = 0,
      incorrectAns = 0,
      countAns = -1,
      random;

  @override
  void initState() {
    super.initState();
    _getFlags();
    timer = Timer.periodic(const Duration(seconds: 1), _onDone);
  }

  void _onDone(Timer timer) {
    if (mounted) {
      if (indexT == 60.0) {
        timer.cancel();
        indexT = 0.0;
        Navigator.push<GamePage>(
          context,
          MaterialPageRoute<GamePage>(
            builder: (BuildContext context) => ResultsPage(
              point: point,
              incorrectAns: incorrectAns,
              countAns: countAns,
            ),
          ),
        );
      }
      if (indexT < 60.0) {
        setState(() => indexT++);
      }
    } else {
      timer.cancel();
    }
  }

  Future<void> _getFlags() async {
    setState(() => isLoading = true);

    final Response response = await get(
        'https://www.worldometers.info/geography/flags-of-the-world/');
    final List<String> flags = response.body
        .split('<div align="center" style="margin-top:10px "><a href="')
        .skip(1)
        .toList();

    for (final String item in flags) {
      countriesName.add(
          item.split('padding-top:10px">')[1].split('</div></div></div>')[0]);
      listOfFlags
          .add('https://www.worldometers.info${item.split('.gif')[0]}.gif');
    }
    _setValuesRandom();
    setState(() => isLoading = false);
  }

  void _setValuesRandom() {
    setState(
      () {
        listAns = <String>[];
        random = Random().nextInt(listOfFlags.length);
        countAns++;
        flag = listOfFlags[random];
        correctAns = countriesName[random];
        randomAns = countriesName[Random().nextInt(countriesName.length)];
        randomAns1 = countriesName[Random().nextInt(countriesName.length)];
        randomAns2 = countriesName[Random().nextInt(countriesName.length)];
        listAns.add(correctAns);
        listAns.add(randomAns);
        listAns.add(randomAns1);
        listAns.add(randomAns2);
        ans1 = Random().nextInt(listAns.length);
        ans2 = Random().nextInt(listAns.length);
        ans3 = Random().nextInt(listAns.length);
        ans4 = Random().nextInt(listAns.length);
      },
    );
    do {
      ans2 = Random().nextInt(listAns.length);
    } while (ans2 == ans1 || ans2 == ans3 || ans2 == ans4);

    do {
      ans3 = Random().nextInt(listAns.length);
    } while (ans3 == ans1 || ans3 == ans2 || ans3 == ans4);

    do {
      ans4 = Random().nextInt(listAns.length);
    } while (ans4 == ans1 || ans4 == ans2 || ans4 == ans3);
  }

  void _points(String value) {
    if (value == correctAns) {
      setState(() => point++);
    } else {
      setState(() => incorrectAns++);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (listOfFlags.isEmpty && countriesName.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      backgroundColor: Colors.cyan,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Slider(
            value: indexT,
            min: 1.0,
            max: 60.0,
            onChanged: (double value) => setState(() => indexT = value),
          ),
          Image.network(flag),
          FlatButton(
            child: Text(
              listAns[ans1],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              _points(listAns[ans1]);
              _setValuesRandom();
            },
          ),
          FlatButton(
            child: Text(
              listAns[ans2],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              _points(listAns[ans2]);
              _setValuesRandom();
            },
          ),
          FlatButton(
            child: Text(
              listAns[ans3],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              _points(listAns[ans3]);
              _setValuesRandom();
            },
          ),
          FlatButton(
            child: Text(
              listAns[ans4],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              _points(listAns[ans4]);
              _setValuesRandom();
            },
          ),
        ],
      ),
    );
  }
}
