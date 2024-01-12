

import 'dart:math';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:fruitchains/game/world.dart';

class Fruit extends SpriteComponent with HasWorldReference<FruitWorld>, CollisionCallbacks,
  DragCallbacks
{

  static const int offset = 10;
  final Vector2 _srcSize;
  final Vector2 _srcPosition;
  static Random random = Random();
  final int ind;
  double _gravity = 0;
  var chain = <Fruit>[];
  var stop = false;
  var first = false;

  Fruit.new({super.position,level})
      : _srcSize = Vector2.all(60),
        ind = random.nextInt(level)+1,
        _srcPosition = Vector2.all(0),
        super(
        size: Vector2.all(60),
        anchor: Anchor.center,
      );

  Fruit.active({super.position, ind})
   :  _srcSize = Vector2.all(60),
        ind = ind,
        _srcPosition = Vector2.all(0),
        super(
        size: Vector2.all(60),
        anchor: Anchor.center,
      );

  @override
  Future<void> onLoad() async {
    // Since all the obstacles reside in the same image, srcSize and srcPosition
    // are used to determine what part of the image that should be used.
   /* sprite = await Sprite.load(
      'dash/t1.png',
      srcSize: _srcSize,
      srcPosition: _srcPosition,
    );*/
    var i = await Flame.images.load("dash/${ind==world.level ? "a" : "t"}$ind.png");
    i = await i.resize(_srcSize);
    sprite = Sprite(i,srcPosition: _srcPosition,srcSize: _srcSize);
    // When adding a RectangleHitbox without any arguments it automatically
    // fills up the size of the component.
    add(RectangleHitbox(size: _srcSize));
  }

  late var t;

  @override
  void update(double dt) {
    // We need to move the component to the left together with the speed that we
    // have set for the world.
    // `dt` here stands for delta time and it is the time, in seconds, since the
    // last update ran. We need to multiply the speed by `dt` to make sure that
    // the speed of the obstacles are the same no matter the refresh rate/speed
    // of your device.
    //position.x -= world.speed * dt*3.5;
    if(ind<world.level) {
      if(!first) {
        first = true;
        Flame.images.load("dash/${ind==world.level ? "a" : "t"}$ind.png")
        .then((value) async => {
          t = await value.resize(_srcSize),
          sprite = Sprite(t,srcPosition: _srcPosition,srcSize: _srcSize)
        });

      }
    }
    if(!stop) {
      _gravity += world.gravity*dt;
      position.y += _gravity;
    }
    // When the component is no longer visible on the screen anymore, we
    // remove it.
    // The position is defined from the upper left corner of the component (the
    // anchor) and the center of the world is in (0, 0), so when the components
    // position plus its size in X-axis is outside of minus half the world size
    // we know that it is no longer visible and it can be removed.
    if (position.y + size.y > world.size.y / 2.5) {
      position.y =  world.size.y /2.5-size.y;
      _gravity = 0;
      stop = true;
      //world.scoreNotifier.value  = world.scoreNotifier.value+1;
      //removeFromParent();
    }
  }
  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints,
      PositionComponent other,
      ) {
    super.onCollisionStart(intersectionPoints, other);
    // When the player collides with an obstacle it should lose all its points.
    if (other is Fruit) {
      if(other.position.y>position.y && other.stop) {
        stop = true;
        _gravity = other._gravity;
        position.y = other.y-other.size.y-offset;
      }
    }
  }

  bool _drag = false;

  @override
  void onDragStart(DragStartEvent event)  {
    super.onDragStart(event);
    if(!_drag) {
      _drag = true;
      chain.add(this);
      world.add(CircleComponent(
          radius: 10,
          position: event.canvasPosition..sub(Vector2(world.size.x/2, world.size.y/2)),
          paint: Paint()..color = Colors.yellow
      ));
    }
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    if(_drag) {
      var comp = world
          .componentsAtPoint(event.canvasStartPosition..sub(Vector2(world.size.x/2, world.size.y/2))
        ..sub(event.localDelta..divide(Vector2(2, 2)))
      ).toList().whereType<Fruit>().toList().firstOrNull;
      world.add(CircleComponent(
          radius: 10,
          position: event.canvasStartPosition,
          paint: Paint()..color = Colors.yellow
      ));
      if(comp!=null) {
        print(comp.ind);
        if(comp.ind!=ind) {
          chain.clear();
          _drag = false;
          world.removeAll(world.children.whereType<CircleComponent>());
          chain.clear();
        } else {
          if(!chain.contains(comp)) chain.add(comp);
        }
      }
    }
  }

  @override
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);
    if(_drag && chain.length>2)  {
      world.scoreNotifier.value = world.scoreNotifier.value+chain.length*10*(ind+1);
      if(ind==world.level && world.level<7) {
        world.level++;
      }
      Fruit last = chain.removeLast();
      world.remove(last);
      world.add(Fruit.active(
        position: last.position,
        ind: min(ind+1, 7)
      ));
      world.removeAll(chain);
      world.children.whereType<Fruit>().forEach((element) {
        for (var rem in chain) {
          if(element.position.x==rem.position.x
              && element.position.y<rem.position.y) {
            element.stop = false;
            break;
          }
        }
      });
      var tmp = {};
      for(var i in chain) {
        var x = i.position.x;
        var y = tmp[x] ?? 0;
        y -= world.size.y/2;
        tmp[x] = y;
        world.add(Fruit(position: Vector2(x, y),level: world.level));
      }
      tmp.clear();
    }
    _drag = false;
    chain.clear();
    world.removeAll(world.children.whereType<CircleComponent>());
  }
}
