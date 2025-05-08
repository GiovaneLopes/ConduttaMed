import 'package:condutta_med/libs/src/exceptions/app_error.dart';

class AppGenericErrors extends AppError {
  AppGenericErrors({
    required super.title,
    required super.message,
  });

  static final noConnectionError = AppGenericErrors(
    title: 'Sem Conexão',
    message: 'Dispositivo sem conexão com a internet.',
  );

  static final genericError = AppGenericErrors(
    title: 'Tivemos um problema',
    message: 'Por favor, tente novamente em instantes.',
  );
}
