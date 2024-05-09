import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../exports.dart';

class CreationWindow extends StatelessWidget{
  @override
  const CreationWindow({
   required this.viewModel,
   super.key
});

  final HomeScreenModel viewModel;

  @override
  Widget build(BuildContext context){
    return InkWell(
      onTap: (){
        viewModel.isCreationWindow = false;
        viewModel.isKeyboardEnabled = false;
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        viewModel.notifyListeners();
      },
        child : Container(
          width: getDeviceWidth(context) * 0.8,
          height: viewModel.isKeyboardEnabled ? getDeviceHeight(context) * 0.4 : getDeviceHeight(context) * 0.6,
          margin: EdgeInsets.only(
            left: getDeviceWidth(context) * 0.1,
            right: getDeviceWidth(context) * 0.1,
            top: viewModel.isKeyboardEnabled ? getDeviceHeight(context) * 0.05 : getDeviceHeight(context) * 0.2,
            bottom: viewModel.isKeyboardEnabled ? getDeviceHeight(context) * 0.6 : getDeviceHeight(context) * 0.2
          ),
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: viewModel.isDarkModeEnabled ?  Colors.white.withOpacity(0.6) :  Colors.black.withOpacity(0.6), blurStyle: BlurStyle.normal, blurRadius: 6.0, spreadRadius: 3.0)],
            borderRadius: BorderRadius.circular(25),
            color: viewModel.isDarkModeEnabled ? Colors.white.withOpacity(0.9) : Colors.black.withOpacity(0.9)
          ),
          child: Column(
            children: [
              // Document/Folder creation icon
              Container(
                width: getDeviceWidth(context) * 0.2,
                height: getDeviceHeight(context) * 0.2,
                margin: EdgeInsets.only(
                  left: getDeviceWidth(context) * 0.3,
                  right: getDeviceWidth(context) * 0.3,
                  top: viewModel.isKeyboardEnabled ? 0.0 : getDeviceHeight(context) * 0.025
                ),
                child: Icon(viewModel.isDocumentCreation ? Icons.note_add_outlined : Icons.create_new_folder_outlined, size: 65, color: viewModel.isDocumentCreation ? Colors.blueAccent : Colors.orangeAccent,),
              ),

              // Create text
              if (!viewModel.isKeyboardEnabled)
              Container(
                width: getDeviceWidth(context) * 0.6,
                height: getDeviceHeight(context) * 0.1,
                margin: EdgeInsets.only(
                  left: getDeviceWidth(context) * 0.05,
                  right: getDeviceWidth(context) * 0.05,
                  bottom: getDeviceWidth(context) * 0.05
                ),
                child: Text(viewModel.isDocumentCreation ? "Create a New File" : "Create a New folder", style: TextStyle(color: viewModel.isDarkModeEnabled ?  Colors.black : Colors.white, fontSize: getDeviceWidth(context) * 0.06, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
              ),

            ],
          ),
        ),
    );
  }
}