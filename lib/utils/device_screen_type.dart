import 'package:flutter/material.dart';

enum DeviceScreenType {
  mobile,
  tablet,
  desktop
} // Device screen types

DeviceScreenType getDeviceType(MediaQueryData mediaQuery) {
  double deviceWidth = mediaQuery.size.width;

  if (deviceWidth > 950) {
    return DeviceScreenType.desktop;
  }

  if (deviceWidth > 600) {
    return DeviceScreenType.tablet;
  }

  return DeviceScreenType.mobile;
} // Function for adaptive design
