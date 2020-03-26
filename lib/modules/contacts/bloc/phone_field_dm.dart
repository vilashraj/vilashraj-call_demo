import 'package:flutter/material.dart';

enum PhoneType{
  Home,
  Work,
  iPhone,
  Mobile,
  Main,
  HomeFAX,
  WorkFAX,
  Pager,
  Other
}
class PhoneFieldDm{
  String phoneNumber;
  PhoneType phoneType;
  PhoneFieldDm({@required this.phoneNumber, @required this.phoneType});
}