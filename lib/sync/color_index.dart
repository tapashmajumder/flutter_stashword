import 'dart:math';

class ColorTuple {
  final int r;
  final int g;
  final int b;

  const ColorTuple({required this.r, required this.g, required this.b});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ColorTuple && r == other.r && g == other.g && b == other.b;

  @override
  int get hashCode => r.hashCode ^ g.hashCode ^ b.hashCode;

  @override
  String toString() {
    return "(r: $r, g: $g, b: $b)";
  }
}

class ColorIndexHelper {
  static const List<ColorTuple> colors = [
    ColorTuple(r: 204, g: 192, b: 42),
    ColorTuple(r: 153, g: 150, b: 108),
    ColorTuple(r: 142, g: 200, b: 255),
    ColorTuple(r: 42, g: 168, b: 204),
    ColorTuple(r: 212, g: 65, b: 110),
    ColorTuple(r: 102, g: 79, b: 97),
  ];

  final ColorTuple colorTuple;

  ColorIndexHelper.rgb(int rgb)
      : colorTuple = ColorTuple(
    r: (rgb >> 16) & 0xFF,
    g: (rgb >> 8) & 0xFF,
    b: rgb & 0xFF,
  );

  ColorIndexHelper.colorIndex(int colorIndex)
      : colorTuple = (colorIndex >= 0 && colorIndex < colors.length)
      ? colors[colorIndex]
      : randomTuple;

  int get rgbInt => (colorTuple.r << 16) + (colorTuple.g << 8) + colorTuple.b;

  int? get colorIndex {
    for (int index = 0; index < colors.length; index++) {
      if (colors[index] == colorTuple) {
        return index;
      }
    }
    return null;
  }

  static int get randomColorIndex => Random().nextInt(colors.length);

  static ColorTuple get randomTuple => colors[randomColorIndex];
}

void main() {
  print(ColorIndexHelper.rgb(16711680).colorTuple); // ColorTuple(r: 255, g: 0, b: 0)
  print(ColorIndexHelper.colorIndex(3).colorTuple); // ColorTuple(r: 42, g: 168, b: 204)
}
