import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:desbravadores_tribos/app/modules/home/controllers/home_controller.dart';
 
void main() {

  blocTest<HomeController, int>('emits [1] when increment is added',
    build: () => HomeController(),
    act: (cubit) => cubit.increment(),
    expect: () => [1],
  );
}