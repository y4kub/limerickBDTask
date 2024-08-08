import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:limeric_task/repos/productRepo.dart';
import '../../model/userModel.dart';
import '../../repos/userRepo.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc( {required this.authRepository}) : super(AuthInitial()) {
    on<AppStarted>(_onAppStarted);
    on<LoggedIn>(_onLoggedIn);
    on<LoggedOut>(_onLoggedOut);
    //  on<LoadUserData>(_onLoadUserData);
  }

  void _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    final hasToken = await authRepository.hasToken();
    if (hasToken) {
      emit(Authenticated(user: User(token: '')));
    } else {
      emit(AuthUnauthenticated());
    }
  }

  void _onLoggedIn(LoggedIn event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.login(event.username, event.password);
      await authRepository.storeToken(user.token);
      emit(Authenticated(user: user));
    } catch (error) {
      emit(AuthError(message: error.toString()));
    }
  }
  // void _onLoadUserData(LoadUserData event, Emitter<AuthState> emit) async {
  //   final token = await authRepository.getToken();
  //   final ProductRepository productList =  ProductRepository();
  //   if (token != null) {
  //     try {
  //       // Assuming you have a method to fetch user data using the token
  //       final userData = await productList.fetchProductList(token);
  //       emit(LoadUserData());
  //     } catch (error) {
  //       emit(AuthError(message: 'Failed to load user data.'));
  //     }
  //   } else {
  //     emit(AuthUnauthenticated());
  //   }
  // }

  void _onLoggedOut(LoggedOut event, Emitter<AuthState> emit) async {
    await authRepository.logout();
    emit(AuthUnauthenticated());
  }
}
