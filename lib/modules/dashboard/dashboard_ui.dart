import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:call_demo/modules/conference/conference_ui.dart';
import 'package:call_demo/modules/contacts/contact_ui.dart';
import 'package:call_demo/modules/contacts/device_contact_provider.dart';
import 'package:call_demo/modules/keypad/keypad_ui.dart';
import 'package:call_demo/modules/messages/messages.dart';
import 'package:call_demo/modules/settings/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  //This will be by default selected index of the bottom navigation bar
  int _selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.black,statusBarBrightness: Brightness.light
    ));
    return Scaffold(
      body: getBody(),
      bottomNavigationBar: getBottomNavigationBar() ,
    );
  }

  Widget getBottomNavigationBar(){
    return BottomNavyBar(
      selectedIndex: _selectedIndex,
      showElevation: true,
      onItemSelected: (value)async{
        if(value == 2){
          await DeviceContactProvider().getAllDeviceContact();
        }
        setState(() {
          _selectedIndex = value;
        });
      },
      items: getBottomNavigationItems(),
    );
  }

  List<BottomNavyBarItem> getBottomNavigationItems(){
    return [
      BottomNavyBarItem(
        icon: Icon(CupertinoIcons.person_solid),
        title: Text('Contacts'),
          inactiveColor: Colors.grey

      ),
      BottomNavyBarItem(
          icon: Icon(CupertinoIcons.group_solid),
          title: Text('Conference'),
          inactiveColor: Colors.grey

      ),
      BottomNavyBarItem(
          icon: Icon(Icons.access_time),
          title: Text('Recents'),
          inactiveColor: Colors.grey

      ),
      BottomNavyBarItem(
          icon: Icon(Icons.message),
          title: Text('Messages'),
          inactiveColor: Colors.grey

      ),
      BottomNavyBarItem(
        icon: Icon(Icons.settings),
        title: Text('Settings'),
        inactiveColor: Colors.grey
      ),
    ];
  }

  getBody(){
    switch(_selectedIndex){
      case 0: return ContactUi();
      case 1: return ConferenceUI();
      case 2: return KeyPadUI();
      case 3: return MessagesUI();
      case 4: return SettingsUI();
      default: return Container(
        child: Center(
          child: Text("Hello"),
        ),
      );
    }
  }
}

