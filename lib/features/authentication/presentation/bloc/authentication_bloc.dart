import 'package:api_integration/features/authentication/presentation/bloc/events.dart';
import 'package:api_integration/features/authentication/presentation/bloc/stats.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  AuthBloc(this._firebaseAuth, this._googleSignIn) : super(AuthInitial()) {
    _firebaseAuth.authStateChanges().listen((user) {
      add(AuthStatusChanged(user));
    });

    on<AuthStatusChanged>((event, emit) {
      if (event.user != null) {
        emit(Authenticated(event.user!));
      } else {
        emit(Unauthenticated());
      }
    });

    on<SignUpRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await _firebaseAuth.createUserWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
      } on FirebaseAuthException catch (e) {
        emit(AuthFailure(e.message ?? "Sign Up Failed"));
      } catch (e) {
        emit(AuthFailure("Something went wrong: ${e.toString()}"));
      }
    });

    on<SignInRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await _firebaseAuth.signInWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
      } on FirebaseAuthException catch (e) {
        emit(AuthFailure(e.message ?? "Sign In Failed"));
      } catch (e) {
        emit(AuthFailure("Something went wrong: ${e.toString()}"));
      }
    });

    on<SignOutRequested>((event, emit) async {
      await _firebaseAuth.signOut();
      await _googleSignIn.signOut();
    });

    on<GoogleSignInRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        // Trigger the authentication flow
        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

        if (googleUser == null) {
          // User cancelled the sign-in
          emit(Unauthenticated());
          return;
        }

        // Obtain the auth details from the request
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        // Sign in to Firebase with the Google credential
        await _firebaseAuth.signInWithCredential(credential);
      } on FirebaseAuthException catch (e) {
        emit(AuthFailure(e.message ?? "Google Sign In Failed"));
      } catch (e) {
        emit(AuthFailure("Something went wrong: ${e.toString()}"));
      }
    });
  }
}
