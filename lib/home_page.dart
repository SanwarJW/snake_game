import 'dart:async';

import 'package:flutter/material.dart';
import 'package:snake_game/blank_pixel.dart';
import 'package:snake_game/food_pixel.dart';
import 'package:snake_game/snake_pixel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int rowSize = 10;
  int totalNumberOfSquire = 100;

  List<int> snakePos = [0, 1, 2];
  int foodPixel = 55;

  startGame() {
    Timer.periodic(Duration(milliseconds: 200), (timer) {
      setState(() {
        snakePos.add(snakePos.last + 1);

        snakePos.remove(snakePos[0]);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Column(
        children: [
          Expanded(child: Container()),
          Expanded(
            flex: 3,
            child: GestureDetector(
              onHorizontalDragUpdate: (details) {
                if (details.delta.dx > 0) {
                  print('Move right');
                } else if (details.delta.dx < 0) {
                  print('Move left');
                }
              },
              onVerticalDragUpdate: (details) {
                if (details.delta.dy > 0) {
                  print('Move down');
                } else if (details.delta.dy < 0) {
                  print('Move up');
                }
              },
              child: GridView.builder(
                itemCount: totalNumberOfSquire,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: rowSize,
                ),
                itemBuilder: (context, index) {
                  if (snakePos.contains(index)) {
                    return const SnakePixel();
                  } else if (foodPixel == index) {
                    return const FoodPixel();
                  } else {
                    return const BlankPixel();
                  }
                },
              ),
            ),
          ),
          Expanded(
              child: Container(
            child: Center(
              child: ElevatedButton(
                  onPressed: () {
                    startGame();
                  },
                  child: const Text('Play Game')),
            ),
          )),
        ],
      ),
    );
  }
}
