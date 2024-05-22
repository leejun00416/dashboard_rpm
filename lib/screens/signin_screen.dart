import 'package:dashboard_rpm/exceptions/custom_exception.dart';
import 'package:dashboard_rpm/providers/auth_provider.dart';
import 'package:dashboard_rpm/providers/auth_state.dart';
import 'package:dashboard_rpm/screens/signup_screen.dart';
import 'package:dashboard_rpm/utils/logger.dart';
import 'package:dashboard_rpm/widgets/error_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  TextEditingController _emailEditingController = TextEditingController();
  TextEditingController _passwordEditingController = TextEditingController();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  bool _isEnabled = true;

  @override
  void dispose() {
    _emailEditingController = TextEditingController();
    _passwordEditingController = TextEditingController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Form(
                key: _globalKey,
                autovalidateMode: _autovalidateMode,
                child: ListView(
                  shrinkWrap: true,
                  reverse: true,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        "로그인",
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),

                    SizedBox(height: 60),

                    // 이메일
                    TextFormField(
                      enabled: _isEnabled,
                      controller: _emailEditingController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Email",
                          prefixIcon: Icon(Icons.email),
                          filled: true),
                      validator: (value) {
                        // 아무것도 입력하지 않았을 때
                        // 공백만 입력했을 때
                        // 이메일 형식이 아닐 때
                        if (value == null ||
                            value.trim().isEmpty ||
                            !isEmail(value.trim())) {
                          return '이메일을 입력해주세요.';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),

                    // 패스워드
                    TextFormField(
                      enabled: _isEnabled,
                      controller: _passwordEditingController,
                      obscureText: true,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Password",
                          prefixIcon: Icon(Icons.lock),
                          filled: true),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return '비밀번호를 입력해주세요.';
                        }
                        if (value.length < 8) {
                          return '패스워드는 8글자 이상 입력해주세요.';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),

                    ElevatedButton(
                      onPressed: _isEnabled
                          ? () async {
                              final form = _globalKey.currentState;

                              if (form == null || !form.validate()) {
                                return;
                              }

                              setState(() {
                                _isEnabled = false;
                                _autovalidateMode = AutovalidateMode.always;
                              });

                              // 로그인 로직
                              try {

                                logger.d(context.read<AuthState>().authStatus);

                                await context.read<AuthProvideres>().signIn(
                                      email: _emailEditingController.text,
                                      password: _passwordEditingController.text,
                                    );
                              } on CustomException catch (e) {
                                setState(() {
                                  _isEnabled = true;
                                });
                                errorDialogWidget(context, e);
                              }
                            }
                          : null,
                      child: Text('로그인'),
                      style: ElevatedButton.styleFrom(
                        textStyle: TextStyle(fontSize: 20),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                    SizedBox(height: 10),

                    TextButton(
                      onPressed: _isEnabled
                          ? () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignupScreen(),
                              ))
                          : null,
                      child: Text(
                        '회원이 아니신가요? 회원가입 하기',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ].reversed.toList(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
