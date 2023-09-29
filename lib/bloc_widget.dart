import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_eval/features/auth/ui/bloc/bloc_auth.dart';
import 'package:flutter_eval/features/home/data/repos/idol_repository.dart';
import 'package:flutter_eval/features/home/ui/bloc/idols_bloc.dart';
import 'package:flutter_eval/features/login/data/repos/login_repository.dart';
import 'package:flutter_eval/features/login/ui/bloc/cubit_login.dart';

class BlocWidget extends StatelessWidget {
  final Widget child;
  const BlocWidget({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: ((context) => LoginRepository())),
        RepositoryProvider(create: ((context) => IdolRepository())),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            lazy: false,
            create: (context) => BlocAuth()..add(Initialized()),
          ),
          BlocProvider(
            create: (context) =>
                CubitLogin(repository: context.read<LoginRepository>()),
          ),
          BlocProvider(
            create: (context) =>
                IdolsBloc(context.read<IdolRepository>())..add(IdolsEvent.init),
          )
        ],
        child: child,
      ),
    );
  }
}
