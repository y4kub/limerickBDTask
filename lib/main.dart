import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:limeric_task/repos/productRepo.dart';
import 'package:limeric_task/repos/userRepo.dart';
import 'package:limeric_task/screen/loginScreen.dart';
import 'package:limeric_task/screen/productScreen.dart';

import 'blocs/auth/auth_bloc.dart';
import 'blocs/auth/auth_event.dart';
import 'blocs/auth/auth_state.dart';
import 'blocs/product/product_bloc.dart';
import 'blocs/product/product_event.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository = AuthRepository();
  final ProductRepository productRepository = ProductRepository();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(authRepository: authRepository)..add(AppStarted()),
        ),
        BlocProvider<ProductListBloc>(
          create: (context) => ProductListBloc(
            authRepository: authRepository,
            productRepository: productRepository,
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is Authenticated) {
              context.read<ProductListBloc>().add(LoadProductList());
              return ProductListScreen();
            } else if (state is AuthUnauthenticated) {
              return LoginScreen();
            } else {
              return Center(child: Text('Something went wrong!'));
            }
          },
        ),
      ),
    );
  }
}
