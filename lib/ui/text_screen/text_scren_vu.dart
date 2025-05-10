import 'package:flutter/material.dart';
import 'package:mura_user_app/ui/text_screen/text_screen_vm.dart';
import 'package:stacked/stacked.dart';

class TextScreen extends ViewModelBuilderWidget<TextScreenViewModel> {
  const TextScreen({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, TextScreenViewModel viewModel, Widget? child) {
    return Scaffold(
      body: SingleChildScrollView(
        // child: html("YOUR HTML STRING HERE"),
      )
    );
  }

  @override
  TextScreenViewModel viewModelBuilder(BuildContext context) => TextScreenViewModel();
}
