import 'package:contacts_service/contacts_service.dart';

class DeviceContactProvider{
  getAllDeviceContact()async{
    List<Contact> contactList = [];
    Iterable<Contact> contacts = await ContactsService.getContacts(withThumbnails: false);
    contacts.forEach((k){
      contactList.add(k);
    });
    return contactList;

  }

  deleteContact()async{
  }
}