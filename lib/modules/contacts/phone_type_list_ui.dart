import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'bloc/phone_field_dm.dart';

class PhoneTypeListUI extends StatefulWidget {
  PhoneType selectedPhoneType;
  PhoneTypeListUI(this.selectedPhoneType);
  @override
  _PhoneTypeListUIState createState() => _PhoneTypeListUIState();
}

class _PhoneTypeListUIState extends State<PhoneTypeListUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body:getBody(),
    );
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
        "Select Type",
        style: TextStyle(color: Colors.black),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.check,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () {
            Navigator.of(context).pop(widget.selectedPhoneType);
          },
        )
      ],
    );
  }
  Widget getBody(){
    return ListView(

      shrinkWrap: true,
      children: <Widget>[
        listItem(PhoneType.Home),
        listItem(PhoneType.Work),
        listItem(PhoneType.iPhone),
        listItem(PhoneType.Mobile),
        listItem(PhoneType.Main),
        listItem(PhoneType.HomeFAX),
        listItem(PhoneType.WorkFAX),
        listItem(PhoneType.Pager),
        listItem(PhoneType.Other),
      ],
    );
  }

  Widget listItem(PhoneType phoneType){
    return Column(
      children: <Widget>[
        ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 16.0),
          dense: true,
          onTap: (){
            setState(() {
              widget.selectedPhoneType = phoneType;
            });
          },
          title: Text(describeEnum(phoneType),style: TextStyle(fontSize: 16.0),),
          trailing: phoneType == widget.selectedPhoneType?Icon(Icons.check,color: Theme.of(context).primaryColor,):Container(width: 0,height: 0,)
        ),
        Divider()
      ],
    );
  }
}
