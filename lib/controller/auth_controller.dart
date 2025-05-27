import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// ✅ Register with Email & Password
  Future<void> registerWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'email': user.email,
        });
        print("User registered and data stored in Firestore");
      }
    } catch (e) {
      print("Registration error: $e");
      Get.snackbar("Error", "Registration failed: $e");
    }
  }

  /// ✅ Sign In with Google
  Future<bool> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return false;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await _auth.signInWithCredential(credential);
      User? user = userCredential.user;

      if (user != null) {
        final docRef = _firestore.collection('users').doc(user.uid);
        final docSnapshot = await docRef.get();

        // Store uid and email if not already stored
        if (!docSnapshot.exists) {
          await docRef.set({
            'uid': user.uid,
            'email': user.email,
          });
        }

        print("Google Sign-in success and user data saved.");
        return true;
      }

      return false;
    } catch (e) {
      print("Google sign-in error: $e");
      Get.snackbar("Error", "Google sign-in failed: $e");
      return false;
    }
  }
}
