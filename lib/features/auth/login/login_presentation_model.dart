import 'package:dartz/dartz.dart';
import 'package:flutter_demo/core/domain/model/user.dart';
import 'package:flutter_demo/core/utils/bloc_extensions.dart';
import 'package:flutter_demo/features/auth/domain/model/log_in_failure.dart';
import 'package:flutter_demo/features/auth/login/login_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class LoginPresentationModel implements LoginViewModel {
  /// Creates the initial state
  LoginPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    LoginInitialParams initialParams,
  )   : loginResult = const FutureResult.empty(),
        name = '',
        pas = '';

  LoginPresentationModel._({
    required this.name,
    required this.pas,
    required this.loginResult,
  });

  final String name;

  final String pas;

  final FutureResult<Either<LogInFailure, User>> loginResult;

  @override
  bool get logInButtonEnabled => password.isNotEmpty && username.isNotEmpty;

  @override
  String get password => pas;

  @override
  String get username => name;

  @override
  bool get isLoading => loginResult.isPending();

  LoginPresentationModel copyWith({
    String? name,
    String? pas,
    FutureResult<Either<LogInFailure, User>>? loginResult,
  }) {
    return LoginPresentationModel._(
      name: name ?? this.name,
      pas: pas ?? this.pas,
      loginResult: loginResult ?? this.loginResult,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class LoginViewModel {
  bool get logInButtonEnabled;

  String get username;

  String get password;

  bool get isLoading;
}
