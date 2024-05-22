import 'package:dashboard_rpm/exceptions/custom_exception.dart';
import 'package:dashboard_rpm/providers/auth_state.dart';
import 'package:dashboard_rpm/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:state_notifier/state_notifier.dart';

class AuthProvideres extends StateNotifier<AuthState> with LocatorMixin {
  AuthProvideres() : super(AuthState.init());

  @override
  void update(Locator watch) {
    final user = watch<User?>();

    if (user != null && !user.emailVerified){
      return;
    }

    if (user == null && state.authStatus == AuthStatus.unauthenticated) {
      return;
    }

    if (user != null){
      state = state.copyWith(
        authStatus: AuthStatus.authenticated,
      );
    } else {
      state = state.copyWith(
        authStatus: AuthStatus.unauthenticated,
      );
    }
  }

  Future<void> signOut() async{
    await read<AuthRepository>().signOut();
  }

  Future<void> signUp({
    required String email,
    required String nickName,
    required String password,
  }) async {
    try {
      await read<AuthRepository>().signUp(
          email: email,
          nickName: nickName,
          password: password
      );
    } on CustomException catch (_) {
      rethrow;
    }
  }
  
  Future<void> signIn({
    required String email,
    required String password,
}) async{
    try {
      await read<AuthRepository>().signIn(
          email: email,
          password: password,
      );
    } on CustomException catch (_) {
      rethrow;
    }
  }
}
