import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthServices {
  Future<bool> loginWithEmailAndPassword(String email, String password);

  Future<bool> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String fullName,
  });
}

class AuthServiceImpl implements AuthServices {
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<bool> loginWithEmailAndPassword(String email, String password) async {
    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user != null;
  }

  @override
  Future<bool> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try{
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    }catch(e){
      print("############");
      print(e.toString()); return false;}

      return true;
   // return userCredential.user != null;
  }
}
