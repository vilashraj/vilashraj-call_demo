import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddContactUI extends StatefulWidget {
  @override
  _AddContactUIState createState() => _AddContactUIState();
}

class _AddContactUIState extends State<AddContactUI> {

  Map sipNumberMap = {0:""};
  Map phoneNumberMap = {0:""};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body:getBody()
    );
  }

  Widget getAppBar(){
    return AppBar(
      brightness: Brightness.light,
      backgroundColor: Colors.grey[200],
      leading: IconButton(
        icon:Icon(Icons.close,color: Theme.of(context).primaryColor,),
        onPressed: (){
          Navigator.of(context).maybePop();
        },
      ),
      title: Text("New Contact",style: TextStyle(color: Colors.black),),
      actions: <Widget>[
        IconButton(
          icon:Icon(Icons.check,color: Theme.of(context).primaryColor,),
          onPressed: (){},
        )
      ],
    );
  }

  Widget getBody(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            profilePicRow(),
            sipNumberSection(),
            phoneNumberSection()
          ],
        ),
      ),
    );

  }

  Widget profilePicRow(){
    return Row(
      children: <Widget>[
        Expanded(
          flex:2,
          child: CircleAvatar(
            radius: 30,
            child: Center(child: Icon(CupertinoIcons.person_solid,size: 48,color: Colors.grey[600],)),
            backgroundColor: Colors.grey[200],
          )
        ),
        Expanded(
          flex:8,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
             children: <Widget>[
              TextField(
              decoration: InputDecoration(
                //Add th Hint text here.
                hintText: "First Name",
                border: UnderlineInputBorder(),
                  contentPadding: EdgeInsets.zero

              ),

            ),
              TextField(

              decoration: InputDecoration(
                //Add th Hint text here.
                hintText: "Last Name",
                border: UnderlineInputBorder(),
                contentPadding: EdgeInsets.zero
              ),

            ),
        ]),
          )),
      ],
    );
  }

  Widget sipNumberSection(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("SIP Number",style: TextStyle(color: Theme.of(context).primaryColor),),
        Container(height:1.0,color: Theme.of(context).primaryColor,),
        ListView.builder(
          shrinkWrap: true,
            itemCount: sipNumberMap.length,
            itemBuilder: (context,int position){
          return sipField(position);
        }),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: (){
              setState(() {
                sipNumberMap[sipNumberMap.length] = "";
              });
            },
            child: Row(
              children: <Widget>[
                Icon(Icons.add_circle,color: Colors.green,),

                SizedBox(width: 8.0),
                Text("Add New Item"),
              ],
            ),
          ),
        ),
        Divider(),
      ],
    );
  }

  Widget sipField(int position){
    TextEditingController sipController = TextEditingController();
    sipController.text = sipNumberMap[position];
    return  Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              IconButton(icon:Icon(Icons.remove_circle,color: Colors.red,),onPressed: (){
                setState(() {
                  sipNumberMap.remove(position);
                  print(sipNumberMap);
                  Map newMap = {};
                  int count = 0;

                  sipNumberMap.forEach((k,v){
                    newMap[count] = v;
                    count++;
                  });
                  sipNumberMap = newMap;

                });
              },),
              SizedBox(width: 8.0),
              Text("SIP Number"),
              SizedBox(width: 8.0),

              Expanded(
                child: SipTextField(
                  sipController: sipController,
                  onChange: (value){
                    setState(() {
                      sipNumberMap[position] = value;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        Divider(),

      ],
    );
  }
  Widget phoneNumberSection(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Phone",style: TextStyle(color: Theme.of(context).primaryColor),),
        Container(height:1.0,color: Theme.of(context).primaryColor,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: (){

            },
            child: Row(
              children: <Widget>[
                Icon(Icons.add_circle,color: Colors.green,),

                SizedBox(width: 8.0),
                Text("Add New Item"),
              ],
            ),
          ),
        ),
        Divider(),
      ],
    );
  }
}


class SipTextField extends StatefulWidget {
  Function onChange;
  TextEditingController sipController;
  SipTextField({this.onChange,this.sipController});
  @override
  _SipTextFieldState createState() => _SipTextFieldState();
}

class _SipTextFieldState extends State<SipTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.sipController,
      onChanged: (value){
        setState(() {
          widget.onChange(value);
        });
      },
      decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          border: UnderlineInputBorder()
      ),
    );
  }
}
