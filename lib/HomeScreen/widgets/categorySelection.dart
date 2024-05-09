import 'package:flutter/material.dart';
import '../../exports.dart';

class CategorySelection extends StatelessWidget{
  @override
  const CategorySelection({
    required this.viewModel,
    super.key
});

  final HomeScreenModel viewModel;

  @override
  Widget build(BuildContext context){
    return Container(
      width: getDeviceWidth(context) * 0.8,
      height: getDeviceHeight(context) * 0.8,
      margin: EdgeInsets.only(
        left: getDeviceWidth(context) * 0.1,
        right: getDeviceWidth(context) * 0.1,
        top: getDeviceHeight(context) * 0.15,
        bottom: getDeviceHeight(context) * 0.1
      ),

      child: Column(
        children : [

          // Select Category Message
          Container(
            width: getDeviceWidth(context) * 0.8,
            height: getDeviceHeight(context) * 0.1,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [BoxShadow(color: viewModel.isDarkModeEnabled ? Colors.white.withOpacity(0.6) : Colors.black.withOpacity(0.6), spreadRadius: 3.0, blurStyle: BlurStyle.normal, blurRadius: 6.0)]
          ),
            child: Row(
              children: [
                const Spacer(),
                Text("Choose Category", style: TextStyle(color: Colors.white, fontSize: getDeviceWidth(context) * 0.07, fontWeight: FontWeight.bold ), textAlign: TextAlign.center,),
                const Spacer(),
              ],
            ),

          ),

          // Select Category ListView
        Container(
            width: getDeviceWidth(context) * 0.8,
            height: getDeviceHeight(context) * 0.55,
            margin: EdgeInsets.only(
              top: getDeviceHeight(context) * 0.025,
                bottom: getDeviceHeight(context) * 0.025
            ),
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [BoxShadow(color: viewModel.isDarkModeEnabled ? Colors.white.withOpacity(0.6) : Colors.black.withOpacity(0.6), spreadRadius: 3.0, blurStyle: BlurStyle.normal, blurRadius: 6.0)]
            ),
            child:ListView.builder(
              itemCount: viewModel.categories.length,
              itemBuilder: (context,index){
              return InkWell(
                onTap : (){
                  viewModel.choosedCategorySelection = index;
                  viewModel.addNote();
                  viewModel.isCategorySelection = false;
                  viewModel.notifyListeners();

                },
                  child : Container(
                    width: getDeviceWidth(context) * 0.6,
                    height: getDeviceHeight(context) * 0.1,
                    margin: EdgeInsets.only(
                      left: getDeviceWidth(context) * 0.1,
                      right: getDeviceWidth(context) * 0.1,
                      top: getDeviceHeight(context) * 0.025
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.black.withOpacity(0.6),
                      boxShadow: [BoxShadow(color: Colors.white.withOpacity(0.6), spreadRadius: 2.0, blurRadius: 4.0, blurStyle: BlurStyle.normal)]
                    ),
                    child: Row(
                      children: [
                        const Spacer(),
                        Text(viewModel.categories[index].categoryName, style: TextStyle(color: Colors.white, fontSize: getDeviceWidth(context) * 0.05, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                        const Spacer()
                      ],
                    ),
                  ),
                );
              },
            ),
        ),
        ]
      )
    );
  }

}