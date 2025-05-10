import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../components/alerts.dart';
import '../../../../components/image_picker_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import '../../../../models/requests.dart';
import '../../../../network/system_api_service.dart';
import '../../../../preferences.dart';

class ContactUsViewModel extends BaseViewModel {

  int pageIndex = 4;
  final formKey = GlobalKey<FormState>();
  final formKeyDialog = GlobalKey<FormState>();
  String? problemDesc = '';
  String? screenShortImageLink = '';

  XFile? screenShortPath;
  final ImagePicker screenShortImagePicker = ImagePicker();

  String? problemDescValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Problem Description is required';
    }
    return null;
  }

  inputProblemDesc(String? value) {
    problemDesc = value!.trim();
    notifyListeners();
  }

  onClickSubmit(context) async {
      formKey.currentState!.save();

      if (formKey.currentState == null) {
        return;
      }

      if (!formKey.currentState!.validate()) {
        return;
      }

      if(screenShortPath != null){
        uploadImage(context);
      }
      else{
        showProgress(context);
        onContactUs(context);
      }
    }

  onContactUs(BuildContext context) async {
    final userId = await Preferences.getKey(Preferences.kUserId);
    print('==================onContactUs$screenShortImageLink');
    final req = await makeContactUsRequest(userId: userId!, message: problemDesc!, image: screenShortImageLink);
    final resp = await SystemApiService.contactUs(req);
    if (resp.isSuccess) {
      hideProgress(context);
      showSuccessAlert(context, title: 'Message Submitted',
          message: 'Your message Submitted. We get contact you soon', onConfirmClick: (){
        Navigator.pop(context);
        Navigator.pop(context);
      });

    } else {
      hideProgress(context);
      showErrorAlert(context,
          title: 'Error',
          message: resp.message ?? resp.error ?? 'Error occurred while getting data',
          onConfirmClick: () {
            Navigator.pop(context);
          });
    }

  }

  onClickScreenShortImage(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext dialogContext) => imagePickerDialog(
          dialogContext,
              () async {
            try {
              final pickedFile = await screenShortImagePicker.pickImage(
                source: ImageSource.gallery,
              );
              screenShortPath = pickedFile;
              notifyListeners();
            } catch (e) {}
          },
        ));
  }

  uploadImage(BuildContext context) async {
    showProgress(context, title: 'uploading...');
    final req = await http.MultipartFile.fromPath('image', screenShortPath!.path,
        filename:screenShortPath!.name, contentType: MediaType('image', 'jpg'));
    final resp = await SystemApiService.imageUpload(req, 'messages');
    if (resp.isSuccess) {
      screenShortImageLink = resp.image;
      print('==================resp.image${resp.image}');
      print('==================uploadImage$screenShortImageLink');
      onContactUs(context);
    } else {
      hideProgress(context);
      showAlert(context,
          title: 'Image Not Uploaded',
          message:
          resp.message ?? resp.error ?? 'Error occurred while uploading image.');
    }
  }
}
