import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
import 'package:visionhr/view/onbording_screen/onbording_screen.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ✅ Email/Password Signup
  Future<void> registerWithEmail(String email, String password) async {
    await _auth.createUserWithEmailAndPassword(email: email, password: password);
  }


  // ✅ Google Sign-In
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        // User cancelled
        return;
      }

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);

      Get.snackbar("Success", "Signed in with Google");
      Get.to(Onboarding_Screen());
    } catch (e) {
      Get.snackbar("Error", "Google sign-in failed: $e");
    }
  }

  // ✅ Apple Sign-In
  void signInWithApple() {
    // TODO: Add actual Apple Sign-In logic
    print("Apple Sign-In");
  }

  // ✅ Facebook Sign-In
  void signInWithFacebook() {
    // TODO: Add actual Facebook Sign-In logic
    print("Facebook Sign-In");
  }
}
