import 'dart:math';
import 'dart:ui';

import 'package:flame/anchor.dart';
import 'package:flame/components/animation_component.dart';
import 'package:flame/spritesheet.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

enum EnemyType { AngryPig, Bat, Rino }

class EnemyData {
  final String imageName;
  final int textureWidth;
  final int textureHeight;
  final int nColumns;
  final int nRows;
  final bool canFly;
  final int speed;

  const EnemyData({
    @required this.imageName,
    @required this.textureWidth,
    @required this.textureHeight,
    @required this.nColumns,
    @required this.nRows,
    @required this.speed,
    this.canFly = false,
  });
}

class Enemy extends AnimationComponent {
  EnemyData _myData;
  static Random _random = Random();

  static const Map<EnemyType, EnemyData> _enemyDetails = {
    EnemyType.AngryPig: EnemyData(
        imageName: 'AngryPig/Walk (36x30).png',
        nColumns: 16,
        nRows: 1,
        textureHeight: 30,
        textureWidth: 36,
        speed: 250),
    EnemyType.Bat: EnemyData(
        imageName: 'Bat/Flying (46x30).png',
        nColumns: 7,
        nRows: 1,
        textureHeight: 30,
        textureWidth: 46,
        speed: 300,
        canFly: true),
    EnemyType.Rino: EnemyData(
      imageName: 'Rino/Run (52x34).png',
      nColumns: 6,
      nRows: 1,
      textureHeight: 34,
      textureWidth: 52,
      speed: 350,
    )
  };

  Enemy(EnemyType enemyType) : super.empty() {
    _myData = _enemyDetails[enemyType];

    final spriteSheet = SpriteSheet(
      imageName: _myData.imageName,
      textureWidth: _myData.textureWidth,
      textureHeight: _myData.textureHeight,
      columns: _myData.nColumns,
      rows: _myData.nRows,
    );

    this.animation = spriteSheet.createAnimation(0,
        from: 0, to: (_myData.nColumns - 1), stepTime: 0.1);

    this.anchor = Anchor.center;
  }

  @override
  void resize(Size size) {
    super.resize(size);

    double scaleFactor =
        (size.width / numberOfTilesAlongWidth) / _myData.textureWidth;

    this.height = _myData.textureHeight * scaleFactor;
    this.width = _myData.textureWidth * scaleFactor;
    this.x = size.width + this.width;
    this.y = size.height - groundHeight - (this.height / 2);

    if (_myData.canFly && _random.nextBool()) {
      this.y -= this.height;
    }
  }

  @override
  void update(double t) {
    super.update(t);
    this.x -= _myData.speed * t;
  }

  @override
  bool destroy() {
    return (this.x < (-this.width));
  }
}
