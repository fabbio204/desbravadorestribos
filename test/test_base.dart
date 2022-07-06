import 'package:desbravadores_tribos/app/core/api/google_api_base.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';

class NavigatorObserverMock extends Mock implements NavigatorObserver {}

class GoogleApiMock extends Mock implements GoogleApiBase {}

mixin DiagnosticableMock implements Diagnosticable {
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {}

  @override
  DiagnosticsNode toDiagnosticsNode(
      {String? name, DiagnosticsTreeStyle? style}) {
    return DiagnosticsNode.message('Foo');
  }

  @override
  String toStringShort() => toString();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return super.toString();
  }
}

class BuildContextMock extends Mock
    with DiagnosticableMock
    implements BuildContext {
  @override
  DiagnosticsNode describeElement(String name,
      {DiagnosticsTreeStyle style = DiagnosticsTreeStyle.errorProperty}) {
    return DiagnosticsNode.message('Foo');
    ;
  }
}

Widget montarBase(Widget child) {
  return MaterialApp(
    home: Directionality(
      textDirection: TextDirection.ltr,
      child: MediaQuery(
        data: const MediaQueryData(),
        child: child,
      ),
    ),
  );
}

Widget montarBaseComContext(Widget child, BuildContext contextMock) {
  var navigatorMock = NavigatorObserverMock();
  return MaterialApp(
    navigatorObservers: [navigatorMock],
    home: Builder(
      builder: (context) {
        contextMock = context;
        return child;
      },
    ),
  );
}

Future<void> voidFunction() async {
  await Future.delayed(const Duration(microseconds: 1));
}
