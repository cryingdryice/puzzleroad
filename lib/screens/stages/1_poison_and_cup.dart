import 'dart:math';

import 'package:flutter/material.dart';

class PosionAndCup extends StatefulWidget {
  const PosionAndCup({super.key});

  @override
  State<PosionAndCup> createState() => _PosionAndCupState();
}

class _PosionAndCupState extends State<PosionAndCup> {
  //late List<Cup> cupList;
  late List<bool> cupfilled;
  final List<Color> colors = [
    Colors.grey,
    Colors.yellow,
  ];

  bool isMyTurn = true;
  int myCupClicked = 0;
  int yrCupClicked = 0;
  int gameStatus = 0; // 0이면 진행중, 1이면 패배, 2이면 승리
  int cupCount = 30;
  Random random = Random();

  @override
  void initState() {
    super.initState();
    setCupFilledList();
  }

  // 처음엔 모두 차있음
  void setCupFilledList() {
    cupfilled = List.generate(30, (index) => true);
  }

  void enemyTurn() {
    // true인 항목의 인덱스를 추출
    List<int> trueIndices = [];
    for (int i = 0; i < cupfilled.length; i++) {
      if (cupfilled[i]) {
        trueIndices.add(i);
      }
    }
    int numToDrink = 0;
    int delay = 0;

    // 만약 true인 항목이 없다면 종료 메시지 출력
    if (trueIndices.isEmpty) {
      print("이겼습니다!");
      return;
    }

    if (cupCount % 4 == 0) {
      numToDrink = Random().nextInt(3) + 1;
    } else {
      numToDrink = (cupCount % 4);
    }

    // 선택된 개수보다 남아있는 수가 더 많다면 나머지로 조정
    if (cupCount < 4) {
      numToDrink = cupCount;
    }

    //if (cupCount == 29) numToDrink = 1;

    List<int> selectedIndices = [];
    while (selectedIndices.length < numToDrink) {
      int randomIndex = Random().nextInt(trueIndices.length);
      if (!selectedIndices.contains(randomIndex)) {
        selectedIndices.add(randomIndex);
        Future.delayed(Duration(seconds: delay++), () {
          setState(() {
            cupfilled[trueIndices[randomIndex]] = false;
            yrCupClicked++;
            cupCount--;
          });
        });
      }
    }

    // 상대방 턴이 끝나면 다시 내 턴으로 변경
    Future.delayed(Duration(seconds: delay), () {
      setState(() {
        isMyTurn = true;
        yrCupClicked = 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 세 구역 나누기 중간은 살짝 넓게
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                      color: Colors.brown,
                      // 마신 컵 체크
                      child: drinkCheck(myCupClicked)),
                ),
                Expanded(
                  child: Container(
                    color: Colors.blueAccent,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      padding: const EdgeInsets.all(2.0),
                      child: cupBoard(),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                      color: Colors.greenAccent,
                      child: Center(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Container(
                                width: 80,
                                height: 80,
                                color: Colors.green,
                                child: Center(
                                  child: Text(
                                    "POSION $cupCount",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            // 턴 넘기기 버튼
                            Visibility(
                              visible: (isMyTurn && myCupClicked >= 1),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    myCupClicked = 0;
                                    isMyTurn = !isMyTurn;
                                  });
                                  enemyTurn();
                                },
                                child: Container(
                                  width: 200,
                                  height: 60,
                                  color: Colors.cyan,
                                  child: const Center(
                                    child: Text(
                                      "TurnChange",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.brown,
                    child: drinkCheck(yrCupClicked),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget cupBoard() {
    late List<Widget> cupList = [];
    for (int i = 0; i < 30; i++) {
      cupList.add(cupWidget(isMyTurn, cupfilled[i], i));
    }

    return GridView.count(
      crossAxisCount: 6, // 가로로 6개의 셀
      children: cupList,
    );
  }

  Widget cupWidget(bool isMyT, bool isfilled, int cupIdx) {
    return AbsorbPointer(
      absorbing: !isMyT || myCupClicked >= 3 || !isfilled,
      child: GestureDetector(
        onTap: () {
          // 클릭 시 콜백 함수 호출
          setState(() {
            // 클릭 시 filled 변수를 false로 변경
            myCupClicked++;
            cupCount--;
            cupfilled[cupIdx] = false;
          });
        },
        child: Container(
          margin: const EdgeInsets.all(5), // 박스 간격 조정
          color: isfilled ? Colors.blue : Colors.grey, // filled 변수에 따라 색상 변경
          child: const Center(
            child: Text(
              'Cup',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget drinkCheck(int isCupClicked) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          height: 50,
          width: 50,
          color: isCupClicked >= 1 ? colors[1] : colors[0],
        ),
        Container(
          height: 50,
          width: 50,
          color: isCupClicked >= 2 ? colors[1] : colors[0],
        ),
        Container(
          height: 50,
          width: 50,
          color: isCupClicked >= 3 ? colors[1] : colors[0],
        ),
      ],
    );
  }
}
