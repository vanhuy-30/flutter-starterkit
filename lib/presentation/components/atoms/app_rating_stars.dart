import 'package:flutter/material.dart';

class AppRatingStars extends StatelessWidget {
  final double initialRating;
  final int maxRating;
  final double starSize;
  final RatingStyleBuilder? ratingStyleBuilder;
  final Color activeColor;
  final Color inactiveColor;
  final ValueChanged<double>? onRatingChanged;
  final bool isInteractive;
  final bool allowHalfRating;

  const AppRatingStars({
    super.key,
    this.initialRating = 0.0,
    this.maxRating = 5,
    this.starSize = 24.0,
    this.ratingStyleBuilder,
    this.activeColor = Colors.amber,
    this.inactiveColor = Colors.grey,
    this.onRatingChanged,
    this.isInteractive = true,
    this.allowHalfRating = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: isInteractive ? (details) => _handleTapDown(context, details) : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(maxRating, (index) {
          final bool isFullStar = initialRating >= index + 1;
          final bool isHalfStar = allowHalfRating &&
              initialRating > index &&
              initialRating < index + 1;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: ratingStyleBuilder?.call(
                  isFullStar,
                  isHalfStar,
                  activeColor,
                  inactiveColor,
                  starSize,
                ) ??
                _defaultStyle(isFullStar, isHalfStar),
          );
        }),
      ),
    );
  }

  Widget _defaultStyle(bool isFullStar, bool isHalfStar) {
    return Icon(
      isFullStar
          ? Icons.star
          : (isHalfStar ? Icons.star_half : Icons.star_border),
      color: isFullStar || isHalfStar ? activeColor : inactiveColor,
      size: starSize,
    );
  }

  void _handleTapDown(BuildContext context, TapDownDetails details) {
    final RenderBox box = context.findRenderObject() as RenderBox;
    final localPosition = box.globalToLocal(details.globalPosition);
    final starWidth = box.size.width / maxRating;

    double newRating = (localPosition.dx / starWidth);

    if (allowHalfRating) {
      newRating = (newRating * 2).round() / 2;
    } else {
      newRating = newRating.ceil().toDouble();
    }

    newRating = newRating.clamp(0.0, maxRating.toDouble());

    onRatingChanged?.call(newRating);
  }
}

typedef RatingStyleBuilder = Widget Function(
  bool isFullStar,
  bool isHalfStar,
  Color activeColor,
  Color inactiveColor,
  double starSize,
);
