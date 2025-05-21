import 'package:flutter_bloc/flutter_bloc.dart';

part 'acls_state.dart';

enum AclsStatus {
  uninitialized,
  loading,
  loaded,
  error,
}

class AclsCubit extends Cubit<AclsState> {
  AclsCubit() : super(const AclsState());
}
