import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_eval/features/home/data/models/idol_model.dart';
import 'package:flutter_eval/features/home/domain/repos/base_idol_repository.dart';
import 'package:flutter_eval/features/shared/services/debug.dart';

class IdolsBloc extends Bloc<IdolsEvent, IdolsState> {
  final BaseIdolRepository _baseIdolRepository;

  IdolsBloc(BaseIdolRepository repository)
      : _baseIdolRepository = repository,
        super(IdolsUninitialized()) {
    on<IdolsEvent>((event, emit) async {
      if (event == IdolsEvent.init) {
        await _mapToInit(event, emit);
      }
      //TODO implement refresh functionallity
    });
  }

  //map to init loading initial contents
  Future<void> _mapToInit(IdolsEvent event, Emitter<IdolsState> emit) async {
    emit(IdolsLoading());
    try {
      final res = await _baseIdolRepository.list();
      if (res.data != null) {
        //mapper to a representative. light and friendly ui model
        final idols = res.data!.map((e) => IdolModel.fromEntity(e)).toList();
        emit(IdolsLoaded(idols));
      }
    } catch (e) {
      emit(IdolsError());
      debug.e(e);
    }
  }
}

//states
@immutable
abstract class IdolsState extends Equatable {
  const IdolsState();

  @override
  List<Object?> get props => [];
}

class IdolsUninitialized extends IdolsState {}

class IdolsLoading extends IdolsState {}

class IdolsLoaded extends IdolsState {
  final List<IdolModel> idols;

  const IdolsLoaded(this.idols);

  @override
  List<Object?> get props => [...idols];
}

class IdolsError extends IdolsState {}

//events
enum IdolsEvent {
  init,
  refresh,
}
