import 'package:call_demo/modules/contacts/add_contact_ui.dart';
import 'package:call_demo/modules/contacts/bloc/contact_bloc.dart';
import 'package:call_demo/modules/contacts/bloc/contact_event.dart';
import 'package:call_demo/modules/contacts/bloc/contact_vm.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sticky_headers/sticky_headers.dart';

import 'bloc/contact_state.dart';

class ContactUi extends StatefulWidget {
  @override
  _ContactUiState createState() => _ContactUiState();
}

class _ContactUiState extends State<ContactUi> {

  ContactBloc contactBloc;
  ScrollController scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();
  bool isSearching = false;
  int _selectedIndexValue = 0;

  bool isFirstTime = true;
  List<ContactVm> contactSectionList = [];
  List<ContactVm> duplicateContactSectionList = [];
  List<ContactVm> unTouchedContactSectionList = [];

  @override
  void initState() {
    contactBloc = ContactBloc();
    contactBloc.dispatch(FetchContactEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isSearching?searchAppBar():segmentAppBar(),
      body: getBody(),
      floatingActionButton: isSearching?Container():FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context){
              return AddContactUI();
            }
          ));
        },
        child: Icon(Icons.add),
      ),
    );
  }


  /// Appbar
  AppBar searchAppBar(){
    return AppBar(
      backgroundColor: Colors.grey[200],
     brightness: Brightness.light,

      title: TextField(
        autofocus: true,
        controller: searchController,
        decoration: InputDecoration(
          hintText: "Search",
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),

        ),
        onChanged: (value){
//          setState(() {
            filterContacts(value);

//          });
        }
      ),
      actions: <Widget>[
        IconButton(icon: Icon(Icons.close,color: Colors.black,), onPressed: (){
          setState(() {
          isSearching = !isSearching;
          });
        })
      ],
    );
  }

  AppBar segmentAppBar(){
    return AppBar(
      brightness: Brightness.light,
    title: CupertinoSegmentedControl(borderColor: Colors.black54,
      children: {
        0: segmentItem(0, "ALL"),
        1: segmentItem(1, "SIP"),
        2: segmentItem(2,"LDAP"),
      },
      groupValue: _selectedIndexValue,

      onValueChanged: (value) {
        setState(() => _selectedIndexValue = value);
      },
    ),
      backgroundColor: Colors.grey[200],

      actions: <Widget>[
        IconButton(icon: Icon(Icons.search,color: Colors.black,), onPressed: (){
          setState(() {
            isSearching = !isSearching;
          });
        })
      ],
    );
  }

  Widget segmentItem(int position,String text){
    return Padding(
      padding:EdgeInsets.symmetric(vertical:4.0,horizontal: 16.0),
      child: Text(text,style: TextStyle(color:_selectedIndexValue == position?Colors.white:Colors.black54,fontSize: 14),),
    );
  }

  Widget getBody(){
    switch(_selectedIndexValue){
      case 0: return getAllContactList();
      case 1: return getSipContactList();
      case 2: return getLdapContactList();
      default: return getAllContactList();
    }
  }

  /// ALL
  Widget getAllContactList(){
    return BlocBuilder(
      bloc:contactBloc,
      builder: (context,ContactState state){
        if(state is ContactLoaded){
          if(isFirstTime){
            contactSectionList.clear();
            contactSectionList.addAll(state.contacts);
            duplicateContactSectionList.clear();
            duplicateContactSectionList.addAll(state.contacts);
            unTouchedContactSectionList.clear();
            unTouchedContactSectionList.addAll(state.contacts);
            isFirstTime = false;
          }
          return ListView.builder(
              itemCount: contactSectionList.length,
              controller: scrollController,
              itemBuilder: (context, int position){
                return sectionView(contactSectionList[position]);
          });
        }
        else if(state is ContactError){
          return Container(
            child: Center(
              child: Text("Error in fetching device contacts ${state.error}"),
            ),
          );
        }
        return Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget sectionView(ContactVm contactVm){
    return StickyHeader(
      header:isSearching?Divider():Container(
        height: 40.0,
        color: Colors.grey[300],
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        alignment: Alignment.centerLeft,
        child: Text(contactVm.title,
          style: const TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w700),
        ),
      ),
      content: Container(
        child: ListView.separated(
          separatorBuilder: (context,position){
            return Divider();
          },
          controller: scrollController,
          shrinkWrap: true,
            itemCount: contactVm.contact.length,
            itemBuilder: (context, int position){
          return Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical:6.0,horizontal: 16),
                    child: contactVm.contact[position].givenName != null && contactVm.contact[position].givenName.trim() != ""?
                    Text(contactVm.contact[position].givenName,style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600),):
                    Text(contactVm.contact[position].phones.toList()[0].value,style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600),),
                  ),
                );

        })
      ),
    );
  }

  /// SIP
  Widget getSipContactList(){
    return Container();
  }

  /// LDAP
  Widget getLdapContactList(){
    return Container();
  }


  filterContacts(String query){
    if(query != null && query != ""){
    List<ContactVm> dummyContactVm = [];
    List<ContactVm> duplicateDummy = [];
    duplicateDummy.addAll(duplicateContactSectionList);
    duplicateDummy.forEach((j){
      List<Contact> dummyContact = [];
      List<Contact> duplicateDummyContact = [];
      duplicateDummyContact.addAll(j.contact);

      duplicateDummyContact.forEach((i){
        if(i.givenName != null && i.givenName.toLowerCase().contains(query.toLowerCase())){
          dummyContact.add(i);
        }
      });
      if(dummyContact.isNotEmpty){
          duplicateDummyContact.clear();
          duplicateDummyContact.addAll(dummyContact);
          ContactVm obj = ContactVm();
          obj.title = j.title;
          obj.contact = duplicateDummyContact;
          dummyContactVm.add(obj);
      }


    });
      setState(() {
        contactSectionList.clear();
        contactSectionList.addAll(dummyContactVm);
      });
    }
    else{
      setState(() {
        contactSectionList.clear();
        contactSectionList.addAll(unTouchedContactSectionList);
        isFirstTime = true;
      });
    }
  }


}
