// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:whatsapp/Pages/individualPage.dart';
import 'package:whatsapp/model/chatmodel.dart';


class CustomCard extends StatelessWidget {

  final ChatModel chatModel;
  
  CustomCard({required this.chatModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => IndividualPage(chatModel: chatModel,)),
        );
      },
      child: ListTile(
        leading: CircleAvatar(
          radius: 23,
          child: SvgPicture.asset(
            chatModel.isGroup ? "assets/groups.svg" : "assets/person.svg",
            color: Colors.white,
            height: 30,
            width: 30,
            ),
          backgroundColor: Colors.blueGrey,
        ),
        trailing: Text((chatModel.time).toString()),
        title: Text((chatModel.name).toString(), style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold
          )
        ),
        subtitle: Row(
          children: [
            Icon(Icons.done_all),
            SizedBox(width: 3),
            Text(
              (chatModel.currentMessage).toString(),
              style: TextStyle(
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}