import 'package:bloc/bloc.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollections);
  List<Message> messagesList = [];

  void sendMessage({required String email, required String message}) {
    try {

      messages.add({
        kMessage: message,
        kCreatedAt: DateTime.now(),
        "id": email,
      });
    } on Exception catch (e) {

    }
  }


  void getMessages()
  {
    messages.orderBy(kCreatedAt,descending: true).snapshots().listen((event) {
     messagesList.clear();
      for(var doc in event.docs){
        messagesList.add(Message.fromJson(doc));
      }
      emit(ChatSuccess(messages: messagesList));
    });
  }
}
