import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:condutta_med/modules/auth/bloc/auth_cubit.dart';

part './home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final AuthCubit authCubit;
  HomeCubit({required this.authCubit}) : super(const HomeState()) {
    authCubit.stream.listen((AuthState state) {
      if (state.status == AuthStatus.authenticated) {
        contentUpdated(0);
      }
    });
  }

  void contentUpdated(int index) {
    emit(state.copyWith(currentTab: index));
  }
}
