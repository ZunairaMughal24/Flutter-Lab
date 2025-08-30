
import 'package:api_integration/features/authentication/presentation/bloc/events.dart';
import 'package:api_integration/features/authentication/presentation/bloc/stats.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _firebaseAuth;

  AuthBloc(this._firebaseAuth) : super(AuthInitial()) {
    // ✅ Listen to Firebase Auth changes and trigger AuthStatusChanged
    _firebaseAuth.authStateChanges().listen((user) {
      add(AuthStatusChanged(user));
    });

    // ✅ Handle AuthStatusChanged
    on<AuthStatusChanged>((event, emit) {
      if (event.user != null) {
        emit(Authenticated(event.user!)); // user is signed in
      } else {
        emit(Unauthenticated()); // user is signed out
      }
    });

    // ✅ Sign Up
    on<SignUpRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await _firebaseAuth.createUserWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        // No need to emit success manually, authStateChanges() will fire
      } on FirebaseAuthException catch (e) {
        emit(AuthFailure(e.message ?? "Sign Up Failed"));
      } catch (e) {
        emit(AuthFailure("Something went wrong: ${e.toString()}"));
      }
    });

    // ✅ Sign In
    on<SignInRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await _firebaseAuth.signInWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        // No need to emit success manually, authStateChanges() will fire
      } on FirebaseAuthException catch (e) {
        emit(AuthFailure(e.message ?? "Sign In Failed"));
      } catch (e) {
        emit(AuthFailure("Something went wrong: ${e.toString()}"));
      }
    });

    // ✅ Sign Out
    on<SignOutRequested>((event, emit) async {
      await _firebaseAuth.signOut();
      // No need to emit manually, authStateChanges() will fire Unauthenticated
    });
  }
}
