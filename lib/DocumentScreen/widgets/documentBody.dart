import 'package:flutter/material.dart';
import '../../exports.dart';

class DocumentsBody extends StatelessWidget{
  @override
  const DocumentsBody({
    required this.viewModel,
    super.key
});

  final DocumentScreenModel viewModel;

  @override
  Widget build(BuildContext context){
    return Container(
      width: getDeviceWidth(context) * 0.9,
      height: getDeviceHeight(context) * 0.7,
      margin: EdgeInsets.only(
        left: getDeviceWidth(context) * 0.05,
        right: getDeviceWidth(context) * 0.05,
        top: getDeviceHeight(context) * 0.15,
        bottom: getDeviceHeight(context) * 0.15
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        boxShadow: [BoxShadow(color: viewModel.isDarkModeEnabled ?  Colors.white.withOpacity(0.6) : Colors.black.withOpacity(0.6), spreadRadius: 3.0, blurStyle: BlurStyle.normal, blurRadius: 3.0)],
        color: viewModel.isDarkModeEnabled ? Colors.black.withOpacity(0.9) : Colors.white
      ),
      child: ListView.builder(
          itemCount: viewModel.currentWidgets.length,
          itemBuilder: (context, index){
            return Container(
              width: getDeviceWidth(context) * 0.8,
              margin: EdgeInsets.only(
                left: getDeviceWidth(context) * 0.05,
                right: getDeviceWidth(context) * 0.05,
                bottom: getDeviceHeight(context) * 0.025
                 ),
              child: viewModel.currentWidgets[index],
              );
            },
        )
    );
  }

}