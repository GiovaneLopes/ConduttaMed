import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:condutta_med/modules/home/home_routes.dart';

class AppBloc extends Cubit<bool> {
  AppBloc() : super(true) {
    initialize();
  }

  void initialize() async {
    await Future.delayed(const Duration(seconds: 3));
    HomeRoutes.home.navigate();
  }
}
