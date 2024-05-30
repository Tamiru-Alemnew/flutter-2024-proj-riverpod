import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:family_cash_manager/presentation/widgets/custom/my_button.dart';
import 'package:family_cash_manager/util/text.dart';
import 'package:family_cash_manager/application/providers/user_provider.dart';


class LoginPage extends ConsumerWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userProvider);
    final userNotifier = ref.read(userProvider.notifier);

    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    String _errorMessage = '';

    void _login() {
      final email = _emailController.text;
      final password = _passwordController.text;
      userNotifier.userLogin(email, password);
    }

    if (userState is UserAuthenticated) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushNamed(context, '/home');
      });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 25),
              child: Column(
                children: [
                  TextWidget(
                    text: 'Log in to FamilyCash Manager',
                    fontWeight: FontWeight.bold,
                    size: 18,
                  ),
                  SizedBox(height: 25),
                  TextWidget(
                    text:
                        'Welcome back! Sign in using your email to continue with us 🥰',
                    family: 'Circular Std',
                    color: Color.fromARGB(255, 121, 124, 123),
                  ),
                  SizedBox(height: 26),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(thickness: 1),
                      ),
                      Expanded(
                        child: Divider(thickness: 1),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  TextField(
                    key : Key("emailField"),
                    controller: _emailController,
                    decoration: InputDecoration(
                      label: TextWidget(
                        text: 'Your email',
                        color: const Color.fromARGB(255, 36, 120, 109),
                        family: 'Circular Std',
                        fontWeight: FontWeight.bold,
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 10.0),
                    ),
                    style: const TextStyle(
                      fontFamily: 'Caros',
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    key: Key('passwordField'),
                    controller: _passwordController,
                    obscureText: true,
                    obscuringCharacter: '*',
                    decoration: InputDecoration(
                      label: TextWidget(
                        text: 'Password',
                        color: const Color.fromARGB(255, 36, 120, 109),
                        family: 'Circular Std',
                        fontWeight: FontWeight.bold,
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 10.0),
                    ),
                    style: const TextStyle(
                      fontFamily: 'Caros',
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 20),
                  userState is UserError
                      ? Text(
                          userState.error,
                          style: TextStyle(color: Colors.red),
                        )
                      : SizedBox.shrink(),
                  SizedBox(height: 20),
                  userState is UserInitial
                      ? MyButton(onPressed: _login)
                      : userState is UserLoading
                          ? CircularProgressIndicator()
                          : userState is UserError
                              ? MyButton(onPressed: _login)
                              : SizedBox.shrink(),
                  SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/signUp');
                    },
                    child: TextWidget(
                      text: "Don't have Account? Create Account",
                      family: 'Circular Std',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
