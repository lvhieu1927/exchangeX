import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:exchangex/blocs/states/LoginState.dart';
import '../util/loginlogic.dart';
import 'events/LoginEvent.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginLogic logic;

  LoginBloc({required this.logic}) : super(InitialLoginState());

  @override
  LoginState get initialState => InitialLoginState();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is DoLoginEvent) {
      yield* _doLogin(event);
    }
  }

  Stream<LoginState> _doLogin(DoLoginEvent event) async* {
    yield LoggingInState();

    try {
      var token = await logic.login(event.email, event.password);
      yield LoggedInState(token!);
    } on LoginException {
      yield ErrorState("Không thể đăng nhập");
    }
  }
}