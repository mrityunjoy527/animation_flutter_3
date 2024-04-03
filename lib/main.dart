import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  late AnimationController _xController;
  late AnimationController _yController;
  late AnimationController _zController;
  late Tween<double> _animation;

  @override
  void initState() {
    super.initState();
    _xController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );
    _yController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    );
    _zController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    );
    _animation = Tween<double>(begin: 0, end: pi * 2);
  }

  @override
  void dispose() {
    _xController.dispose();
    _yController.dispose();
    _zController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    _xController.repeat();
    _yController.repeat();
    _zController.repeat();

    const heightAndWidth = 180.0;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                    animation: Listenable.merge([
                      _xController,
                      _yController,
                      _zController,
                    ]),
                    builder: (context, child) {
                      return Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..rotateX(_animation.evaluate(_xController))
                          ..rotateY(_animation.evaluate(_yController))
                          ..rotateZ(_animation.evaluate(_zController)),
                        child: Stack(
                          children: [
                            Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.identity()
                                ..translate(
                                  Vector3(0.0, 0.0, -heightAndWidth),
                                ),
                              child: Container(
                                width: heightAndWidth,
                                height: heightAndWidth,
                                color: Colors.green,
                              ),
                            ),
                            Container(
                              width: heightAndWidth,
                              height: heightAndWidth,
                              color: Colors.red,
                            ),
                            Transform(
                              alignment: Alignment.topCenter,
                              transform: Matrix4.identity()..rotateX(-pi / 2),
                              child: Container(
                                width: heightAndWidth,
                                height: heightAndWidth,
                                color: Colors.brown,
                              ),
                            ),
                            Transform(
                              alignment: Alignment.centerLeft,
                              transform: Matrix4.identity()..rotateY(pi/2),
                              child: Container(
                                width: heightAndWidth,
                                height: heightAndWidth,
                                color: Colors.blue,
                              ),
                            ),
                            Transform(
                              alignment: Alignment.centerRight,
                              transform: Matrix4.identity()..rotateY(-pi/2),
                              child: Container(
                                width: heightAndWidth,
                                height: heightAndWidth,
                                color: Colors.yellow,
                              ),
                            ),
                            Transform(
                              alignment: Alignment.bottomCenter,
                              transform: Matrix4.identity()..rotateX(pi/2),
                              child: Container(
                                width: heightAndWidth,
                                height: heightAndWidth,
                                color: Colors.pink,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
