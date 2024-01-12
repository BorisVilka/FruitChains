
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fruitchains/dialog.dart';
import 'package:fruitchains/game/fruit.dart';
import 'package:fruitchains/game/world.dart';

import 'game/background.dart';

class GameScreen extends StatelessWidget {

  static const String winDialogKey = 'win_dialog';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: GameWidget<BoxGame>(
        game: BoxGame(),
        key: const Key('play session'),
        overlayBuilderMap: {
          winDialogKey: (BuildContext context, BoxGame game) {
            return WinDialog(game.world.scoreNotifier.value);
          }
        },
      ),
    );
  }

}

class BoxGame extends FlameGame<FruitWorld> with HasCollisionDetection,
  TapDetector, MouseMovementDetector
{
  BoxGame(): super(world: FruitWorld());


  @override
  Future<void> onLoad() async {
    // The backdrop is a static layer behind the world that the camera is
    // looking at, so here we add our parallax background.
    camera.backdrop.add(Background(speed: 0));

    // With the `TextPaint` we define what properties the text that we are going
    // to render will have, like font family, size and color in this instance.

    // The scoreComponent is added to the viewport, which means that even if the
    // camera's viewfinder move around and looks at different positions in the
    // world, the score is always static to the viewport.

  }


  @override
  void render(Canvas canvas) {
    super.render(canvas);
    var components = world.children.whereType<Fruit>().toList();
    bool ans = components.isNotEmpty;
    for(int i = 0;i<components.length;i++) {
      if(!components[i].stop) {
        ans = false;
        break;
      }
      for(int j = i+1;j<components.length;j++) {
        if(!components[j].stop) {
          ans = false;
          break;
        }
        if(((components[i].position.x-components[j].position.x).abs()<110
          &&
          (components[i].position.y-components[j].position.y).abs()<110)
          && (components[i].ind==components[j].ind)
        ) {
          for(int h = j+1;h<components.length;h++) {
            if(!components[h].stop) {
              ans = false;
              break;
            }
            if(((components[h].position.x-components[j].position.x).abs()<110
                &&
                (components[h].position.y-components[j].position.y).abs()<110)
            && components[h].ind==components[j].ind
            ) {
              ans = false;
              break;
            }
          }
        }
      }
    }
    if(ans) {
      pauseEngine();
      overlays.add(GameScreen.winDialogKey);
      print('END');
    }

  }



}