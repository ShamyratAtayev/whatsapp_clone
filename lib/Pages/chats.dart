import 'package:flutter/material.dart';
import 'package:whatsapp/customUI/customCard.dart';
import 'package:whatsapp/model/chatmodel.dart';

class ChatsPage extends StatefulWidget {
  @override
  _ChatsPageState createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {

  List<ChatModel> chats = [
    ChatModel(
      name: "Sham", isGroup: true, currentMessage: "How r u?", time: "4:00", icon: "groups.svg"
    ),
    ChatModel(
      name: "Dev", isGroup: false, currentMessage: "H u d?", time: "4:84", icon: "person.svg"
    ),
    ChatModel(
      name: "Mehmet", isGroup: false, currentMessage: "H u Mehmet?", time: "5:45", icon: "person.svg"
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.chat),
      ),
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (contex, index) => CustomCard(chatModel: chats[index]),
      ),
    );
  }
}