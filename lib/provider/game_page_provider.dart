import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class GamePageProvider extends ChangeNotifier {
  int _currentQuestionCount = 0;
  final int _maxQuestion = 10;
  List? questions;
  final Dio _dio = Dio();
  BuildContext context;
  GamePageProvider({required this.context}) {
    _dio.options.baseUrl = 'https://opentdb.com/api.php';
    _getQuestionFromApi();
  }
  Future<void> _getQuestionFromApi() async {
    var response = await _dio.get(
      '',
      queryParameters: {
        'amount': 10,
        'type': 'boolean',
        'difficulty': 'easy',
      },
    );
    var data = jsonDecode(response.toString());
    questions = data['results'];
    notifyListeners();
  }

  String getCurrentQuestionText() {
    return questions![_currentQuestionCount]['question'];
  }

  void answerQuestion(String answer) async {
    bool isCorrect =
        questions![_currentQuestionCount]["correct_answer"] == answer;
    _currentQuestionCount++;
    showDialog(
        context: context,
        builder: (BuildContext _context) {
          return AlertDialog(
            backgroundColor: isCorrect ? Colors.green : Colors.red,
            title: Icon(
              isCorrect ? Icons.check_circle_rounded : Icons.cancel_sharp,
              color: Colors.white,
            ),
          );
        });
    await Future.delayed(const Duration(seconds: 2));

    Navigator.pop(context);
    if (_currentQuestionCount == _maxQuestion) {
      endGame();
    } else {
      notifyListeners();
    }
  }

  Future<void> endGame() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            backgroundColor: Colors.blue,
            title: Text(
              "End of Game!",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            content: Text(
              "Score: 0/0",
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
              ),
            ));
      },
    );
    await Future.delayed(
      Duration(seconds: 3),
    );
    Navigator.pop(context);
    Navigator.pop(context);
  }
}
