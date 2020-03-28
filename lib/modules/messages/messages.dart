import 'package:call_demo/modules/conference/new_conference_ui.dart';
import 'package:call_demo/modules/messages/new_message.dart';
import 'package:flutter/material.dart';

class MessagesUI extends StatefulWidget {
  @override
  _MessagesUIState createState() => _MessagesUIState();
}

class _MessagesUIState extends State<MessagesUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: getBody(),
    );
  }
  AppBar getAppBar(){
    return AppBar(
      brightness: Brightness.light,
      backgroundColor: Colors.grey[200],
      title: Text('Messages',style: TextStyle(color: Colors.black),),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add, color: Theme.of(context).primaryColor,),
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context){
                  return NewMessageUI();
                }
            ));
          },
        ),
      ],
    );
  }
  Widget getBody(){
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(Icons.message,size: 50,color: Theme.of(context).primaryColorDark,),
          ),
          Text("No messages yet.",style: TextStyle(color: Colors.black87,fontSize: 18,fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
        ],
      ),
    );
  }

}
