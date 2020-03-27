import 'package:contacts_service/contacts_service.dart';

class DeviceContactProvider{
  static List<Contact> deviceContacts = [];
  getAllDeviceContact()async{
    List<Contact> contactList = [];
    if(deviceContacts.isEmpty){
      Iterable<Contact> contacts = await ContactsService.getContacts(withThumbnails: false);
      contacts.forEach((k){
        contactList.add(k);
      });
      contactList.sort((a, b) => a.givenName.compareTo(b.givenName));
      deviceContacts.addAll(contactList);
    }
    return deviceContacts;

  }

  deleteContact()async{
  }
}