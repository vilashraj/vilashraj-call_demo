import 'package:call_demo/modules/conference/new_conference_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsUI extends StatefulWidget {
  @override
  _SettingsUIState createState() => _SettingsUIState();
}

class _SettingsUIState extends State<SettingsUI> {
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
      title: Text('Settings',style: TextStyle(color: Colors.black),),

    );
  }
  Widget getBody(){
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
         listTile("Account Settings"),
          listTile("Advanced Settings"),
          listTile("Provisioning Settings"),
          listTile("Custom Settings"),
          listTile("About Version"),
          listTile("Debug"),
          listTile("Delete All Call History",isDestructive: true),

        ],
      ),
    );
  }

  Widget listTile(String text,{bool isDestructive = false}){
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: (){},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(text,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 17,color: isDestructive?Colors.red:Colors.black),),
              ),
              isDestructive?Container():Icon(Icons.keyboard_arrow_right,color: Colors.grey,)
            ],
          ),
        ),
        Divider(),
      ],
    );
  }
}
