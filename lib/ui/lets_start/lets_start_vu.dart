import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:stacked/stacked.dart';

import 'lets_start_vm.dart';

class LetsStartScreen extends ViewModelBuilderWidget<LetsStartViewModel> {
  const LetsStartScreen({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, LetsStartViewModel viewModel, Widget? child) {
    return PlatformScaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Image.asset(
            viewModel.showImageIndex == 0 ?
            'assets/one.png' :  viewModel.showImageIndex == 1 ?
            'assets/two.png' : 'assets/three.png',
            fit: BoxFit.fill,
            height: double.infinity,
            width: double.infinity,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30, bottom: 20),
              child: GestureDetector(
                onTap: (){
                  viewModel.onLetsStartClick(context);
                },
                child: SizedBox(
                  width: double.infinity,
                  height: 80,
                  child: Container(color: Colors.transparent,),
                ),
              ),
            ),
          )
        ],
      )
    );
  }

  @override
  LetsStartViewModel viewModelBuilder(BuildContext context) => LetsStartViewModel();
}
