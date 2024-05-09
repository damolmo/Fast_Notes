import 'package:flutter/material.dart';
import '../../exports.dart';

class CustomBanner extends StatelessWidget{
  @override
  const CustomBanner({
    required this.viewModel,
    super.key
});

  final HomeScreenModel viewModel;

  @override
  Widget build(BuildContext context){
    return Container(
      width: getDeviceWidth(context) * 0.6,
      height: getDeviceHeight(context) * 0.4,
      margin: EdgeInsets.only(
        top: getDeviceHeight(context) * 0.025,
        bottom: getDeviceHeight(context) * 0.575,
        left: getDeviceWidth(context) * 0.2,
        right: getDeviceWidth(context) * 0.2
      ),
      child: InkWell(
        onTap : (){
          viewModel.isDarkModeEnabled ?  viewModel.isDarkModeEnabled = false :  viewModel.isDarkModeEnabled = true;
          viewModel.notifyListeners();
        },
        child : Image(
            fit: BoxFit.fitHeight,
            image: viewModel.isDarkModeEnabled ? const AssetImage("assets/logo/logo_easter.png") : const AssetImage("assets/logo/logo.png")
        )
      ),
    );
  }
}