import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rust/bridge_generated.dart/frb_generated.dart';
import 'counter_event.dart';
import 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterState(0)) {
    on<IncrementPressed>((event, emit) async {
      final newCount = await RustLib.instance.api.crateApiIncrementCounter();
      emit(CounterState(newCount.toInt()));
    });

    on<DecrementPressed>((event, emit) async {
      final newCount = await RustLib.instance.api.crateApiDecrementCounter();
      emit(CounterState(newCount.toInt()));
    });
  }
}
