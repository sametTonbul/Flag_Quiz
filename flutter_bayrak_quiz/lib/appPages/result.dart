import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ResultPage extends StatefulWidget {
  int trueAnswers;

  // ignore: use_key_in_widget_constructors
  ResultPage(this.trueAnswers);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('RESULT QUIZ')),
      body: SizedBox(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                  '${widget.trueAnswers} TRUE ${5 - widget.trueAnswers} FALSE',
                  style: const TextStyle(fontSize: 30)),
              Text(
                  '% ${((widget.trueAnswers) * 100 / 5).toInt()} SUCCESS RATE',
                  style: const TextStyle(fontSize: 30, color: Colors.pink)),
              SizedBox(
                  height: 50,
                  width: 250,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('TRY AGAIN')))
            ],
          ),
        ),
      ),
    );
  }
}
