import 'package:flutter/material.dart';
import 'package:puzzleroad/screens/sample_stage_screen.dart';

class StagesScreen extends StatelessWidget {
  const StagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:
              MediaQuery.of(context).size.width ~/ 200, // 열의 수를 화면 폭에 따라 조정
        ),
        itemCount: 20, // 아이템 개수
        itemBuilder: (context, index) {
          return Center(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          SampleStageScreen(stageIndex: index),
                      fullscreenDialog: false),
                );
              },
              child: Container(
                width: 150,
                height: 150,
                color: Colors.blue,
                child: Center(
                  child: Text(
                    '박스 $index',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
