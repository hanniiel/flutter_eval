import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_eval/features/auth/ui/bloc/bloc_auth.dart';
import 'package:flutter_eval/features/home/ui/bloc/idols_bloc.dart';
import 'package:flutter_eval/features/home/ui/widgets/idol_card_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          //Closes the session
          const Text('Button to close the session ->'),
          IconButton(
            onPressed: () => context.read<BlocAuth>().add(LogOut()),
            icon: const Icon(Icons.close),
          )
        ],
      ),
      body: BlocBuilder<IdolsBloc, IdolsState>(
        builder: (context, state) {
          if (state is IdolsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is IdolsLoaded) {
            final idols = state.idols;
            return ListView.separated(
              separatorBuilder: (context, index) =>
                  const Divider(height: 2, thickness: 2),
              itemCount: idols.length,
              itemBuilder: (context, index) => IdolCardWidget(
                name: idols[index].name,
                avatar: idols[index].avatar,
                hangul: idols[index].hangul,
              ),
            );
          }
          return const Center(
              child: Text(
            'Error to fetch data',
            style: TextStyle(color: Colors.red),
          ));
        },
      ),
    );
  }
}
