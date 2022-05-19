// ignore_for_file: file_names, prefer_const_constructors

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatsapp/model/chatmodel.dart';

class IndividualPage extends StatefulWidget {

  final ChatModel chatModel;
  
  IndividualPage({required this.chatModel});
  
  @override
  _IndividualPageState createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  bool isEmoji = false;
  FocusNode focusNode = new FocusNode();
  TextEditingController _controller = new TextEditingController();

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          isEmoji = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 70,
        titleSpacing: 5,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.arrow_back,
                size: 24,
              ),
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.blueGrey[300],
                child: SvgPicture.asset(
                  widget.chatModel.isGroup ? "assets/groups.svg" : "assets/person.svg",
                  color: Colors.white,
                  height: 30,
                  width: 30,
                ),
              ),
            ],
          ),
        ),
        title: InkWell(
          onTap: (){},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text (
                (widget.chatModel.name).toString(),
                style: TextStyle(
                  fontSize: 18.5,
                  fontWeight: FontWeight.bold
                ),
              ),
              Text (
                "last seen today at 13:25",
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: (){}, 
            icon: Icon(Icons.videocam)
          ),
          IconButton(
            onPressed: (){}, 
            icon: Icon(Icons.call)
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              print(value);
            },
            itemBuilder: (BuildContext context){
            return [
              PopupMenuItem(
                child: Text("View Contact"),
                value: "View Contact",
              ),
              PopupMenuItem(
                child: Text("Media, links, and docs"),
                value: "Media, links, and docs",
              ),
              PopupMenuItem(
                child: Text("Search"),
                value: "Search",
              ),
              PopupMenuItem(
                child: Text("Mute Notification"),
                value: "Mute Notification",
              ),
              PopupMenuItem(
                child: Text("Wallpaper"),
                value: "Wallpaper",
              ),
            ];
          })
        ],
      ),
      body: Container(
        color: Colors.blueGrey,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: WillPopScope(
          child: Stack(
            children: [
              ListView(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width - 60,
                          child: Card(
                            margin: EdgeInsets.only(left: 3, right: 3, bottom: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            child: TextFormField(
                              controller: _controller,
                              focusNode: focusNode,
                              textAlignVertical: TextAlignVertical.center,
                              keyboardType: TextInputType.multiline,
                              maxLines: 5,
                              minLines: 1,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Type a message",
                                contentPadding: EdgeInsets.only(left: 15, right: 8),
                                prefixIcon: IconButton(
                                  onPressed: (){
                                    focusNode.unfocus();
                                    focusNode.canRequestFocus = false;
                                    setState(() {
                                      isEmoji = !isEmoji;
                                    });
                                  }, 
                                  icon: Icon(
                                    Icons.insert_emoticon_sharp
                                  ),
                                ),
                                suffixIcon: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: (){
                                        showModalBottomSheet(
                                          backgroundColor: Colors.transparent,
                                          context: context, 
                                          builder: (builder) => bottomSheet()
                                        );
                                      }, 
                                      icon: Icon(Icons.attach_file), 
                                    ),
                                    IconButton(
                                      onPressed: (){}, 
                                      icon: Icon(Icons.camera_alt), 
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 8,
                            right: 5,
                            left: 5
                          ),
                          child: CircleAvatar(
                            backgroundColor:  Color(0xFF128C7E),
                            radius: 25,
                            child: IconButton(
                              onPressed: (){}, 
                              icon: Icon(Icons.mic, color: Colors.white),
                            ),
                          )
                        ),
                      ],
                    ),
                    isEmoji ? 
                    Container(
                      child: emojiSelect(),
                      height: 320,
                    ) : Container(),
                  ],
                ),
              )
            ],
          ),
          onWillPop: () {
            if (isEmoji) {
              setState(() {
                isEmoji = false;
              });
            }
            else {
              Navigator.pop(context);
            }
            return Future.value(false);
          },
        ),

      ),
    );

    
  }
  Widget emojiSelect() {
      return EmojiPicker(
        onEmojiSelected: (category, emoji) {
          setState(() {
            _controller.text = _controller.text + emoji.emoji;
          });
        },
        config: Config(
          columns: 9,
          emojiSizeMax: 25,
          verticalSpacing: 0,
          horizontalSpacing: 0,
          initCategory: Category.RECENT,
          bgColor: Colors.white,
          indicatorColor: Colors.black,
          iconColor: Colors.grey,
          
        ), 
      );
  }

  Widget bottomSheet(){
    return Container(
      height: 250,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(left: 8.0, right: 8.0, top: 18.0, bottom: 60),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(
                    Icons.insert_drive_file, Colors.indigo, "Document"),
                  SizedBox(width: 40),
                  iconCreation(
                    Icons.camera_alt, Colors.pink, "Camera"),
                  SizedBox(width: 40),
                  iconCreation(
                    Icons.insert_photo, Colors.purple, "Gallery"),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(
                    Icons.headset, Colors.orange.shade800, "Audio"),
                  SizedBox(width: 40),
                  iconCreation(
                    Icons.location_pin, Colors.green.shade700, "Location"),
                  SizedBox(width: 40),
                  iconCreation(
                    Icons.person, Colors.blue.shade800, "Contact"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget iconCreation(IconData icon, Color color, String text){
    return InkWell(
      onTap: (){},
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Icon( 
              icon,
              size: 29,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 5),
          Text(
            text,
            style: TextStyle(
              fontSize: 13,
            ),
          )
        ],
      ),
    );
  }


}