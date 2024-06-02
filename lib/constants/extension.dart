import 'dart:io';

import 'package:flutter/material.dart';

///This function will get the size of the mobile screen
Size getSize(BuildContext context) {
  return MediaQuery.of(context).size;
}

extension GetSize on double {
  double toRes(BuildContext context) {
    double scaleFactor = Platform.isIOS ? 0.95 : 1.0;
    return (getSize(context).height * this * scaleFactor) + (getSize(context).width * this * scaleFactor);
  }

  double h(BuildContext context) {
    return getSize(context).height * this;
  }

  double w(BuildContext context) {
    return getSize(context).width * this;
  }
}