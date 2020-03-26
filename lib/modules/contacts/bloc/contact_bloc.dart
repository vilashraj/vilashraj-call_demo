import 'package:bloc/bloc.dart';
import 'package:call_demo/modules/contacts/bloc/contact_event.dart';
import 'package:call_demo/modules/contacts/bloc/contact_repo.dart';
import 'package:call_demo/modules/contacts/bloc/contact_state.dart';
import 'package:call_demo/modules/contacts/device_contact_provider.dart';
import 'package:contacts_service/contacts_service.dart';

import 'contact_vm.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState>{
  @override
  ContactState get initialState => ContactUninitialized();

  @override
  Stream<ContactState> mapEventToState(ContactState currentState, ContactEvent event)async*{
    if(event is FetchContactEvent){
     try{
       yield ContactLoading();
       List<ContactVm> contacts = await ContactRepo().getAllDeviceContacts();
       yield ContactLoaded(contacts:contacts);
     }
     catch(e){
       yield ContactError(e);
     }
    }
  }

}