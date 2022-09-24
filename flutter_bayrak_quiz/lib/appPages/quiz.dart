import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_bayrak_quiz/appPages/flagDAO.dart';
import 'package:flutter_bayrak_quiz/appPages/flags.dart';
import 'package:flutter_bayrak_quiz/appPages/result.dart';

class QuizPage extends StatefulWidget {
  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  var questions =
      <Flags>[]; // All Questions will be in Flags about country flags
  var wrongOptions =
      <Flags>[]; // Wrong options will be in Flags about country flags
  Flags? trueQuestion;  
  var allOptions =
      HashSet<Flags>(); // For Random Flags to Get via HashSet Method
 

  int questionCounter = 0; // Default Parameter
  int trueAnswerCounter = 0; // Default Parameter
  int wrongAnswerCounter = 0; // Default Parameter

  String flagPictureName = 'restart.png'; // Default picture
  String buttonAText = ''; // Default Text
  String buttonBText = ''; // Default Text
  String buttonCText = ''; // Default Text
  String buttonDText = ''; // Default Text

  @override
  void initState() {
    super.initState();
    takeQuestions();
  }

  Future<void> takeQuestions() async {
    questions = await FlagsDAO.randomShow5Flag();
    loadQuestions();
  }

  Future<void> loadQuestions() async {
    trueQuestion = questions[questionCounter];
    flagPictureName = trueQuestion!.flag_pictures;
    wrongOptions = await FlagsDAO().randomShow3WrongFlag(trueQuestion!.flag_id);
    allOptions.clear();
    allOptions.add(trueQuestion!);
    allOptions.add(wrongOptions[0]);
    allOptions.add(wrongOptions[1]);
    allOptions.add(wrongOptions[2]);
    buttonAText = allOptions.elementAt(0).flag_name;
    buttonBText = allOptions.elementAt(1).flag_name;
    buttonCText = allOptions.elementAt(2).flag_name;
    buttonDText = allOptions.elementAt(3).flag_name;
    setState(() {});
  }

  void questionCounterControl() {
    questionCounter = questionCounter + 1;
    if (questionCounter != 5) {
      loadQuestions();
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ResultPage(
             trueAnswerCounter,
            ),
          ));
    }
  }

  void trueControl(String buttonText) {
    if (trueQuestion!.flag_name == buttonText) {
      trueAnswerCounter = trueAnswerCounter + 1;
    } else {
      wrongAnswerCounter = wrongAnswerCounter + 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('QUIZ PROCESS')),
      body: SizedBox(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('True : $trueAnswerCounter ',
                      style: const TextStyle(fontSize: 18)),
                  Text('False : $wrongAnswerCounter ',
                      style: const TextStyle(fontSize: 18)),
                ],
              ),
              questionCounter != 5
                  ? Text('${questionCounter + 1}.Question',
                      style: const TextStyle(fontSize: 16))
                  : const Text('5.Question'),
              SizedBox(
                  height: 256,
                  width: 256,
                  child: Image.asset('lib/flagpictures/$flagPictureName')),
              SizedBox(
                height: 50,
                width: 250,
                child: ElevatedButton(
                    onPressed: () {
                      trueControl(buttonAText);
                      questionCounterControl();
                    },
                    child: Text(buttonAText)),
              ),
              SizedBox(
                height: 50,
                width: 250,
                child: ElevatedButton(
                    onPressed: () {
                      trueControl(buttonBText);
                      questionCounterControl();
                    },
                    child: Text(buttonBText)),
              ),
              SizedBox(
                height: 50,
                width: 250,
                child: ElevatedButton(
                    onPressed: () {
                      trueControl(buttonCText);
                      questionCounterControl();
                    },
                    child: Text(buttonCText)),
              ),
              SizedBox(
                height: 50,
                width: 250,
                child: ElevatedButton(
                    onPressed: () {
                      trueControl(buttonDText);
                      questionCounterControl();
                    },
                    child: Text(buttonDText)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
