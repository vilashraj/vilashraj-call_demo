import 'package:call_demo/modules/contacts/bloc/contact_vm.dart';
import 'package:call_demo/modules/contacts/device_contact_provider.dart';
import 'package:contacts_service/contacts_service.dart';

class ContactRepo{
  Future< List<ContactVm>> getAllDeviceContacts()async{
    List<Contact> contacts = await DeviceContactProvider().getAllDeviceContact();
    List<ContactVm> contactMap = groupByAlphabetically(contacts);
    return contactMap;
  }

  List<ContactVm> groupByAlphabetically(List<Contact> contacts){
    Map<String,List<Contact>> map = {};
    List<ContactVm> contactVmList = [];
    contacts.forEach((i){
      if(i.givenName != null && i.givenName != ""){
        if(map.containsKey(i.givenName.trim()[0].toUpperCase())){
          map[i.givenName.trim()[0].toUpperCase()].add(i);
        }
        else{
          map[i.givenName.trim()[0].toUpperCase()] = [i];
        }
      }
      else{
        if(map.containsKey('#')){
          map['#'].add(i);
        }
        else{
          map['#'] = [i];
        }
      }
    });
    map.forEach((k,v){
      ContactVm obj = ContactVm();
      obj.title = k;
      obj.contact = v;
      contactVmList.add(obj);
    });

    contactVmList.sort((a, b) => a.title.compareTo(b.title));
    return contactVmList;
  }
}