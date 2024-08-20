class Rectangle {
  double width;
  double height;

  Rectangle({required this.width, required this.height});

  double calculateArea() {
    if (width < 0 || height < 0) {
      throw ArgumentError("Width and height must be non-negative");
    }
    return width * height;
  }
}
