import 'package:call_demo/modules/conference/new_conference_ui.dart';
import 'package:flutter/cupertino.dart';
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
      body: getBody(),
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
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context){
                return NewConferenceUI();
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
          Icon(CupertinoIcons.group_solid,size: 70,color: Theme.of(context).primaryColorDark,),
          Text("No conference history yet!",style: TextStyle(color: Colors.black87,fontSize: 18,fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
        ],
      ),
    );
  }

}
