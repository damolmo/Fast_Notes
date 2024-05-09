import 'package:flutter/material.dart';
import '../../exports.dart';

class DocumentsNavBar extends StatelessWidget{
  @override
  const DocumentsNavBar({
    required this.viewModel,
    super.key
});

  final DocumentScreenModel viewModel;

  @override
  Widget build(BuildContext context){
    return Container(
      width: getDeviceWidth(context) ,
      height: getDeviceHeight(context) * 0.1,
      margin : EdgeInsets.only(
        top: getDeviceHeight(context) * 0.875,
        bottom: getDeviceHeight(context) * 0.025,
        left: getDeviceWidth(context) * 0.025,
        right: getDeviceWidth(context) * 0.025,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: viewModel.isDarkModeEnabled ?  Colors.black.withOpacity(0.4) : Colors.white.withOpacity(0.6),
          boxShadow: [BoxShadow(color: viewModel.isDarkModeEnabled ?  Colors.white.withOpacity(0.6) : Colors.white.withOpacity(0.6), spreadRadius: 2.0, blurRadius: 3.0, blurStyle: BlurStyle.normal)]
      ),
      child: Row(
        children: [
          // Add Text Block Button
          InkWell(
            onTap : (){
             viewModel.addWidget("text", context);
            },
            child : Container(
              width: getDeviceWidth(context) * 0.425,
              height: getDeviceHeight(context) * 0.08,
              margin: EdgeInsets.only(
                top: getDeviceHeight(context) * 0.01,
                bottom: getDeviceHeight(context) * 0.01,
                left: getDeviceWidth(context) * 0.025,
                right: getDeviceWidth(context) * 0.025
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: viewModel.isDarkModeEnabled ? Colors.black.withOpacity(0.6) : Colors.white,
                boxShadow: [BoxShadow(color: viewModel.isDarkModeEnabled ?  Colors.white.withOpacity(0.6) : Colors.black.withOpacity(0.6), blurStyle: BlurStyle.normal, blurRadius: 3.0, spreadRadius: 2.0)]
              ),
              child: Row(
                children: [
                  // Icon
                  SizedBox(
                    width: getDeviceWidth(context) * 0.1,
                    height: getDeviceHeight(context),
                    child: const Icon(Icons.text_fields_rounded, color: Colors.orange, size: 35,),
                  ),

                  // Icon Text
                  SizedBox(
                    width: getDeviceWidth(context) * 0.3,
                    child: Text("Add Text", style: TextStyle(color: viewModel.isDarkModeEnabled ?  Colors.white : Colors.black, fontSize: getDeviceWidth(context) * 0.04, fontWeight: FontWeight.bold), textAlign: TextAlign.left,),
                  )
                ],
              ) ,
            ),
          ),

          // Remove Widget Button
          InkWell(
            onTap : (){
              viewModel.notesContent.removeLast();
              viewModel.currentWidgets.removeLast();
              viewModel.texts.removeLast();
              viewModel.textsIndexes.removeLast();
              viewModel.notifyListeners();

            },
            child : Container(
            width: getDeviceWidth(context) * 0.425,
            height: getDeviceHeight(context) * 0.1,
            margin: EdgeInsets.only(
                top: getDeviceHeight(context) * 0.01,
                bottom: getDeviceHeight(context) * 0.01,
                right: getDeviceWidth(context) * 0.025
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: viewModel.isDarkModeEnabled ? Colors.black.withOpacity(0.4) : Colors.white,
                boxShadow: [BoxShadow(color: viewModel.isDarkModeEnabled ?  Colors.white.withOpacity(0.6) : Colors.black.withOpacity(0.6), blurStyle: BlurStyle.normal, blurRadius: 3.0, spreadRadius: 2.0)]
            ),
            child: Row(
              children: [
                // Icon
                SizedBox(
                  width: getDeviceWidth(context) * 0.1,
                  height: getDeviceHeight(context),
                  child: const Icon(Icons.remove_circle_rounded, color: Colors.redAccent, size: 35,),
                ),

                // Icon Text
                SizedBox(
                  width: getDeviceWidth(context) * 0.3,
                  child: Text("Remove Latest", style: TextStyle(color: viewModel.isDarkModeEnabled ?  Colors.white : Colors.black, fontSize: getDeviceWidth(context) * 0.04, fontWeight: FontWeight.bold), textAlign: TextAlign.left,),
                )
              ],
              ) ,
            ),
          ),
        ],
      ),
    );
  }

}