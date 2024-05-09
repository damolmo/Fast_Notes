// Global variables to be shared across all the app
import 'package:flutter/cupertino.dart';

double getDeviceWidth(BuildContext context) => MediaQuery.of(context).size.width;
double getDeviceHeight(BuildContext context) => MediaQuery.of(context).size.height;
navigateToRoute(BuildContext context, String route) => Navigator.of(context).pushNamed(route);