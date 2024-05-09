import 'package:flutter/material.dart';
import '../../exports.dart';

class LatestFiles extends StatelessWidget{
  @override
  const LatestFiles({
    required this.viewModel,
    super.key
});

  final HomeScreenModel viewModel;

  @override
  Widget build(BuildContext context){
    return Container(
      width: getDeviceWidth(context) * 0.9,
      height: getDeviceHeight(context) * 0.3,
      margin: EdgeInsets.only(
        top: getDeviceHeight(context) * 0.45,
        bottom: getDeviceHeight(context) * 0.25,
        left: getDeviceWidth(context) * 0.05,
        right: getDeviceWidth(context) * 0.05
      ),
      decoration: BoxDecoration(
        boxShadow: const [BoxShadow(color: Colors.white, blurRadius: 6.0, spreadRadius: 3.0, blurStyle: BlurStyle.normal)],
        color: Colors.black.withOpacity(0.8),
        borderRadius: BorderRadius.circular(25)
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
          itemCount: viewModel.latestNotes.length,
          itemBuilder: (context, index){
            return InkWell(
              onTap : (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => DocumentScreenView(document: viewModel.latestNotes[index])));

              },
                child : Container(
                  width: getDeviceWidth(context) * 0.3,
                  height: getDeviceHeight(context) * 0.25,
                  margin: EdgeInsets.only(
                      top: getDeviceHeight(context) * 0.025,
                      bottom : getDeviceHeight(context) * 0.025,
                      left: getDeviceWidth(context) * 0.05
                   ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.black.withOpacity(0.8),
                    boxShadow: [BoxShadow(color:Colors.white.withOpacity(0.8), spreadRadius: 2.0, blurStyle: BlurStyle.normal, blurRadius: 2.0)]
                  ),
                  child: Column(
                    children: [

                      // File Icon
                      Container(
                        width: getDeviceHeight(context) * 0.2,
                        height: getDeviceHeight(context) * 0.15,
                        margin: EdgeInsets.only(
                          left: getDeviceWidth(context) * 0.05,
                          right: getDeviceWidth(context) * 0.05,
                        ),
                        child: const Icon(Icons.file_open_rounded, size: 55, color: Colors.blueAccent,),
                      ),

                      // File Name
                      Container(
                        width: getDeviceWidth(context) * 0.25,
                        height: getDeviceWidth(context) * 0.05,
                        margin: EdgeInsets.only(
                          left: getDeviceWidth(context) * 0.025,
                          right: getDeviceWidth(context) * 0.025,
                          bottom: getDeviceHeight(context) * 0.016
                        ),
                        child: Row(
                          children: [
                            const Spacer(),
                            Text(viewModel.latestNotes[index].noteName, style: TextStyle(color: Colors.white, fontSize: getDeviceWidth(context) * 0.04, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                            const Spacer(),
                          ],
                        ),
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