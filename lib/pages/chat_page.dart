import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/pages/cubit/chat_cubit/chat_cubit.dart';
import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/widgets/custom_chat_buble.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatelessWidget {
  static String id = "ChatPage";

  final _controller = ScrollController();

  String? data;
  List<Message> messagesList = [];


  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    dynamic email = ModalRoute
        .of(context)!
        .settings
          .arguments;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              kLogo,
              height: 50,
            ),
            const Text(
              "Chat",
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                var messagesList = BlocProvider.of<ChatCubit>(context).messagesList;
                return ListView.builder(
                    reverse: true,
                    controller: _controller,
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) {
                      return messagesList[index].id == email
                          ? ChatBuble(message: messagesList[index])
                          : ChatBubleForFriend(message: messagesList[index]);
                    });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              controller: controller,
              onFieldSubmitted: (data) {
                BlocProvider.of<ChatCubit>(context).sendMessage(email: email, message: data);
                controller.clear();
                _controller.animateTo(
                  _controller.position.maxScrollExtent,
                  duration: Duration(microseconds: 500),
                  curve: Curves.fastOutSlowIn,
                );
              },
              decoration: InputDecoration(
                hintText: "Send Message",
                suffixIcon: Icon(
                  Icons.send,
                  color: Color(0xff7C9070),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Color(0xff7C9070)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
