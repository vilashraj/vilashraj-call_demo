import 'package:call_demo/modules/contacts/device_contact_provider.dart';
import 'package:call_demo/modules/keypad/disable_textfield.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class KeyPadUI extends StatefulWidget {
  @override
  _KeyPadUIState createState() => _KeyPadUIState();
}

class _KeyPadUIState extends State<KeyPadUI> {
  int _selectedIndexValue = 0;
  bool isDialing = false;
  FocusNode dialFocusNode = FocusNode();
  TextEditingController dialController = TextEditingController();
  ScrollController recentController = ScrollController();
  String phoneNumberDialed = "";
  @override
  void initState() {
    dialFocusNode.addListener(() {
      if (!dialFocusNode.hasFocus) {
        FocusScope.of(context).requestFocus(dialFocusNode);
      }
    });
    recentController.addListener((){
      if(recentController.offset>=300){
        setState(() {
          isDialing = false;
        });
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: segmentAppBar(),
      body: keyboard(),
//      floatingActionButton: FloatingActionButton(
//        onPressed: (){
//          setState(() {
//            isDialing = !isDialing;
//          });
//        },
//        child: Icon(isDialing?Icons.keyboard_arrow_down:Icons.dialpad),
//      ),
    );
  }
  AppBar segmentAppBar(){
    return AppBar(
      brightness: Brightness.light,
      title: CupertinoSegmentedControl(borderColor: Colors.black54,
        children: {
          0: segmentItem(0, "Call History"),
          1: segmentItem(1, "Missed"),
        },
        groupValue: _selectedIndexValue,

        onValueChanged: (value) {
          setState(() => _selectedIndexValue = value);
        },
      ),
      backgroundColor: Colors.grey[200],


    );
  }
  Widget segmentItem(int position,String text){
    return Padding(
      padding:EdgeInsets.symmetric(vertical:4.0,horizontal: 16.0),
      child: Text(text,style: TextStyle(color:_selectedIndexValue == position?Colors.white:Colors.black54,fontSize: 14),),
    );
  }
  Widget getBody(){
    List<Contact> contacts = DeviceContactProvider.deviceContacts;
    return Column(
      children: <Widget>[
        Expanded(
          child: GestureDetector(
            onTap: (){
              setState(() {
                isDialing = false;
              });
            },
            onPanStart: (detail){
              setState(() {
                isDialing = false;
              });
            },
            child: ListView.separated(
              controller: recentController,
                itemBuilder: (context,int position){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(contacts[position].givenName == ""?contacts[position].phones.toList()[0].value:contacts[position].givenName,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),),
                    Text(contacts[position].phones.toList()[0].value,style: TextStyle(color: Colors.grey,fontSize: 14),),
                  ],
                ),
              );
            },
                separatorBuilder: (context,int position){
              return Divider();
            }, itemCount: contacts.length),
          ),
        ),
        isDialing?Container(
          color: Colors.grey[200],
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal:8.0),
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: dialController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: "Enter number",

              ),
              focusNode: AlwaysDisabledFocusNode(),
              textInputAction: TextInputAction.done,
            ),
          ),
        ):Container(),
      ],
    );
  }

  Widget keyboard(){
    return Container(
      color: Colors.grey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            color: Colors.grey[200],
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal:8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical:12.0),
                      child: Text(phoneNumberDialed == ""?"Enter number":phoneNumberDialed,style: TextStyle(fontSize: 18,color: phoneNumberDialed == ""?Colors.grey:Colors.black),),
                    )
                  ),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        phoneNumberDialed = phoneNumberDialed.substring(0,phoneNumberDialed.length-1);
                      });
                    },
                    onLongPress: (){
                      setState(() {
                        phoneNumberDialed = "";
                      });
                    },
                    child: Icon(Icons.backspace),
                  )
                ],
              ),
            ),
          ),
          Row(
            children: <Widget>[
              keyboardButton(title: "1"),
              keyboardButton(title: "2",subTitle: "A B C"),
              keyboardButton(title: "3",subTitle: "D E F"),
            ],
          ),
          Row(
            children: <Widget>[
              keyboardButton(title: "4",subTitle: "G H I"),
              keyboardButton(title: "5",subTitle: "J K L"),
              keyboardButton(title: "6",subTitle: "M N O"),
            ],
          ),
          Row(
            children: <Widget>[
              keyboardButton(title: "7",subTitle: "P Q R S"),
              keyboardButton(title: "8",subTitle: "T U V"),
              keyboardButton(title: "9",subTitle: "W X Y Z"),
            ],
          ),
          Row(
            children: <Widget>[
              moreButton(),
              keyboardButton(title: "0"),
              callButton()
            ],
          ),
        ],
      ),
    );
  }

  Widget keyboardButton({@required String title,String subTitle = ""}){
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: GestureDetector(
          onTap: (){
            setState(() {
              phoneNumberDialed = phoneNumberDialed + title;
            });
          },
          child: Container(
            color: Colors.black54,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Text(title,style: TextStyle(color: Colors.white,fontSize: 30),),
                    Text(subTitle,style: TextStyle(color: Colors.white,fontSize: 12),),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget moreButton(){
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: GestureDetector(
          onTap: (){

          },
          child: Container(
            color: Colors.green,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(child: Icon(Icons.more_horiz,color: Colors.white,size: 30,)),
                    Column(
                      children: <Widget>[
                        Text("",style: TextStyle(color: Colors.white,fontSize: 34),),
                        Text("",style: TextStyle(color: Colors.white,fontSize: 8),),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget callButton(){
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: GestureDetector(
          onTap: (){

          },
          child: Container(
            color: Colors.green,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(child: Icon(Icons.call,color: Colors.white,size: 30,)),
                    Column(
                      children: <Widget>[
                        Text("",style: TextStyle(color: Colors.white,fontSize: 34),),
                        Text("",style: TextStyle(color: Colors.white,fontSize: 8),),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
