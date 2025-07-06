import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final auth = FirebaseAuth.instance;

  Future<User> login({required String email, required String password}) async {
    final userCredential = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user!;
  }

  Future<User> register({
    required String email,
    required String password,
    required String name,
  }) async {
    final userCredential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await userCredential.user!.updateDisplayName(name);
    await userCredential.user!.reload();

    return userCredential.user!;
  }


  Future<User?> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      throw Exception('Google sign in was cancelled');
    }
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final userCredential = await FirebaseAuth.instance.signInWithCredential(
      credential,
    );
    return userCredential.user;
  }
}
