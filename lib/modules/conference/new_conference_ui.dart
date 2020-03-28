import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewConferenceUI extends StatefulWidget {
  @override
  _NewConferenceUIState createState() => _NewConferenceUIState();
}

class _NewConferenceUIState extends State<NewConferenceUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: getBody(),
    );
  }

  AppBar getAppBar(){
    return AppBar(
      title: Text("New Conference"),
      backgroundColor: Colors.black,
      leading: IconButton(icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).primaryColor,),onPressed: (){Navigator.of(context).maybePop();},),
      actions: <Widget>[
        IconButton(icon: Icon(Icons.add, color: Theme.of(context).primaryColor,), onPressed: (){})
      ],
    );
  }
  Widget getBody(){
    return Container(
      decoration: BoxDecoration(
        gradient:LinearGradient(
            colors: [Colors.black,Colors.black,Colors.blue[900],Colors.blue[900],Colors.black],
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
        )
      ),
      child:Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text("You can add up to 5 members.",style: TextStyle(color: Colors.grey,fontSize: 12),),
            ],
          ),
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor.withOpacity(0.2),
                            shape: BoxShape.circle,
                            border: Border.all(color: Theme.of(context).primaryColor)
                          ),
                          child: Icon(CupertinoIcons.person,size: 75,color: Colors.white,),
                        ),
                        Text("Host",style: TextStyle(color:Colors.white),)
                      ],
                    ),
                  ),
                  addButton(),
                  addButton()
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  addButton(),
                  addButton(),
                  addButton()
                ],
              )
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(15))
                    ),                    child: FlatButton(onPressed: (){},
                        child: Center(
                          child: Text("Delete",style: TextStyle(color: Colors.white,fontSize: 17),),
                        ),),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.all(Radius.circular(15))
                    ),
                    child: FlatButton(onPressed: (){},
                        child: Center(
                          child: Text("Start Conference",style: TextStyle(color: Colors.white,fontSize: 17),),
                        ),),
                  ),
                ),
              ),
            ],
          ),
        ],
      )
    );
  }

  Widget addButton(){
   return Padding(
     padding: const EdgeInsets.all(8.0),
     child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.2),
                shape: BoxShape.circle,
                border: Border.all(color: Theme.of(context).primaryColor)
            ),
            child: Icon(CupertinoIcons.add,size: 75,color: Colors.white,),
          ),
          Text("",style: TextStyle(color:Colors.white),)
        ],
      ),
   );
  }
}
