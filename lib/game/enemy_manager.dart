import 'dart:math';
import 'dart:ui';

import 'package:dino_run/game/enemy.dart';
import 'package:dino_run/game/game.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/time.dart';

class EnemyManager extends Component with HasGameRef<DinoGame> {
  Random _random;
  Timer _timer;

  EnemyManager() {
    _random = Random();
    _timer = Timer(4, repeat: true, callback: () {
      spawnRandomEnemy();
    });
  }

  void spawnRandomEnemy() {
    final randomNumber = _random.nextInt(EnemyType.values.length);
    final randomEnemyType = EnemyType.values.elementAt(randomNumber);
    final newEnemy = Enemy(randomEnemyType);
    gameRef.addLater(newEnemy);
    // Todo: Add newEnemy to DinoGame.
  }

  @override
  void onMount() {
    super.onMount();
    _timer.start();
  }

  @override
  void update(double t) {
    // TODO: implement update
    _timer.update(t);
  }

  @override
  void render(Canvas c) {
    // TODO: implement render
  }
}
