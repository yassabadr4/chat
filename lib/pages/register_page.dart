import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/helper/show_snack_bar%5D.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/cubit/auth_cubit/auth_cubit.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';


class RegisterPage extends StatelessWidget {
  static String id = "RegisterPage";
  String? email, password;


  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if(state is RegisterLoading)
        {
          isLoading = true;
        }else if(state is RegisterSuccess ){
          Navigator.pushNamed(context, ChatPage.id,arguments: email);
          isLoading=false;
        }else if(state is RegisterFailure){
          showSnackBar(context, state.errorMessage);
          isLoading=false;
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            backgroundColor: kPrimaryColor,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Form(
                key: formKey,
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 75,
                    ),
                    Image.asset(kLogo, height: 150),
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
                            WavyAnimatedText('Sign Up', textStyle: TextStyle(
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
                        // Text(
                        //   "Chat",
                        //   style: TextStyle(
                        //     fontSize: 32,
                        //     color: Colors.black,
                        //     fontFamily: "Pacifico",
                        //   ),
                        // ),
                        SizedBox(
                          height: 75,
                        ),
                      ],
                    ),
                    const Row(
                      children: [
                        Text(
                          "REGISTER",
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
                      labelText: "Email",
                      onChanged: (data) {
                        email = data;
                      },
                      hintText: "Enter your Email",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomFormTextField(
                      obScure: true,
                      labelText: "Password",
                      onChanged: (data) {
                        password = data;
                      },
                      hintText: "Enter your Password",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                      text: "REGISTER",
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<AuthCubit>(context).registerUser(
                              email: email!, password: password!);
                        } else {}
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "already have an account !",
                          style: TextStyle(color: Colors.black),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "  Login Now",
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
        );
      },
    );
  }


  Future<void> registerUser() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
        email: email!, password: password!);
  }
}
