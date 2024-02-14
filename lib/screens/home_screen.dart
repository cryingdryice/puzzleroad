import 'package:flutter/material.dart';

import 'stages_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      body: Center(
        // start버튼
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const StagesScreen(),
                  fullscreenDialog: false),
            );
          },
          child: Container(
            height: 200,
            width: 300,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
              color: Colors.black,
            ),
            child: const Center(
              child: Text(
                "START",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
