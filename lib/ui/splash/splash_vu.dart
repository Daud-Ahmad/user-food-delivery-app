import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:stacked/stacked.dart';
import 'splash_vm.dart';

class SplashScreen extends ViewModelBuilderWidget<SplashViewModel> {
  const SplashScreen({Key? key}) : super(key: key);


  @override
  bool get reactive => true;

  @override
  bool get createNewModelOnInsert => false;

  @override
  bool get disposeViewModel => true;

  @override
  bool get initialiseSpecialViewModelsOnce => true;// If you want to fire the initialisation logic only once you can set initialiseSpecialViewModelsOnce: true


  @override
  Widget builder(
      BuildContext context, SplashViewModel viewModel, Widget? child) {
    viewModel.onStartup(context);
    return PlatformScaffold(
      backgroundColor: const Color(0xFF8660D7),
      body: Center(
        child: Image.asset(
          'assets/app_logo.png',
          height: 200,
          width: 200,
        ),
      ),
    );
  }

  @override
  SplashViewModel viewModelBuilder(BuildContext context) {
    SplashViewModel vm = SplashViewModel();
    vm.initState();
    return vm;
  }
}
