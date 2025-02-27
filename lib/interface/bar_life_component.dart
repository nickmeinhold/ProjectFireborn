import 'dart:ui';

import 'package:bonfire/bonfire.dart';
import 'package:project_fireborn/player/male.dart';
import 'package:flutter/material.dart';

class BarLifeComponent extends InterfaceComponent {
  double padding = 20;
  double widthBar = 90;
  double strokeWidth = 12;

  double maxLife = 0;
  double life = 0;
  double maxStamina = 100;
  double stamina = 0;

  BarLifeComponent()
      : super(
          id: 1,
          position: Vector2(20, 20),
          sprite: Sprite.load('health_ui.png'),
          width: 120,
          height: 40,
        );

  @override
  void update(double t) {
    if (this.gameRef.player != null) {
      life = this.gameRef.player!.life;
      maxLife = this.gameRef.player!.maxLife;
      if (this.gameRef.player is Male) {
        stamina = (this.gameRef.player as Male).stamina;
      }
    }
    super.update(t);
  }

  @override
  void render(Canvas c) {
    try {
      _drawLife(c);
      _drawStamina(c);
    } catch (e) {}
    super.render(c);
  }

  void _drawLife(Canvas canvas) {
    double xBar = 48;
    double yBar = 31.5;
    canvas.drawLine(
        Offset(xBar, yBar),
        Offset(xBar + widthBar, yBar),
        Paint()
          ..color = Colors.blueGrey
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.fill);

    double currentBarLife = (life * widthBar) / maxLife;

    canvas.drawLine(
        Offset(xBar, yBar),
        Offset(xBar + currentBarLife, yBar),
        Paint()
          ..color = _getColorLife(currentBarLife)
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.fill);
  }

  void _drawStamina(Canvas canvas) {
    double xBar = 48;
    double yBar = 47;

    double currentBarStamina = (stamina * widthBar) / maxStamina;

    canvas.drawLine(
        Offset(xBar, yBar),
        Offset(xBar + currentBarStamina, yBar),
        Paint()
          ..color = Colors.yellow
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.fill);
  }

  Color _getColorLife(double currentBarLife) {
    if (currentBarLife > widthBar - (widthBar / 3)) {
      return Colors.green;
    }
    if (currentBarLife > (widthBar / 3)) {
      return Colors.yellow;
    } else {
      return Colors.red;
    }
  }
}
