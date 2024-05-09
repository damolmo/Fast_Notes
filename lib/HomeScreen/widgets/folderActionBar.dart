import 'package:flutter/material.dart';
import '../../exports.dart';

class FolderActionBar extends StatelessWidget{

  @override
  const FolderActionBar({
    required this.viewModel,
    super.key
});

  final HomeScreenModel viewModel;

  @override
  Widget build(BuildContext context){
    return Container(
      width: getDeviceWidth(context) * 0.9,
      height: getDeviceHeight(context) * 0.05,
      margin: EdgeInsets.only(
        left: getDeviceWidth(context) * 0.05,
        right: getDeviceWidth(context) * 0.05,
        top: getDeviceHeight(context) * 0.315,
        bottom: getDeviceHeight(context) * 0.625,
      ),
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(color: Colors.white.withOpacity(0.6) , blurRadius: 6.0, spreadRadius: 2.0, blurStyle: BlurStyle.normal)],
        borderRadius: BorderRadius.circular(25),
        color: Colors.black.withOpacity(0.8)
      ),
      child: Row(
        children: [
          // Short Alphabetically Icon
          InkWell(
            onTap :(){
              viewModel.isShortAlphabetically ? viewModel.isShortAlphabetically = false : viewModel.isShortAlphabetically = true;
              viewModel.notifyListeners();
              viewModel.sortCategories();
          },
            child : Container(
            width: getDeviceWidth(context) * 0.2,
            margin: EdgeInsets.only(
              left: getDeviceWidth(context) * 0.05,
              right: viewModel.isFolderOpened ? getDeviceWidth(context) * 0.4 : getDeviceWidth(context) * 0.1,
            ),
            child: Icon(Icons.sort_by_alpha_rounded, color: viewModel.isShortAlphabetically ? Colors.green : Colors.redAccent, size: 35,),
            ),
          ),

          // Size Button
          if (!viewModel.isFolderOpened)
          InkWell(
            onTap: () {
              viewModel.isSortByWeight ? viewModel.isSortByWeight = false : viewModel.isSortByWeight = true;
              viewModel.notifyListeners();
              viewModel.getCategoryByWeight();
            },
            child : Container(
            width: getDeviceWidth(context) * 0.2,
            margin: EdgeInsets.only(
              right: getDeviceWidth(context) * 0.1
            ),
            child: Icon(viewModel.isSortByWeight ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded, color: viewModel.isSortByWeight ? Colors.green : Colors.redAccent, size: 35,),
           ),
          ),

          // Grid button
          InkWell(
            onTap : (){
              viewModel.isGridX3 ? viewModel.isGridX3 = false : viewModel.isGridX3 = true;
              viewModel.notifyListeners();
          },
            child : Container(
            width: getDeviceWidth(context) * 0.2,
            margin: EdgeInsets.only(
              right: getDeviceWidth(context) * 0.05,
            ),
            child: Icon(viewModel.isGridX3 ? Icons.grid_3x3_rounded : Icons.grid_on, color: Colors.white, size: 35,),
          ),
          )
        ],
      ),
    );
  }
}