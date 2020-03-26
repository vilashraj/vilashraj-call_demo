import 'package:flutter/material.dart';

import 'contact_vm.dart';

abstract class ContactState{}
class ContactUninitialized extends ContactState{}
class ContactLoading extends ContactState{}
class ContactLoaded extends ContactState{
  List<ContactVm> contacts;
  ContactLoaded({@required this.contacts});
}
class ContactError extends ContactState{
  String error;
  ContactError(this.error);
}