import 'package:flutter/material.dart';

class RatingBar extends StatelessWidget {
  final double rating;
  final double size;
  final Color starColor;
  final Color emptyStarColor;

  const RatingBar({
    Key? key,
    required this.rating,
    this.size = 40.0,
    this.starColor = Colors.yellow,
    this.emptyStarColor = Colors.grey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size * 5, size),
      painter: _RatingBarPainter(
        rating: rating,
        starColor: starColor,
        emptyStarColor: emptyStarColor,
      ),
    );
  }
}

class _RatingBarPainter extends CustomPainter {
  final double rating;
  final Color starColor;
  final Color emptyStarColor;

  _RatingBarPainter({
    required this.rating,
    required this.starColor,
    required this.emptyStarColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const int starCount = 5;
    final double starSize = size.height;
    final double starSpacing = size.width / starCount - starSize;

    final Paint paint = Paint();

    for (int i = 0; i < starCount; i++) {
      final double dx = i * (starSize + starSpacing);
      const double dy = 0;

      final Path starPath = Path();
      starPath.moveTo(dx + starSize * 0.5, dy);
      starPath.lineTo(dx + starSize * 0.677, dy + starSize * 0.257);
      starPath.lineTo(dx + starSize * 0.975, dy + starSize * 0.345);
      starPath.lineTo(dx + starSize * 0.785, dy + starSize * 0.593);
      starPath.lineTo(dx + starSize * 0.794, dy + starSize * 0.905);
      starPath.lineTo(dx + starSize * 0.5, dy + starSize * 0.8);
      starPath.lineTo(dx + starSize * 0.206, dy + starSize * 0.905);
      starPath.lineTo(dx + starSize * 0.215, dy + starSize * 0.593);
      starPath.lineTo(dx + starSize * 0.025, dy + starSize * 0.345);
      starPath.lineTo(dx + starSize * 0.323, dy + starSize * 0.257);
      starPath.close();

      if (rating < 1) {
        paint.color = emptyStarColor;
        canvas.drawPath(starPath, paint);
      } else if (i < rating.floor()) {
        paint.color = starColor;
        canvas.drawPath(starPath, paint);
      } else if (i == rating.floor()) {
        if (rating % 1 != 0) {
          final double decimalPart = rating % 1;
          final double clipWidth = starSize * decimalPart;
          final Rect clipRect = Rect.fromLTWH(dx, dy, clipWidth, starSize);

          final Path decimalStarPath = Path.combine(
            PathOperation.intersect,
            starPath,
            Path()..addRect(clipRect),
          );
          paint.color = starColor;
          canvas.drawPath(decimalStarPath, paint);

          paint.color = emptyStarColor;
          final Path emptyStarPath = Path.combine(
            PathOperation.difference,
            starPath,
            Path()..addRect(clipRect),
          );
          canvas.drawPath(emptyStarPath, paint);
        } else {
          paint.color = starColor;
          canvas.drawPath(starPath, paint);
        }
      } else {
        paint.color = emptyStarColor;
        canvas.drawPath(starPath, paint);
      }

      // Draw the next star as an empty star in grey color
      if (i == rating.floor() && rating % 1 == 0) {
        paint.color = emptyStarColor;
        canvas.drawPath(starPath, paint);
      }
    }
  }

  @override
  bool shouldRepaint(_RatingBarPainter oldDelegate) {
    return oldDelegate.rating != rating ||
        oldDelegate.starColor != starColor ||
        oldDelegate.emptyStarColor != emptyStarColor;
  }
}
