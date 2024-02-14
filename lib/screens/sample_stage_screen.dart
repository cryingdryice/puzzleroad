import 'package:flutter/material.dart';
import 'package:puzzleroad/screens/stages/1_poison_and_cup.dart';

class SampleStageScreen extends StatelessWidget {
  final int stageIndex;

  const SampleStageScreen({super.key, required this.stageIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 세 구역 나누기 중간은 살짝 넓게
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.blue,
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.green,
              child: const PosionAndCup(),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
