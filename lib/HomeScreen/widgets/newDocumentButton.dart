import 'package:flutter/material.dart';
import '../../exports.dart';

class NewDocumentsButton extends StatelessWidget{
  @override
  const NewDocumentsButton({
    required this.viewModel,
    super.key
});

  final HomeScreenModel viewModel;

  @override
  Widget build(BuildContext context){
    return Container(
      width: getDeviceWidth(context) * 0.20,
      height: getDeviceHeight(context) * 0.15,
      margin: EdgeInsets.only(
        top: getDeviceHeight(context) * 0.68,
        bottom: getDeviceHeight(context) * 0.21,
        left: getDeviceWidth(context) * 0.77,
        right: getDeviceWidth(context) * 0.02
      ),
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent,
        borderRadius: BorderRadius.circular(360),
        boxShadow: [BoxShadow(color: viewModel.isDarkModeEnabled ? Colors.white.withOpacity(0.6) : Colors.black.withOpacity(0.6), spreadRadius: 3.0, blurRadius: 12.0, blurStyle: BlurStyle.normal)]
      ),
      child: InkWell(
        onTap : (){
          viewModel.enabledNewDocMenu ? viewModel.enabledNewDocMenu = false : viewModel.enabledNewDocMenu = true;
          viewModel.notifyListeners();
        },
        child : Icon(viewModel.enabledNewDocMenu ? Icons.close_rounded : Icons.add_rounded, color: Colors.white, size: 45,)),
    );
  }

}