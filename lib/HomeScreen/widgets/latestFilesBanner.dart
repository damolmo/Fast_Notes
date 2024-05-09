import 'package:flutter/material.dart';
import '../../exports.dart';

class LatestFilesBanner extends StatelessWidget{
  @override
  const LatestFilesBanner({
    required this.viewModel,
    super.key
});

  final HomeScreenModel viewModel;

  @override
  Widget build(BuildContext context){
    return Container(
      width: getDeviceWidth(context) * 0.9,
      height: getDeviceHeight(context) * 0.1,
      margin: EdgeInsets.only(
        left: getDeviceWidth(context) * 0.05,
        right: getDeviceWidth(context) * 0.05,
        top: getDeviceHeight(context) * 0.325,
        bottom: getDeviceHeight(context) * 0.575
      ),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.8),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [BoxShadow(color: Colors.white.withOpacity(0.6), spreadRadius: 2.0, blurStyle: BlurStyle.normal, blurRadius: 3.0)]
      ),
      child: Row(
        children: [
          // Files Icon
          Container(
            width: getDeviceWidth(context) * 0.15,
            height: getDeviceHeight(context) * 0.10,
            margin: EdgeInsets.only(
              bottom: getDeviceHeight(context) * 0.025,
              top: getDeviceHeight(context) * 0.025,
              left: getDeviceWidth(context) * 0.05,
            ),
            child: const Icon(Icons.access_time_rounded, size: 40, color: Colors.orangeAccent,),
          ),

          // Files Banner
          Container(
            width: getDeviceWidth(context) * 0.65,
            height: getDeviceHeight(context) * 0.1,
            margin: EdgeInsets.only(
              top: getDeviceHeight(context) * 0.025,
              bottom: getDeviceHeight(context) * 0.025,
            ),
            child: Row(
              children: [
                const Spacer(),
                Text("Latest Files", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: getDeviceWidth(context) * 0.06), textAlign: TextAlign.center,),
                const Spacer(),
              ],
            ),
          )
        ],
      ),
    );
  }
}