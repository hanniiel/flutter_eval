import 'package:bloc_test/bloc_test.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_eval/features/home/mocks/mock_idols.dart';
import 'package:flutter_eval/features/home/ui/bloc/idols_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('IdolsBloc test', () {
    late IdolsBloc idolsBloc;
    MockIdolRepository mockIdolRepository;

    setUp(() async {
      EquatableConfig.stringify = true;
      mockIdolRepository = MockIdolRepository();
      idolsBloc = IdolsBloc(mockIdolRepository);
    });

    blocTest<IdolsBloc, IdolsState>(
      'emits loading and loaded',
      build: () => idolsBloc,
      act: (bloc) => bloc.add(IdolsEvent.init),
      wait: const Duration(seconds: 2),
      expect: () => [
        IdolsLoading(),
        IdolsLoaded(
          mockIdols,
        )
      ],
    );

    tearDown(() {
      idolsBloc.close();
    });
  });
}
