import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:limeric_task/repos/userRepo.dart';
import 'package:limeric_task/screen/productScreen.dart';

import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_event.dart';
import '../blocs/auth/auth_state.dart';
import '../blocs/product/product_bloc.dart';
import '../constants/strings.dart';
import '../constants/urls.dart';
import '../utils/customInputField.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController edtEmailController = TextEditingController();

  final TextEditingController edtPasswordController = TextEditingController();

  bool isChecked = false;
  bool isBtnEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Limerick BD')),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is Authenticated) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => BlocProvider.value(
                value: context.read<ProductListBloc>(),
                child: ProductListScreen(),
              ),
            ));
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 100),
                    Placeholder(
                        fallbackHeight:100,
                        fallbackWidth:100,
                        child: Image.network(logoURL, height: 100
                          ,width:100,
                          fit: BoxFit.fill,)
                    ),
                    const SizedBox(height: 20,),
                    CustomInputField(edtController: edtEmailController, labelText: strEmail, inputType: TextInputType.emailAddress),
                    const SizedBox(height: 20,),
                    CustomInputField(edtController: edtPasswordController, labelText: strPassword, isPassword: true,),
                    const SizedBox(height: 20,),
                    Row(
                      children: [
                        Checkbox(
                          value: isChecked,
                          tristate: true,
                          checkColor: Colors.blue,
                          onChanged: (bool? value) {
                            print("value ${value}");

                            setState(() {
                              isChecked = value?? false;
                            });
                            print("checked ${isChecked}");
                          },
                        ),
                        const Expanded(
                          child: Text(strCheckAgreement, style: TextStyle(
                            overflow: TextOverflow.clip,
                          ),softWrap: true,),
                        ),
                      ],

                    ),

                    ElevatedButton(
                      onPressed: isChecked && edtEmailController.text.isNotEmpty && edtPasswordController.text.isNotEmpty?() {
                        final username = edtEmailController.text;
                        final password = edtPasswordController.text;

                        if (username.isNotEmpty && password.isNotEmpty) {
                          context.read<AuthBloc>().add(
                            LoggedIn(
                              username: username,
                              password: password,
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Please fill in all fields')),
                          );
                        }
                      }:null,
                      child: const Text(strSignIn),
                    ),
                  ],
                ),
              );
          },
        ),
      ),
    );
  }
}
