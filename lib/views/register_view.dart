import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_app/constants.dart';
import 'package:scholar_app/core/utils/app_router.dart';
import 'package:scholar_app/helper/show_snack_bar.dart';
import 'package:scholar_app/widgets/custom_button.dart';
import 'package:scholar_app/widgets/custom_text_field.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  String? email, password;

  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor:kPraimaryColor,

        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
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
                      'REGISTER',
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
                        await registerUser();
                        showSnackBar(context, 'Success');
                        GoRouter.of(context).push(AppRouter.kChatView,extra: email);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          showSnackBar(
                            context,
                            'The password provided is too weak.',
                          );
                        } else if (e.code == 'email-already-in-use') {
                          showSnackBar(
                            context,
                            'The account already exists for that email.',
                          );
                        }
                      } catch (e) {
                        showSnackBar(context, 'there was an error');
                      }
                      isLoading = false;
                      setState(() {});
                    } else {}
                  },
                  text: 'REGISTER',
                ),
                SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'already have an account?',
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        '  Login',
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

  Future<void> registerUser() async {
    var auth = FirebaseAuth.instance;
    UserCredential user = await auth.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
