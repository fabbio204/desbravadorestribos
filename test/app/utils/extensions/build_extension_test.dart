import 'package:desbravadores_tribos/app/utils/extensions/build_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_base.dart';

void main() {
  testWidgets('Testa build extension', (WidgetTester tester) async {
    BuildContext buildMock = BuildContextMock();

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: MediaQuery(
          data: const MediaQueryData(size: Size(100, 100)),
          child: MaterialApp(
            builder: (context, child) {
              buildMock = context;
              return Container();
            },
          ),
        ),
      ),
    );

    var primaryColor = buildMock.primaryColor;
    var secondaryColor = buildMock.secondaryColor;
    var screenWidth = buildMock.screenWidth;
    var screenHeight = buildMock.screenHeight;

    expect(primaryColor, isNotNull);
    expect(secondaryColor, isNotNull);
    expect(screenWidth, isNotNull);
    expect(screenHeight, isNotNull);
  });
}
