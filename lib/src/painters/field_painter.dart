import 'package:flutter/material.dart';

import '../enums/enums.dart';
import '../themes/soccer_lineup_theme_data.dart';

/// A [CustomPainter] that draws a soccer field.
///
/// The painter draws:
/// - Field background (with optional stripe pattern)
/// - Centre circle and centre spot
/// - Halfway line
/// - Penalty areas (top and bottom)
/// - Goal areas (6-yard boxes)
/// - Corner arc indicators
///
/// All colours and line widths are sourced from [SoccerLineupThemeData].
class FieldPainter extends CustomPainter {
  /// Creates a [FieldPainter].
  const FieldPainter({required this.theme});

  /// The theme data used to style the field.
  final SoccerLineupThemeData theme;

  @override
  void paint(Canvas canvas, Size size) {
    switch (theme.fieldStyle) {
      case FieldStyle.grass:
        _paintGrass(canvas, size);
      case FieldStyle.darkGrass:
        _paintDarkGrass(canvas, size);
      case FieldStyle.blueprint:
        _paintBlueprint(canvas, size);
      case FieldStyle.chalkboard:
        _paintChalkboard(canvas, size);
      case FieldStyle.custom:
      case FieldStyle.image:
        _paintPlainBackground(canvas, size);
    }
    _paintFieldMarkings(canvas, size);
  }

  void _paintGrass(Canvas canvas, Size size) {
    final primary =
        theme.fieldPrimaryColor ?? const Color(0xFF2D8653);
    final secondary =
        theme.fieldSecondaryColor ?? const Color(0xFF267847);

    final bgPaint = Paint()..color = primary;
    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(theme.fieldBorderRadius),
    );
    canvas.drawRRect(rrect, bgPaint);

    // Alternating horizontal stripes.
    final stripeCount = 10;
    final stripeH = size.height / stripeCount;
    final stripePaint = Paint()..color = secondary;
    for (var i = 0; i < stripeCount; i++) {
      if (i.isOdd) {
        canvas.drawRect(
          Rect.fromLTWH(0, i * stripeH, size.width, stripeH),
          stripePaint,
        );
      }
    }
  }

  void _paintDarkGrass(Canvas canvas, Size size) {
    final primary =
        theme.fieldPrimaryColor ?? const Color(0xFF1E5C38);
    final secondary =
        theme.fieldSecondaryColor ?? const Color(0xFF174D2F);

    final bgPaint = Paint()..color = primary;
    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(theme.fieldBorderRadius),
    );
    canvas.drawRRect(rrect, bgPaint);

    final stripeCount = 10;
    final stripeH = size.height / stripeCount;
    final stripePaint = Paint()..color = secondary;
    for (var i = 0; i < stripeCount; i++) {
      if (i.isOdd) {
        canvas.drawRect(
          Rect.fromLTWH(0, i * stripeH, size.width, stripeH),
          stripePaint,
        );
      }
    }
  }

  void _paintBlueprint(Canvas canvas, Size size) {
    final primary =
        theme.fieldPrimaryColor ?? const Color(0xFF0A3D62);
    final bgPaint = Paint()..color = primary;
    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(theme.fieldBorderRadius),
    );
    canvas.drawRRect(rrect, bgPaint);

    // Faint grid lines.
    final gridPaint = Paint()
      ..color = Colors.white.withAlpha(20)
      ..strokeWidth = 0.5;
    const gridSpacing = 20.0;
    for (var x = 0.0; x < size.width; x += gridSpacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (var y = 0.0; y < size.height; y += gridSpacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }
  }

  void _paintChalkboard(Canvas canvas, Size size) {
    final primary =
        theme.fieldPrimaryColor ?? const Color(0xFF1A2226);
    final bgPaint = Paint()..color = primary;
    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(theme.fieldBorderRadius),
    );
    canvas.drawRRect(rrect, bgPaint);
  }

  void _paintPlainBackground(Canvas canvas, Size size) {
    final primary =
        theme.fieldPrimaryColor ?? const Color(0xFF2D8653);
    final bgPaint = Paint()..color = primary;
    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(theme.fieldBorderRadius),
    );
    canvas.drawRRect(rrect, bgPaint);
  }

  void _paintFieldMarkings(Canvas canvas, Size size) {
    final lineColor =
        theme.fieldLineColor ?? Colors.white.withAlpha(200);
    final linePaint = Paint()
      ..color = lineColor
      ..strokeWidth = theme.fieldLineWidth
      ..style = PaintingStyle.stroke;
    final fillPaint = Paint()
      ..color = lineColor
      ..style = PaintingStyle.fill;

    final w = size.width;
    final h = size.height;
    final margin = w * 0.05;

    // Outer boundary
    final outerRect = Rect.fromLTRB(margin, margin * 1.2, w - margin, h - margin * 1.2);
    canvas.drawRect(outerRect, linePaint);

    // Halfway line
    canvas.drawLine(
      Offset(margin, h / 2),
      Offset(w - margin, h / 2),
      linePaint,
    );

    // Centre circle
    canvas.drawCircle(Offset(w / 2, h / 2), w * 0.12, linePaint);

    // Centre spot
    canvas.drawCircle(Offset(w / 2, h / 2), 3, fillPaint);

    // Penalty areas
    final penAreaW = w * 0.5;
    final penAreaH = h * 0.14;
    // Top penalty area
    canvas.drawRect(
      Rect.fromLTRB(
        (w - penAreaW) / 2,
        margin * 1.2,
        (w + penAreaW) / 2,
        margin * 1.2 + penAreaH,
      ),
      linePaint,
    );
    // Bottom penalty area
    canvas.drawRect(
      Rect.fromLTRB(
        (w - penAreaW) / 2,
        h - margin * 1.2 - penAreaH,
        (w + penAreaW) / 2,
        h - margin * 1.2,
      ),
      linePaint,
    );

    // 6-yard boxes
    final goalAreaW = w * 0.25;
    final goalAreaH = h * 0.06;
    // Top goal area
    canvas.drawRect(
      Rect.fromLTRB(
        (w - goalAreaW) / 2,
        margin * 1.2,
        (w + goalAreaW) / 2,
        margin * 1.2 + goalAreaH,
      ),
      linePaint,
    );
    // Bottom goal area
    canvas.drawRect(
      Rect.fromLTRB(
        (w - goalAreaW) / 2,
        h - margin * 1.2 - goalAreaH,
        (w + goalAreaW) / 2,
        h - margin * 1.2,
      ),
      linePaint,
    );

    // Penalty spots
    canvas.drawCircle(
      Offset(w / 2, margin * 1.2 + penAreaH * 0.62),
      3,
      fillPaint,
    );
    canvas.drawCircle(
      Offset(w / 2, h - margin * 1.2 - penAreaH * 0.62),
      3,
      fillPaint,
    );

    // Corner arcs
    const cornerRadius = 8.0;
    final cornerPath = Path();
    // Top-left
    cornerPath.addArc(
      Rect.fromCircle(center: Offset(margin, margin * 1.2), radius: cornerRadius),
      0,
      3.14 / 2,
    );
    // Top-right
    cornerPath.addArc(
      Rect.fromCircle(center: Offset(w - margin, margin * 1.2), radius: cornerRadius),
      3.14 / 2,
      3.14 / 2,
    );
    // Bottom-left
    cornerPath.addArc(
      Rect.fromCircle(center: Offset(margin, h - margin * 1.2), radius: cornerRadius),
      3.14 * 3 / 2,
      3.14 / 2,
    );
    // Bottom-right
    cornerPath.addArc(
      Rect.fromCircle(center: Offset(w - margin, h - margin * 1.2), radius: cornerRadius),
      3.14,
      3.14 / 2,
    );
    canvas.drawPath(cornerPath, linePaint);
  }

  @override
  bool shouldRepaint(covariant FieldPainter oldDelegate) =>
      oldDelegate.theme != theme;
}
