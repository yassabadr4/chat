import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/helper/show_snack_bar%5D.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/cubit/auth_cubit/auth_cubit.dart';
import 'package:chat_app/pages/cubit/chat_cubit/chat_cubit.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../widgets/custom_text_field.dart';


class LoginPage extends StatelessWidget {
  LoginPage({super.key});


  String? email, password;

  bool isLoading = false;
  static String id = "LoginPage";
  GlobalKey<FormState> formKey = GlobalKey();


  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if(state is LoginLoading)
        {
          isLoading = true;
        }else if(state is LoginSuccess ){
          BlocProvider.of<ChatCubit>(context).getMessages();
          Navigator.pushNamed(context, ChatPage.id,arguments: email);
          isLoading=false;
        }else if(state is LoginFailure){
          showSnackBar(context, state.errorMessage);
          isLoading=false;
        }
      },
      child: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  const SizedBox(height: 75,),
                  Image.asset(kLogo, height: 150,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedTextKit(
                        animatedTexts: [
                          WavyAnimatedText('Chat App', textStyle: TextStyle(
                            fontSize: 32,
                            color: Colors.black,
                            fontFamily: "Pacifico",
                          ),
                          ),
                          WavyAnimatedText('Sign in Now', textStyle: TextStyle(
                            fontSize: 32,
                            color: Colors.black,
                            fontFamily: "Pacifico",
                          ),
                          ),
                        ],
                        repeatForever: true,
                        pause: Duration(seconds: 3),
                        isRepeatingAnimation: true,
                      ),
                      SizedBox(height: 75,),
                    ],
                  ),
                  const Row(
                    children: [
                      Text(
                        "LOGIN",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomFormTextField(
                    onChanged: (data) {
                      email = data;
                    },
                    labelText: "Email",
                    hintText: "Enter your Email",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomFormTextField(
                    obScure: true,
                    onChanged: (data) {
                      password = data;
                    },

                    labelText: "Password",
                    hintText: "Enter your Password",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                      text: "LOGIN",
                      onTap: () async
                      {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<AuthCubit>(context).loginUser(email: email!, password: password!);
                        } else {}
                      }
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account ?",
                        style: TextStyle(color: Colors.black),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RegisterPage.id);
                        },
                        child: const Text(
                          "  Register Now",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
        email: email!, password: password!);
  }
}




