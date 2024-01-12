

import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:fruitchains/game.dart';
import 'package:fruitchains/game/fruit.dart';

class FruitWorld extends World with HasCollisionDetection, HasGameReference<BoxGame>, DragCallbacks {

  final scoreNotifier = ValueNotifier(0);
  late final DateTime timeStarted;
  Vector2 get size => (parent as FlameGame).size;
  late final double groundLevel = (size.y / 2) - (size.y / 6);
  final double gravity = 3.5;
  int level = 2;

  @override
  Future<void> onLoad() async {
    // Used to keep track of when the level started, so that we later can
    // calculate how long time it took to finish the level.
    timeStarted = DateTime.now();

    // The player is the component that we control when we tap the screen, the
    // Dash in this case.
    double offset = 0;
    for(int i = 0;i<8;i++,offset-=120) {
      add(Fruit(position: Vector2(0, offset),level: level));
      add(Fruit(position: Vector2(70, offset),level: level));
      add(Fruit(position: Vector2(140, offset),level: level));
      add(Fruit(position: Vector2(-70, offset),level: level));
      add(Fruit(position: Vector2(-140, offset),level: level));
    }

    // When the player takes a new point we check if the score is enough to
    // pass the level and if it is we calculate what time the level was passed
    // in, update the player's progress and open up a dialog that shows that
    // the player passed the level.
  }



}