import 'package:call_demo/modules/contacts/bloc/phone_field_dm.dart';
import 'package:call_demo/modules/contacts/phone_type_list_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AddContactUI extends StatefulWidget {
  @override
  _AddContactUIState createState() => _AddContactUIState();
}

class _AddContactUIState extends State<AddContactUI> {
  Map sipNumberMap = {0: ""};
  Map<int, PhoneFieldDm> phoneNumberMap = {
    0: PhoneFieldDm(phoneNumber: "", phoneType: PhoneType.iPhone)
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: getAppBar(), body: getBody());
  }

  Widget getAppBar() {
    return AppBar(
      brightness: Brightness.light,
      backgroundColor: Colors.grey[200],
      leading: IconButton(
        icon: Icon(
          Icons.close,
          color: Theme.of(context).primaryColor,
        ),
        onPressed: () {
          Navigator.of(context).maybePop();
        },
      ),
      title: Text(
        "New Contact",
        style: TextStyle(color: Colors.black),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.check,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () {},
        )
      ],
    );
  }

  Widget getBody() {
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

  Widget profilePicRow() {
    return Row(
      children: <Widget>[
        Expanded(
            flex: 2,
            child: CircleAvatar(
              radius: 30,
              child: Center(
                  child: Icon(
                CupertinoIcons.person_solid,
                size: 48,
                color: Colors.grey[600],
              )),
              backgroundColor: Colors.grey[200],
            )),
        Expanded(
            flex: 8,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                      //Add th Hint text here.
                      hintText: "First Name",
                      border: UnderlineInputBorder(),
                      contentPadding: EdgeInsets.zero),
                ),
                TextField(
                  decoration: InputDecoration(
                      //Add th Hint text here.
                      hintText: "Last Name",
                      border: UnderlineInputBorder(),
                      contentPadding: EdgeInsets.zero),
                ),
              ]),
            )),
      ],
    );
  }

  Widget sipNumberSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "SIP Number",
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        Container(
          height: 1.0,
          color: Theme.of(context).primaryColor,
        ),
        ListView.builder(
            shrinkWrap: true,
            itemCount: sipNumberMap.length,
            itemBuilder: (context, int position) {
              return sipField(position);
            }),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              setState(() {
                sipNumberMap[sipNumberMap.length] = "";
              });
            },
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.add_circle,
                  color: Colors.green,
                ),
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

  Widget sipField(int position) {
    TextEditingController sipController = TextEditingController();
    sipController.text = sipNumberMap[position];
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              GestureDetector(
                  onTap: (){
                    setState(() {
                      sipNumberMap.remove(position);
                      print(sipNumberMap);
                      Map newMap = {};
                      int count = 0;

                      sipNumberMap.forEach((k, v) {
                        newMap[count] = v;
                        count++;
                      });
                      sipNumberMap = newMap;
                    });
                  },
                  child: Icon(
                    Icons.remove_circle,
                    color: Colors.red,
                  ),
                ),


              SizedBox(width: 8.0),
              Text("SIP Number"),
              SizedBox(width: 8.0),
              Expanded(
                child: ContactTextField(
                  contactController: sipController,
                  onChange: (value) {
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

  Widget phoneNumberSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Phone",
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        Container(
          height: 1.0,
          color: Theme.of(context).primaryColor,
        ),
        ListView.builder(
            shrinkWrap: true,
            itemCount: phoneNumberMap.length,
            itemBuilder: (context, int position) {
              return phoneNumberField(position);
            }),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              setState(() {
                phoneNumberMap[phoneNumberMap.length] =
                    PhoneFieldDm(phoneType: PhoneType.iPhone, phoneNumber: "");
              });
            },
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.add_circle,
                  color: Colors.green,
                ),
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

  Widget phoneNumberField(int position) {
    TextEditingController phoneFieldController = TextEditingController();
    phoneFieldController.text = phoneNumberMap[position].phoneNumber;
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              GestureDetector(
                  onTap: () {
                    setState(() {
                      phoneNumberMap.remove(position);
                      Map<int, PhoneFieldDm> newMap = {};
                      int count = 0;

                      phoneNumberMap.forEach((k, v) {
                        newMap[count] = v;
                        count++;
                      });
                      phoneNumberMap = newMap;
                      ;
                    });
                  },
                  child: Icon(
                    Icons.remove_circle,
                    color: Colors.red,
                  )),
              SizedBox(width: 8.0),
              GestureDetector(
                onTap: ()async{
                  PhoneType pType = await Navigator.of(context).push(MaterialPageRoute(builder:(context){
                    return PhoneTypeListUI(phoneNumberMap[position].phoneType);
                  }));

                  if(pType != null){
                    setState(() {
                      phoneNumberMap[position].phoneType = pType;
                    });
                  }
                },
                  child: Text(describeEnum(phoneNumberMap[position].phoneType,),style: TextStyle(color:Colors.blue),)),
              SizedBox(width: 2.0),
              Icon(Icons.arrow_forward_ios,color: Colors.grey[300],size: 12,),
              SizedBox(width: 2.0),
              Container(height:20.0,width: 1.0,color: Colors.grey[300],),
              SizedBox(width: 8.0),
              Expanded(
                child: ContactTextField(
                  contactController: phoneFieldController,
                  onChange: (value) {
                    setState(() {
                      phoneNumberMap[position].phoneNumber = value;
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
}

class ContactTextField extends StatefulWidget {
  Function onChange;
  TextEditingController contactController;

  ContactTextField({this.onChange, this.contactController});

  @override
  _ContactTextFieldState createState() => _ContactTextFieldState();
}

class _ContactTextFieldState extends State<ContactTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.contactController,
      onChanged: (value) {
        setState(() {
          widget.onChange(value);
        });
      },
      decoration: InputDecoration(
          contentPadding: EdgeInsets.zero, border: UnderlineInputBorder()),
    );
  }
}
