import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../exports.dart';

class HomeScreenView extends StackedView<HomeScreenModel>{
  @override
  const HomeScreenView({super.key});

  @override
  Widget builder(
      BuildContext context,
      HomeScreenModel viewModel,
      Widget? child
      ){
    return PopScope(
      canPop: viewModel.isCreationWindow || viewModel.enabledNewDocMenu || viewModel.isFolderOpened ?  false :  true,
        onPopInvoked: (_){
          viewModel.isDocumentCreation = false;
          viewModel.isKeyboardEnabled = false;
          viewModel.isCreationWindow = false;
          viewModel.isFolderOpened = false;
          viewModel.notifyListeners();
        },
        child: Scaffold(
          resizeToAvoidBottomInset : false,
          body: Stack(
            children : [

              // Background Theme
              BackgroundTheme(viewModel: viewModel),

              // Banner
              CustomBanner(viewModel: viewModel),

              // Folders action bar
              if (!viewModel.isDocumentsView)
                FolderActionBar(viewModel: viewModel),

              // Folders grid
              if (!viewModel.isDocumentsView && !viewModel.isFolderOpened)
                FolderGrid(viewModel: viewModel),

              // Documents Grid
              if (viewModel.isFolderOpened)
                DocumentsGrid(viewModel: viewModel),

              // Latest Files Banner
              if (viewModel.isDocumentsView && viewModel.latestNotes.isNotEmpty)
                LatestFilesBanner(viewModel: viewModel),

              // Latest Files List
              if (viewModel.isDocumentsView && viewModel.latestNotes.isNotEmpty)
                LatestFiles(viewModel: viewModel),

              // Floating Action Button
              NewDocumentsButton(viewModel: viewModel),

              // New Doc Menu
              if (viewModel.enabledNewDocMenu)
                NewDocMenu(viewModel: viewModel),

              // Creation Windows
              if (viewModel.isCreationWindow && !viewModel.isCategorySelection)
                CreationWindow(viewModel: viewModel),

              // Category Selection
              if (viewModel.isCategorySelection && viewModel.categories.isNotEmpty)
                CategorySelection(viewModel: viewModel),

              // Creation Field
              if (viewModel.isCreationWindow)
                CreationField(viewModel: viewModel),

              // NavBar
              NavBarMenu(viewModel : viewModel),

            ]
          ),
        ),
    );
  }

  @override
  HomeScreenModel viewModelBuilder(BuildContext context) => HomeScreenModel();
}