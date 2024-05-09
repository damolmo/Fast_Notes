import 'package:flutter/material.dart';
import '../../exports.dart';

class NavBarMenu extends StatelessWidget{
  @override
  const NavBarMenu({
    required this.viewModel,
    super.key
});

  final HomeScreenModel viewModel;

  @override
  Widget build(BuildContext context){
    return Container(
      width: getDeviceWidth(context) * 0.9,
      height: getDeviceHeight(context) * 0.15,
      margin: EdgeInsets.only(
        left: getDeviceWidth(context) * 0.05,
        right: getDeviceWidth(context) * 0.05,
        top: getDeviceHeight(context) * 0.825,
        bottom: getDeviceHeight(context) * 0.025
      ),
      child: Row(
        children: [
          // Documents Button
          InkWell(
            onTap : (){
              viewModel.isDocumentsView = true;
              viewModel.isFolderOpened = false;
              viewModel.getLatestNotes();
              viewModel.notifyListeners();
             },
            child : Container(
              width: getDeviceWidth(context) * 0.425,
              height: getDeviceHeight(context) * 0.1,
              margin: EdgeInsets.only(
                  top: getDeviceHeight(context) * 0.025,
                  right: getDeviceWidth(context) * 0.05,
                  bottom: getDeviceHeight(context) * 0.025
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                boxShadow: [BoxShadow(color: viewModel.isDarkModeEnabled ?  Colors.white.withOpacity(0.4) : Colors.black.withOpacity(0.4), blurStyle: BlurStyle.normal, blurRadius: 6.0, spreadRadius: 4.0, offset: Offset.zero)],
                color: viewModel.isDocumentsView ?  Colors.blueAccent.withOpacity(0.8) : Colors.black.withOpacity(0.8)
              ),
              child: Row(
                children: [
                  // Documents Button
                  Container(
                    width: getDeviceWidth(context) * 0.15,
                    height: getDeviceWidth(context) * 0.2,
                    margin : EdgeInsets.only(
                      left: getDeviceWidth(context) * 0.035,
                    ),
                    child: Icon(Icons.sticky_note_2_outlined, color: viewModel.isDocumentsView ? Colors.white : Colors.blueAccent, size: 35,),
                  ),

                  // Documents Text
                  Container(
                    width: getDeviceWidth(context) * 0.2,
                    height: getDeviceHeight(context) * 0.1,
                    margin: EdgeInsets.only(
                      right: getDeviceWidth(context) * 0.035
                    ),
                    child: Column(
                      children: [
                        const Spacer(),
                        Text("Documents", style: TextStyle(color: Colors.white, fontSize: getDeviceWidth(context) * 0.035, fontWeight: FontWeight.bold ), textAlign: TextAlign.center,),
                        const Spacer(),
                      ],
                    ),

                  )
                ],
              ),
            ),
          ),

          // Categories Button
          InkWell(
            onTap : () async {
              viewModel.sortCategories();

              if (viewModel.isCleanData){
                viewModel.isCleanData = false;
                viewModel.isFolderOpened = false;
                viewModel.notifyListeners();
              }
              viewModel.isDocumentsView = false;
              viewModel.notifyListeners();
            },
            child : Container(
              width: getDeviceWidth(context) * 0.425,
              height: getDeviceHeight(context) * 0.1,
              margin: EdgeInsets.only(
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [BoxShadow(color: viewModel.isDarkModeEnabled ?  Colors.white.withOpacity(0.4) : Colors.black.withOpacity(0.4), blurStyle: BlurStyle.normal, blurRadius: 6.0, spreadRadius: 4.0, offset: Offset.zero)],
                  color: !viewModel.isDocumentsView ?  Colors.orange : Colors.black.withOpacity(0.8)
              ),
              child: Row(
                children: [
                  // Documents Button
                  Container(
                    width: getDeviceWidth(context) * 0.15,
                    height: getDeviceWidth(context) * 0.2,
                    margin : EdgeInsets.only(
                      left: getDeviceWidth(context) * 0.035,
                    ),
                    child: Icon(Icons.folder_outlined, color: !viewModel.isDocumentsView ?  Colors.white : Colors.orangeAccent, size: 35,),
                  ),

                  // Documents Text
                  Container(
                    width: getDeviceWidth(context) * 0.2,
                    height: getDeviceHeight(context) * 0.1,
                    margin: EdgeInsets.only(
                        right: getDeviceWidth(context) * 0.035
                    ),
                    child: Column(
                      children: [
                        const Spacer(),
                        Text("Folders", style: TextStyle(color: Colors.white, fontSize: getDeviceWidth(context) * 0.035, fontWeight: FontWeight.bold ), textAlign: TextAlign.center,),
                        const Spacer(),
                      ],
                    ),

                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

}