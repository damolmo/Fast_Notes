import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../exports.dart';

class DocumentAppBar extends StatelessWidget{
  @override
  const DocumentAppBar({
    required this.viewModel,
    super.key
});

  final DocumentScreenModel viewModel;

  @override
  Widget build(BuildContext context){
    return Container(
      width: getDeviceWidth(context) * 0.9,
      height: getDeviceHeight(context) * 0.1,
      margin: EdgeInsets.only(
        top: getDeviceHeight(context) * 0.025,
        bottom: getDeviceHeight(context) * 0.875,
        left: getDeviceWidth(context) * 0.05,
        right: getDeviceWidth(context) * 0.05,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: viewModel.isDarkModeEnabled ?  Colors.black.withOpacity(0.4) : Colors.white.withOpacity(0.6),
          boxShadow: [BoxShadow(color: viewModel.isDarkModeEnabled ?  Colors.white.withOpacity(0.6) : Colors.white.withOpacity(0.6), spreadRadius: 2.0, blurRadius: 3.0, blurStyle: BlurStyle.normal)]
      ),
      child: Row(
        children: [
          // Name Field
          Container(
            width : getDeviceWidth(context) * 0.6,
            height: getDeviceHeight(context) * 0.1,
            margin: EdgeInsets.only(
            ),
            child: TextField(
              onEditingComplete: (){
                SystemChannels.textInput.invokeMethod('TextInput.hide');
              },

              textAlign: TextAlign.center,
              style: TextStyle(color: viewModel.isDarkModeEnabled ?  Colors.white : Colors.black, fontWeight: FontWeight.bold, fontSize: getDeviceWidth(context) * 0.06),
              decoration: InputDecoration(
                border : InputBorder.none,
                hintText: "Enter a filename",
                hintStyle: TextStyle(color: viewModel.isDarkModeEnabled ? Colors.white : Colors.black, fontSize: getDeviceWidth(context) * 0.06, fontWeight: FontWeight.bold)
              ),
              controller: viewModel.nameField,
              keyboardType: TextInputType.name,
            ),
          ),

          // Name Confirm Button
          InkWell(
            onTap : (){
              viewModel.saveModificatedNote();
              viewModel.saveNoteContents(context);
            },
            child : Container(
            width: getDeviceWidth(context) * 0.1,
            height: getDeviceHeight(context) * 0.1,
            margin: EdgeInsets.only(
              right: getDeviceWidth(context) * 0.05
            ),
            child: const Icon(Icons.done_rounded, color: Colors.blueAccent, size : 35),
            ),
          ),

          // More Details Button
          InkWell(
            onTap : (){
              viewModel.isDarkModeEnabled ? viewModel.isDarkModeEnabled =  false : viewModel.isDarkModeEnabled = true;
              viewModel.notifyListeners();
            },
            child : Container(
              width: getDeviceWidth(context) * 0.1,
              height: getDeviceHeight(context) * 0.1,
              margin: EdgeInsets.only(
                  right: getDeviceWidth(context) * 0.05
              ),
              child: Icon(viewModel.isDarkModeEnabled ? Icons.dark_mode_rounded : Icons.light_mode_rounded, color: viewModel.isDarkModeEnabled ?  Colors.white : Colors.black, size : 45),
            ),
          ),

        ],
      ),
    );
  }
}