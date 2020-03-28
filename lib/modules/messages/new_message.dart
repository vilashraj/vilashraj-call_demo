import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewMessageUI extends StatefulWidget {
  @override
  _NewMessageUIState createState() => _NewMessageUIState();
}

class _NewMessageUIState extends State<NewMessageUI> {
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
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios,color: Theme.of(context).primaryColor,),
        onPressed: (){
          Navigator.of(context).maybePop();
        },
      ),
      title: Text('New Message',style: TextStyle(color: Colors.black),),
    );
  }

  Widget getBody(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          color: Colors.grey[300],
          child: Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Recipient:"),
                ),
              ),
              IconButton(icon: Icon(Icons.add_circle_outline,color: Theme.of(context).primaryColor,), onPressed: (){})
            ],
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: (){
              FocusScope.of(context).unfocus();
            },
            child: Container(
              color:Colors.transparent,
            ),
          ),
        ),
        Container(
          color: Colors.grey[300],
          child: Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left:4.0,bottom: 4.0,top: 4.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border:Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left:8.0),
                      child: TextFormField(
                        maxLines: 3,
                      minLines: 1,
                      decoration: InputDecoration(
                        hintText: "Type message here",
                        border: InputBorder.none,
                      ),
                      ),
                    ),
                  ),
                ),
              ),
              IconButton(icon: Icon(Icons.send,color: Theme.of(context).primaryColor,), onPressed: (){})
            ],
          ),
        ),

      ],
    );
  }
}
