import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_app/constants.dart';
import 'package:scholar_app/core/utils/app_router.dart';
import 'package:scholar_app/helper/show_snack_bar.dart';
import 'package:scholar_app/widgets/custom_button.dart';
import 'package:scholar_app/widgets/custom_text_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  GlobalKey<FormState> formKey = GlobalKey();

  String? email, password;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor:kPraimaryColor,

        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                SizedBox(height: 60),

                Image.asset('assets/images/scholar.png', height: 100),
                Text(
                  'Scholar Chat',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontFamily: 'Pacifico',
                  ),
                ),
                SizedBox(height: 75),
                Row(
                  children: [
                    Text(
                      'LOGIN',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                CustomTextFormField(
                  onChanged: (data) {
                    email = data;
                  },
                  text: 'Email',
                ),
                SizedBox(height: 10),

                CustomTextFormField(
                  obscureText: true,
                  onChanged: (data) {
                    password = data;
                  },
                  text: 'Password',
                ),
                SizedBox(height: 10),

                CustomButton(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        await loginUser();
                        GoRouter.of(context).push(AppRouter.kChatView, extra: email);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          showSnackBar(
                            context,
                            'No user found for that email.',
                          );
                        } else if (e.code == 'wrong-password') {
                          showSnackBar(
                            context,
                            'Wrong password provided for that user.',
                          );
                        }
                      } catch (e) {
                        showSnackBar(context, 'there was an error');
                      }
                      isLoading = false;
                      setState(() {});
                    } else {}
                  },
                  text: 'LOGIN',
                ),
                SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'dont have an account',
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        GoRouter.of(context).push(AppRouter.kRegisterView);
                      },
                      child: Text(
                        '  Register',
                        style: TextStyle(color: Color(0xffc7ede6)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    var auth = FirebaseAuth.instance;
    UserCredential user = await auth.signInWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
