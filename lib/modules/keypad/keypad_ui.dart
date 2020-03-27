import 'package:call_demo/modules/contacts/device_contact_provider.dart';
import 'package:call_demo/modules/keypad/disable_textfield.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'keyboard.dart';

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
  List<Contact> contacts = [];
  List<Contact> duplicateContacts = [];
  List<Contact> unTouchedContacts = [];
  bool isFirstTime = true;

  @override
  void initState() {
    dialFocusNode.addListener(() {
      if (!dialFocusNode.hasFocus) {
        FocusScope.of(context).requestFocus(dialFocusNode);
      }
    });
    recentController.addListener(() {
      if (recentController.offset >= 300) {
        setState(() {
          isDialing = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isFirstTime) {
      contacts.addAll(DeviceContactProvider.deviceContacts);
      duplicateContacts.addAll(DeviceContactProvider.deviceContacts);
      unTouchedContacts.addAll(DeviceContactProvider.deviceContacts);
    }
    return Scaffold(
      appBar: segmentAppBar(),
      body: getBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return Keyboard(phoneNumberDialed, (value) {
                  setState(() {
                    searchFilter(value);

                    phoneNumberDialed = value;
                  });
                });
              });
        },
        child: Icon(Icons.dialpad),
      ),
    );
  }

  AppBar segmentAppBar() {
    return AppBar(
      brightness: Brightness.light,
      title: CupertinoSegmentedControl(
        borderColor: Colors.black54,
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

  Widget segmentItem(int position, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
      child: Text(
        text,
        style: TextStyle(
            color:
                _selectedIndexValue == position ? Colors.white : Colors.black54,
            fontSize: 14),
      ),
    );
  }

  Widget getBody() {
    return Column(
      children: <Widget>[
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                isDialing = false;
              });
            },
            onPanStart: (detail) {
              setState(() {
                isDialing = false;
              });
            },
            child: ListView.separated(
                controller: recentController,
                itemBuilder: (context, int position) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          contacts[position].givenName == ""
                              ? contacts[position].phones.toList()[0].value
                              : contacts[position].givenName,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        getPhoneRichText(
                          getPhoneText(
                              contacts[position].phones.toList()[0].value),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, int position) {
                  return Divider();
                },
                itemCount: contacts.length),
          ),
        ),
      ],
    );
  }

  searchFilter(String query) {
    if (query != null && query.trim() != "") {
      List<Contact> dummySearchList = [];
      List<Contact> result = [];
      dummySearchList.addAll(duplicateContacts);
      dummySearchList.forEach((i) {
        String phone = i.phones.toList().isEmpty
            ? ""
            : i.phones.toList().first.value.toLowerCase();
        phone = phone.replaceAll(")", "");
        phone = phone.replaceAll("(", "");
        phone = phone.replaceAll(" ", "");
        phone = phone.replaceAll("-", "");
        phone = phone.replaceAll("+", "");

        if (phone.contains(query.toLowerCase())) {
          result.add(i);
        }
      });
      setState(() {
        contacts.clear();
        isFirstTime = false;
        contacts.addAll(result);
      });
      return;
    } else {
      setState(() {
        contacts.clear();
        isFirstTime = false;
        contacts.addAll(unTouchedContacts);
      });
    }
  }

  String getPhoneText(String phoneNumber) {
    String phone = phoneNumber;
    phone = phone.replaceAll(")", "");
    phone = phone.replaceAll("(", "");
    phone = phone.replaceAll(" ", "");
    phone = phone.replaceAll("-", "");
    phone = phone.replaceAll("+", "");
    return phone;
  }

  Widget getPhoneRichText(String phoneNumber) {
    int index = phoneNumber.indexOf(phoneNumberDialed);
    if (index < 0) {
      return Text(
        phoneNumber,
        style: TextStyle(color: Colors.grey, fontSize: 14),
      );
    } else {
      return RichText(
        text: TextSpan(
            text: '',
            style: TextStyle(
                color: Colors.grey, fontSize: 14),
            children: getTextSpan(index, phoneNumber)
        ),
      );
    }
  }

  List<TextSpan>  getTextSpan(int index,String phoneNumber){
    List<TextSpan> list =[];
    if(index != 0){list.add(TextSpan(text: phoneNumber.substring(0,index),
      style: TextStyle(
          color: Colors.grey, fontSize: 14),

    ));}
    list.add(TextSpan(text: phoneNumber.substring(index,index+phoneNumberDialed.length),
      style: TextStyle(
          color: Colors.red, fontSize: 14),

    ));
    list.add(TextSpan(text: phoneNumber.substring(index+phoneNumberDialed.length,phoneNumber.length),
      style: TextStyle(
          color: Colors.grey, fontSize: 14),

    ));
    return list;
  }
}
