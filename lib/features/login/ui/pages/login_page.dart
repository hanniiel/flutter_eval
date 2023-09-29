import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_eval/features/login/ui/bloc/cubit_login.dart';
import 'package:flutter_eval/features/shared/ui/widgets/button_widget.dart';
import 'package:flutter_eval/features/shared/ui/widgets/input_widget.dart';
import 'package:flutter_eval/features/shared/utils/validators.dart';

class LoginPage extends StatelessWidget {
  static const String id = 'LoginView';

  LoginPage({Key? key}) : super(key: key);

  final _form = GlobalKey<FormState>();

  String? _email, _pass;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///Using same page for login and signup by using a state for it isRegister ;)
      body: BlocBuilder<CubitLogin, LoginState>(
        builder: (_, state) {
          return SafeArea(
            minimum: const EdgeInsets.symmetric(horizontal: 24),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    !state.isRegister ? 'Sign In' : 'Register',
                    // I prefer using constants for color, themes but ignored that to be asap
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 80),
                  Form(
                    key: _form,
                    child: Column(
                      children: [
                        InputWidget(
                          hint: 'Enter your email address',
                          title: 'Email address',
                          onChanged: (email) => _email = email,
                          onValidate: (val) {
                            if (val == null || val.isEmpty) {
                              return 'Email required';
                            } else if (!isValidEmail(val)) {
                              return 'Wrong email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 18),
                        InputWidget(
                            hint: 'Enter your password',
                            title: 'Password',
                            textType: TextInputType.visiblePassword,
                            onChanged: (pass) => _pass = pass,
                            onValidate: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Password required';
                              }
                              if (val.length < 8) {
                                return 'Password length must be at least 8 characters';
                              }
                              return null;
                            }),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox.adaptive(
                              side: const BorderSide(),
                              visualDensity: const VisualDensity(
                                horizontal: VisualDensity.minimumDensity,
                                vertical: VisualDensity.minimumDensity,
                              ),
                              value: state.rememberMe,
                              onChanged: (val) =>
                                  context.read<CubitLogin>().rememberMe(),
                            ),
                            const Text('Remember me'),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                  const SizedBox(height: 80),
                  if (state.message != null)
                    Text(
                      '${state.message}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  const SizedBox(height: 10),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 16),
                      ButtonWidget(
                        text: !state.isRegister ? 'Sign In' : 'Register',
                        onTap: state.loading
                            ? null
                            : () {
                                if (_form.currentState!.validate()) {
                                  if (state.isRegister) {
                                    context.read<CubitLogin>().register(
                                          email: _email!,
                                          password: _pass!,
                                        );
                                  } else {
                                    context.read<CubitLogin>().login(
                                          email: _email!,
                                          password: _pass!,
                                        );
                                  }
                                }
                              },
                      ),
                      const SizedBox(height: 24),
                      InkWell(
                        onTap: () => context.read<CubitLogin>().isRegister(),
                        child: Text(!state.isRegister ? 'Register' : 'Login'),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
