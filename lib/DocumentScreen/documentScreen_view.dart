import '../exports.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class DocumentScreenView extends StackedView<DocumentScreenModel>{
  @override
  const DocumentScreenView({
    required this.document,
    super.key});

  final Notes document;

  @override
  Widget builder(
      BuildContext context,
      DocumentScreenModel viewModel,
      Widget? child
      ){

    viewModel.nameField.text = document.noteName;
    viewModel.note = document;
    viewModel.context = context;
    if (!viewModel.readData){
      viewModel.readDataFromFile();
      viewModel.readData = true;
    }
    viewModel.notifyListeners();

    return PopScope(
      canPop : false,
        onPopInvoked: (_){
        // show exit dialog
          viewModel.showExitDialog = true;
          viewModel.notifyListeners();
        },
        child: Scaffold(
            resizeToAvoidBottomInset : false,
            body : Stack(
            children: [

              BackgroundTheme(viewModel: viewModel),

              // Document Name Field && Save Button
              DocumentAppBar(viewModel: viewModel),

              // Document Body
              DocumentsBody(viewModel: viewModel),

              // Document action navBar
              DocumentsNavBar(viewModel: viewModel),
            ],
          )
        ),
    );
  }

  @override
  DocumentScreenModel viewModelBuilder(BuildContext context) => DocumentScreenModel();
}