import 'package:flutter_demo/features/auth/domain/model/log_in_failure.dart';
import 'package:flutter_demo/features/auth/login/login_initial_params.dart';
import 'package:flutter_demo/features/auth/login/login_presentation_model.dart';
import 'package:flutter_demo/features/auth/login/login_presenter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test_utils/test_utils.dart';
import '../mocks/auth_mock_definitions.dart';
import '../mocks/auth_mocks.dart';

void main() {
  late LoginPresentationModel model;
  late LoginPresenter presenter;
  late MockLoginNavigator navigator;

  test(
    'should show error when logIn fails',
    () async {
      when(() => AuthMocks.logInUseCase.execute(password: any(named: "password"), username: any(named: 'username')))
          .thenAnswer((_) => failFuture(const LogInFailure.unknown()));
      when(() => navigator.showError(any())).thenAnswer((_) => Future.value());

      // WHEN
      await presenter.logInClicked();

      // THEN
      verify(() => navigator.showError(any()));
    },
  );

  setUp(() {
    model = LoginPresentationModel.initial(const LoginInitialParams());
    navigator = MockLoginNavigator();
    presenter = LoginPresenter(
      model,
      navigator,
      AuthMocks.logInUseCase,
    );
  });
}
