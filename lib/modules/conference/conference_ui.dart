import 'package:flutter/material.dart';

class ConferenceUI extends StatefulWidget {
  @override
  _ConferenceUIState createState() => _ConferenceUIState();
}

class _ConferenceUIState extends State<ConferenceUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
    );
  }
  AppBar getAppBar(){
    return AppBar(
      brightness: Brightness.light,
      backgroundColor: Colors.grey[200],
      title: Text('Conference',style: TextStyle(color: Colors.black),),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add, color: Theme.of(context).primaryColor,),
          onPressed: (){},
        ),
      ],
    );
  }

}
