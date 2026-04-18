import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SocialAuthException implements Exception {
  final String message;

  const SocialAuthException(this.message);

  @override
  String toString() => 'SocialAuthException: $message';
}

class SocialAuthService {
  SocialAuthService._();

  static final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  static Future<String?> signInWithGoogleAndGetFirebaseToken() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      return null;
    }

    final googleAuth = await googleUser.authentication;
    final googleIdToken = googleAuth.idToken;

    if (googleIdToken == null || googleIdToken.isEmpty) {
      throw const SocialAuthException(
        'Unable to get Google authentication token.',
      );
    }

    final credential = GoogleAuthProvider.credential(
      idToken: googleIdToken,
      accessToken: googleAuth.accessToken,
    );

    final userCredential = await FirebaseAuth.instance.signInWithCredential(
      credential,
    );

    final firebaseToken = await userCredential.user?.getIdToken(true);
    if (firebaseToken == null || firebaseToken.isEmpty) {
      throw const SocialAuthException('Unable to get Firebase token.');
    }

    return firebaseToken;
  }
}
