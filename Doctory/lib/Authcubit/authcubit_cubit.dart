import 'package:bloc/bloc.dart';
import 'package:doctory/services/auth_services.dart';
part 'authcubit_state.dart';

class AuthcubitCubit extends Cubit<AuthcubitState> {
  AuthcubitCubit() : super(AuthInitial());

  final AuthServices authServices = AuthServiceImpl();

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    emit(AuthLoading());
    try {
      final result = await authServices.loginWithEmailAndPassword(email, password);
      if (result) {
        emit(const AuthDone());
      } else {
        emit(const AuthError("Email or Password is incorrect"));
      }
    } catch (e) {
      emit(const AuthError("Email or Password is incorrect"));
    }
  }

  Future<void> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String fullName,
  }) async {
    emit(AuthLoading());
    try {
      final result = await authServices.registerWithEmailAndPassword(
        email: email,
        password: password,
        fullName: fullName,
      );
      if (result) {
        emit(const AuthDone());
      } else {
        emit(const AuthError("Something May Be Wrong"));
      }
    } catch (e) {
      print("Something May Be Wrong");
    }
  }
}
