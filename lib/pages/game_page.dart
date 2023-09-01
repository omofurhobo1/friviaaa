import 'package:flutter/material.dart';
import 'package:friviaaa/provider/game_page_provider.dart';
import 'package:provider/provider.dart';

class GamePage extends StatelessWidget {
  double? _deviceHeight, _deviceWidth;
  GamePageProvider? _pageProvider;

  GamePage({super.key});
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    // TODO: implement build
    return ChangeNotifierProvider(
      create: (context) => GamePageProvider(context: context),
      child: Builder(builder: (context) {
        _pageProvider = context.watch<GamePageProvider>();
        if (_pageProvider!.questions != null) {
          return Scaffold(
            body: SafeArea(
              child: _buildUI(),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        }
      }),
    );
  }

  Widget _buildUI() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.05),
      child: _gameUI(),
    );
  }

  Widget _gameUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        _question(),
        Center(
          child: Column(
            children: [
              _trueButton(),
              SizedBox(
                height: _deviceHeight! * 0.01,
              ),
              _falseButton(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _question() {
    return Text(
      _pageProvider!.getCurrentQuestionText(),
      style: const TextStyle(
        color: Colors.white,
        fontSize: 25,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _trueButton() {
    return MaterialButton(
      onPressed: () {
        _pageProvider!.answerQuestion("True");
      },
      color: Colors.green,
      minWidth: _deviceWidth! * 0.8,
      height: _deviceHeight! * 0.10,
      child: const Text(
        "true",
        style: TextStyle(
          fontSize: 25,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _falseButton() {
    return MaterialButton(
      onPressed: () {
        _pageProvider!.answerQuestion("False");
      },
      color: Colors.red,
      minWidth: _deviceWidth! * 0.8,
      height: _deviceHeight! * 0.10,
      child: const Text(
        "false",
        style: TextStyle(
          fontSize: 25,
          color: Colors.white,
        ),
      ),
    );
  }
}
