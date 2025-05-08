import 'package:flutter/material.dart';

class AppDivider extends StatelessWidget {
  final double? height;
  final double? thickness;
  final Color? color;
  final double? horizontalPadding;
  final double? horizontalMargin;
  final DividerType type;


  const AppDivider({
    super.key,
    this.height = 1,
    this.thickness,
    this.color,
    this.horizontalPadding,
    this.horizontalMargin,
    this.type = DividerType.normal,
  });

  @override
  Widget build(BuildContext context) {
    final dividerColor = color ?? Theme.of(context).dividerColor;
    final dividerThickness = thickness ?? height ?? 1;
    final dividerPadding = horizontalPadding ?? 0;
    final dividerMargin = horizontalMargin ?? 0;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: dividerPadding),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: dividerMargin),
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return SizedBox(
            height: height,
            child: Row(
              children: _buildDividerLine(constraints.maxWidth, dividerColor, dividerThickness) ,
              )
           );
        }),
      )
    );
  }

  List<Widget> _buildDividerLine(double maxWidth, Color dividerColor, double dividerThickness) {
     if(type == DividerType.normal){
       return [
            Expanded(
              child: Container(
                  height: dividerThickness,
                  color: dividerColor),
            )
          ];
     } else {
        return [
          Expanded(
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: _buildPattern(maxWidth, dividerColor, dividerThickness)
              )
          )
        ];
     }
  }

  List<Widget> _buildPattern(double maxWidth, Color dividerColor, double dividerThickness) {
      const double patternLength = 4.0;
      const double patternSpace = 4.0;
      const double dividerSpace = patternLength + patternSpace;
      final int numberOfPattern = (maxWidth / dividerSpace).floor();

      List<Widget> dividers = [];

       for (int i = 0; i < numberOfPattern; i++) {
          dividers.add(Container(
            width: patternLength,
            height: dividerThickness,
            color: dividerColor
          ));

          if(i < numberOfPattern -1 ){
             dividers.add(const SizedBox(width: patternSpace));
          }
        }

    return dividers;
  }
}


enum DividerType {
  normal,
  dotted,
  dashed
}