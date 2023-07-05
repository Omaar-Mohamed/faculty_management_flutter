import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class QuizQuestion {
  final String question;
   Map<String,dynamic> choices;
  final String correctChoice;

  QuizQuestion({
    required this.question,
    required this.choices,
    required this.correctChoice,
  });
}


class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  // TODO: Replace with actual quiz data
  final List<QuizQuestion> _quizQuestions = [
    QuizQuestion(
      question: 'What is the capital of France?',
      choices: {
        'Paris':1,
        'London':2,
        'Berlin':3,
        'Madrid':4
      },
      correctChoice: 'Paris',
    ),
    QuizQuestion(
      question: 'What is the highest mountain in the world?',
      choices: {
        'Everest':1,
        'K2':2,
        'Kilimanjaro':3,
        'Denali':4
      },
      correctChoice: 'Everest',
    ),
    QuizQuestion(
      question: 'What is the largest country in the world by area?',
      choices: {
        'Russia': 1,
        'Canada': 2,
        'China': 3,
        'United States': 4
      },
      correctChoice: 'Russia',
    ),
    QuizQuestion(
      question: 'What is the largest ocean in the world?',
      choices: {
        'Pacific':1,
        'Atlantic':2,
        'Indian':3,
        'Arctic':4
      },
      correctChoice: 'Pacific',
    ),
    QuizQuestion(
      question: 'What is the smallest country in the world?',
      choices: {
        'Vatican City':1,
        'Monaco':2,
        'Nauru':3,
       'Tuvalu':4
      },
      correctChoice: 'Vatican City',
    ),
  ];

  int _currentQuestionIndex = 0;
  int _remainingTime = 30; // in seconds
  Timer ?_timer;
  bool selected=false;
  int _selectedChoiceIndex= -1;


  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
    Fluttertoast.showToast(
        msg: "Quiz disposed",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
    print('Quiz disposed');
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          _timer?.cancel();
          Fluttertoast.showToast(
              msg: "Time is up!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }
      });
    });
  }

  void _nextQuestion() {
    setState(() {
      _currentQuestionIndex++;
      // _remainingTime = 50;
      _selectedChoiceIndex=-1;
      // if(_remainingTime==0){
      //   _currentQuestionIndex++;
      // }
    });
  }

  void _previousQuestion() {
    setState(() {
      _currentQuestionIndex--;


    });
  }

  void _selectedChice()
  {
    setState(() {
      // selected=true;

    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Name'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Time Left: $_remainingTime seconds'),
                  Text('Question ${_currentQuestionIndex + 1} of ${_quizQuestions.length}'),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Card(
                  elevation: 4.0,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          _quizQuestions[_currentQuestionIndex].question,
                          style: TextStyle(fontSize: 20.0),
                        ),
                        ..._quizQuestions[_currentQuestionIndex]
                            .choices.entries
                            .map((entry) => Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            child: ElevatedButton(
                              onPressed: ()
                              {
                                setState(() {

                                  _selectedChoiceIndex=entry.value;
                                });
                                // if(choice == _quizQuestions[_currentQuestionIndex].correctChoice)
                                // {
                                //   Fluttertoast.showToast(
                                //     msg: "Correct Answer!",
                                //     toastLength: Toast.LENGTH_SHORT,
                                //     gravity: ToastGravity.BOTTOM,
                                //     timeInSecForIosWeb: 1,
                                //     backgroundColor: Colors.green,
                                //     textColor: Colors.white,
                                //     fontSize: 16.0
                                //   );
                                // }
                                // else
                                // {
                                //   Fluttertoast.showToast(
                                //     msg: "Wrong Answer!",
                                //     toastLength: Toast.LENGTH_SHORT,
                                //     gravity: ToastGravity.BOTTOM,
                                //     timeInSecForIosWeb: 1,
                                //     backgroundColor: Colors.red,
                                //     textColor: Colors.white,
                                //     fontSize: 16.0
                                //   );
                                // }
                                if(selected==false)
                                  {
                                    setState(() {
                                      selected=true;
                                      print('entry.key: ${entry.key}');
                                      entry.value==selected;

                                    });
                                  }
                                else
                                  {
                                    setState(() {
                                      selected=false;
                                      entry.value==selected;
                                    });
                                  }
                              },

                              child: Text(entry.key),
                              style: ElevatedButton.styleFrom(
                                // primary: selected==true?choice == _quizQuestions[_currentQuestionIndex].correctChoice?Colors.green:Colors.red:Colors.blue,
                                // primary:selected==true?Colors.blueGrey:Colors.blue,
                                // primary: selected==true?entry.key == _quizQuestions[_currentQuestionIndex].correctChoice?Colors.green:Colors.red:Colors.blue,
                                // primary: selected==true?entry.value == _quizQuestions[_currentQuestionIndex].correctChoice?Colors.green:Colors.red:Colors.blue,
                                // primary: selected==true?entry.key == _quizQuestions[_currentQuestionIndex].correctChoice?Colors.green:Colors.red:Colors.blue,
                                // primary: entry.value==true?Colors.green:Colors.blue,
                                // prprimary: selected==true?entry.value == _quizQuestions[_currentQuestionIndex].correctChoice?Colors.green:Colors.red:Colors.blue,
                                primary: _selectedChoiceIndex==entry.value?Colors.blueGrey:Colors.blue,
                              ),
                            ),
                          ),
                        ))
                            .toList(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: _currentQuestionIndex == 0
                        ? null
                        : _previousQuestion,
                    child: Text('Previous'),
                  ),
                  ElevatedButton(
                    onPressed: _currentQuestionIndex == _quizQuestions.length - 1
                        ? null
                        : _nextQuestion,
                    child: Text('Next'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
