

import 'package:test/test.dart';

import '../lib/models/rectangle.dart';

void main() {
  group('Rectangle', () {
    test('calculates the area correctly', () {
      final rectangle = Rectangle(width: 4, height: 5);
      expect(rectangle.calculateArea(), 20);
    });

    test('throws an error if width is negative', () {
      expect(() => Rectangle(width: -4, height: 5).calculateArea(),
          throwsArgumentError);
    });

    test('throws an error if height is negative', () {
      expect(() => Rectangle(width: 4, height: -5).calculateArea(),
          throwsArgumentError);
    });

    test('calculates area with zero width or height', () {
      final rectangleWithZeroWidth = Rectangle(width: 0, height: 5);
      final rectangleWithZeroHeight = Rectangle(width: 4, height: 0);

      expect(rectangleWithZeroWidth.calculateArea(), 0);
      expect(rectangleWithZeroHeight.calculateArea(), 0);
    });
  });
}
