import 'package:flutter/material.dart';
import '../../exports.dart';

class DocumentsGrid extends StatelessWidget{
  @override
  const DocumentsGrid({
   required this.viewModel,
   super.key
});

  final HomeScreenModel viewModel;

  @override
  Widget build(BuildContext context){
    return Container(
      width: getDeviceWidth(context) * 0.9,
      height: getDeviceHeight(context) * 0.5,
      margin: EdgeInsets.only(
          left: getDeviceWidth(context) * 0.05,
          right: getDeviceWidth(context) * 0.05,
          top: getDeviceHeight(context) * 0.37,
          bottom: getDeviceHeight(context) * 0.15
      ),
      child: GridView.builder(
          itemCount: viewModel.notes.length,
          gridDelegate: !viewModel.isGridX3 ? const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2 ) : const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3 ),
          itemBuilder: (context, index){
        return InkWell(
          onTap : (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => DocumentScreenView(document: viewModel.notes[index])));
          },
            child : Container(
              width: !viewModel.isGridX3 ? getDeviceWidth(context) * 0.425 : getDeviceWidth(context) * 0.9,
              height: !viewModel.isGridX3 ? getDeviceHeight(context) * 0.5 : getDeviceHeight(context) * 0.2,
              margin: EdgeInsets.only(
                top: getDeviceHeight(context) * 0.025,
                left: !viewModel.isGridX3 ? getDeviceWidth(context) * 0.035 : getDeviceWidth(context) * 0.05,
                right: !viewModel.isGridX3 ? getDeviceWidth(context) * 0.035 : getDeviceWidth(context) * 0.05,
                ),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8),
                borderRadius: BorderRadius.circular(25),
                boxShadow: const [BoxShadow(color: Colors.white, blurStyle: BlurStyle.normal, blurRadius: 6.0, spreadRadius: 3.0)]
                ),
              child: Stack(
                children: [
                // File Icon
                  Container(
                  width: getDeviceWidth(context) * 0.35,
                  height: !viewModel.isGridX3 ? getDeviceHeight(context) * 0.15 : getDeviceHeight(context) * 0.1,
                  margin: EdgeInsets.only(
                  left: getDeviceWidth(context) * 0.035,
                  right: getDeviceWidth(context) * 0.035,
                  ),
                  child: Icon(Icons.file_open, color: Colors.blueAccent, size: !viewModel.isGridX3 ? 70 : 45 ,),
                  ),

                  // File Name
                  Container(
                  width: getDeviceWidth(context) * 0.4,
                  height: getDeviceHeight(context) * 0.1,
                  margin: EdgeInsets.only(
                  top: !viewModel.isGridX3 ? getDeviceHeight(context) * 0.12 : getDeviceHeight(context) * 0.08,
                  left: getDeviceWidth(context) * 0.0125,
                  right: getDeviceWidth(context) * 0.0125,
                  ),
                  child: Text(viewModel.notes[index].noteName, style: TextStyle(color: Colors.white, fontSize: !viewModel.isGridX3 ? getDeviceWidth(context) * 0.05 :  getDeviceWidth(context) * 0.035, fontWeight: FontWeight.bold), textAlign: TextAlign.center
                  ,),
                  ),

                  // File Date
                  Container(
                  width: getDeviceWidth(context) * 0.2,
                  height: !viewModel.isGridX3 ? getDeviceHeight(context) * 0.07 : getDeviceHeight(context) * 0.05,
                  margin: EdgeInsets.only(
                  top: !viewModel.isGridX3 ? getDeviceHeight(context) * 0.16 : 0.0,
                  left: getDeviceWidth(context) * 0.1125,
                  right: getDeviceWidth(context) * 0.1125
                  ),
                  child: Text(viewModel.notes[index].noteModificationDate, style: TextStyle(color: Colors.white, fontSize: !viewModel.isGridX3 ? getDeviceWidth(context) * 0.025 : getDeviceWidth(context) * 0.02), textAlign: TextAlign.center,),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }


}