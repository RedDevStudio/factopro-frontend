import 'dart:io';

import 'package:factopro/resources/resources.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('images assets test', () {
    expect(File(Images.blueCircle).existsSync(), isTrue);
    expect(File(Images.centerVisual).existsSync(), isTrue);
    expect(File(Images.greenCircle).existsSync(), isTrue);
    expect(File(Images.purpleCircle).existsSync(), isTrue);
    expect(File(Images.splashAppbarLogo).existsSync(), isTrue);
  });
}
