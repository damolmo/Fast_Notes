import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../exports.dart';

class CreationField extends StatelessWidget{
  @override
  const CreationField({
    required this.viewModel,
    super.key
});

  final HomeScreenModel viewModel;

  @override
  Widget build(BuildContext context){
    return Container(
      width: getDeviceWidth(context) * 0.5,
      height: getDeviceHeight(context) * 0.1,
      margin: EdgeInsets.only(
          left: getDeviceWidth(context) * 0.25,
          right: getDeviceWidth(context) * 0.25,
          top: viewModel.isKeyboardEnabled ? getDeviceHeight(context) * 0.25 : getDeviceHeight(context) * 0.6,
          bottom: viewModel.isKeyboardEnabled ? getDeviceWidth(context) * 0.05 : getDeviceHeight(context) * 0.3
      ),
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.7),
          borderRadius: BorderRadius.circular(15),
          boxShadow:const  [BoxShadow(color: Colors.white, blurRadius: 4.0, spreadRadius: 4.0, blurStyle: BlurStyle.normal)]
      ),
      child: TextField(
          style : const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
          onTap: (){
            viewModel.isKeyboardEnabled = true;
            viewModel.notifyListeners();
          },
          onEditingComplete: (){
            SystemChannels.textInput.invokeMethod('TextInput.hide');
            viewModel.isKeyboardEnabled = false;
            viewModel.isCreationWindow = false;
            viewModel.enabledNewDocMenu = false;
            viewModel.notifyListeners();
            if (!viewModel.isDocumentCreation){
              viewModel.addCategory();
            } else {
              if (viewModel.categories.isNotEmpty){
                viewModel.isCategorySelection = true;
                viewModel.notifyListeners();
              } else {
                viewModel.notifyUserAlert("Your Categories folder is empty\nCreate a Category first!", context);
              }

            }
          },
          textAlign: TextAlign.center,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: viewModel.isDocumentCreation ? "Enter a Filename" :  "Enter a Folder name",
              hintStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25)
          ),
          controller: viewModel.nameField,
          keyboardType: TextInputType.name
      ),
    );
  }

}