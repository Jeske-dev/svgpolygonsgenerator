// Hannes Szeski Franz Tuschsk

import 'dart:math';
import 'dart:io';

List<int> polygonSizes = [5, 8, 10, 15, 18, 30];

void main() {
  String svg = '<svg viewBox="0 0 ${2 + 3*(polygonSizes.length - 1)} 2" xmlns="http://www.w3.org/2000/svg">\n';
  for (int i = 0; i < polygonSizes.length; i++) {
    String p = getPolygonSVG(polygonSizes[i], Vector(i*3 + 1, 1));
    String path = '<path d="$p" stroke="black" stroke-width="0.02" />';
    svg += path;
  }
  svg += "</svg>";

  writeInFile(svg, "polygons.svg");
}

void writeInFile(String content, String path) {
  final file = File(path);
  if (!file.existsSync()) {
    file.createSync();
  }
  file.writeAsStringSync(content);
}

String getPolygonSVG(int n, Vector m) {

  String startingSVGPoint = Vector(m.x + 1, m.y).toSVGPoint();
  String svg = "M ${startingSVGPoint} ";

  for (int i = 1; i <= n; i++) {
    String nextSVGPoint = edge(i, n, m).toSVGPoint();
    svg += "L $nextSVGPoint M $nextSVGPoint ";
  }

  return svg;
}

/// int k: Welche Ecke des n-Ecks | 
/// int n: Größe des n-Ecks (n=3 -> Dreieck) | 
/// Vector m: Mittelpunkt des Polygons
/// (zur vereinfachten Berrechnung ist der Radius r = 1)
Vector edge(int k, int n, Vector m) {
  double alpha = 2*pi/n;
  return Vector(
    m.x + cos(alpha*k),
    m.y + sin(alpha*k)
  );
}

class Vector {
  final double x, y;
  const Vector(this.x, this.y);

  String toSVGPoint() => "$x,$y";
}