import 'package:flutter/material.dart';
import '../../exports.dart';

class NewDocMenu extends StatelessWidget{
  @override
  const NewDocMenu({
    required this.viewModel,
    super.key
});

  final HomeScreenModel viewModel;

  @override
  Widget build(BuildContext context){
    return Container(
      width: getDeviceWidth(context) * 0.7,
      height: getDeviceHeight(context) * 0.6,
      margin: EdgeInsets.only(
        top: getDeviceHeight(context) * 0.3,
        bottom: getDeviceHeight(context) * 0.1,
        left: getDeviceWidth(context) * 0.3,
      ),
      child: Stack(
        children: [
          // New Doc Button
          Container(
            height: getDeviceHeight(context) * 0.08,
            width: getDeviceWidth(context) * 0.4,
            margin: EdgeInsets.only(
              left: getDeviceWidth(context) * 0.15,
              right: getDeviceWidth(context) * 0.05,
              top: getDeviceHeight(context) * 0.26,
              bottom: getDeviceHeight(context) * 0.16
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color:  Colors.black.withOpacity(0.8),
              boxShadow: [BoxShadow(color: viewModel.isDarkModeEnabled ? Colors.white.withOpacity(0.6) : Colors.black.withOpacity(0.6), spreadRadius: 2.0, blurRadius: 10.0, blurStyle: BlurStyle.normal, offset: Offset.zero)]
            ),
            child: InkWell(
              onTap : (){
                viewModel.isDocumentCreation = true;
                viewModel.isCreationWindow = true;
                viewModel.notifyListeners();
              },
              child :  Row(
                children: [
                  // Doc Icon
                  Container(
                    width: getDeviceWidth(context) * 0.06,
                    height: getDeviceHeight(context) * 0.1,
                    margin: EdgeInsets.only(
                      right: getDeviceWidth(context) * 0.025
                    ),
                    child: const Icon(Icons.note_add_outlined, size: 35, color: Colors.blueAccent),
                  ),

                  // Doc Text
                  Container(
                    width: getDeviceWidth(context) * 0.3,
                    height: getDeviceHeight(context) * 0.1,
                    margin: EdgeInsets.only(
                      right: getDeviceWidth(context) * 0.015
                    ),
                    child: Column(
                      children  : [
                        const Spacer(),
                        Text("New Document", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: getDeviceWidth(context) *  0.035),),
                        const Spacer(),

                      ] )
                  ),
                ],
              ),
            ),
          ),

          // New Category Button
          Container(
            height: getDeviceHeight(context) * 0.08,
            width: getDeviceWidth(context) * 0.4,
            margin: EdgeInsets.only(
                right: getDeviceWidth(context) * 0.2,
                top: getDeviceHeight(context) * 0.38,
                bottom: getDeviceHeight(context) * 0.03
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black.withOpacity(0.8),
                boxShadow: [BoxShadow(color: viewModel.isDarkModeEnabled ? Colors.white.withOpacity(0.6) : Colors.black.withOpacity(0.6), spreadRadius: 2.0, blurRadius: 10.0, blurStyle: BlurStyle.normal, offset: Offset.zero)]
            ),
            child: InkWell(
              onTap : (){
                viewModel.isDocumentCreation = false;
                viewModel.isCreationWindow = true;
                viewModel.notifyListeners();
              },
              child : Row(
                children: [
                  // Doc Icon
                  Container(
                    width: getDeviceWidth(context) * 0.06,
                    height: getDeviceHeight(context) * 0.1,
                    margin: EdgeInsets.only(
                    ),
                    child: const Icon(Icons.create_new_folder_outlined, size: 35, color: Colors.orangeAccent),
                  ),

                  // Doc Text
                  Container(
                      width: getDeviceWidth(context) * 0.3,
                      height: getDeviceHeight(context) * 0.1,
                      margin: EdgeInsets.only(
                          right: getDeviceWidth(context) * 0.015
                      ),
                      child: Column(
                          children  : [
                            const Spacer(),
                            Text("New Folder", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: getDeviceWidth(context) *  0.035),),
                            const Spacer(),

                          ] )
                  ),
                ],
             ),
            ),
          ),

        ],
      ),

    );
  }
}