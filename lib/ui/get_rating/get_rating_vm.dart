import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

import '../../components/alerts.dart';
import '../../models/orders_list_resp.dart';
import '../../models/requests.dart';
import '../../network/system_api_service.dart';

class GetRatingViewModel extends BaseViewModel {

  OrdersListResp? orderDetailResp;

  double userRating = 0.0;

  final formKey = GlobalKey<FormState>();


  String? feedBack = '';

  getOrderDetail(BuildContext context){
    orderDetailResp = ModalRoute.of(context)!.settings.arguments as OrdersListResp;
  }

  String gettingMenuNameAndQuantity(){
    String menu = '';
    List<OrdersItems> itemDetailsList = orderDetailResp!.itemDetailsList!;
    for(int i = 0; i < itemDetailsList.length; i++){
      if(i == 0){
        menu = '${itemDetailsList[i].itemDetailsList![0].title}   x${itemDetailsList[i].qty}';
      }
      else{
        menu = '$menu , ${itemDetailsList[i].itemDetailsList![0].title}   x${itemDetailsList[i].qty}';
      }
    }

    return menu;
  }

  String? feedbackValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Feedback is required';
    }
    return null;
  }

  inputFeedback(String? value) {
    feedBack = value!.trim();
    notifyListeners();
  }

  onClickSubmit(BuildContext context){
    formKey.currentState!.save();

    if (formKey.currentState == null) {
      return;
    }

    if (!formKey.currentState!.validate()) {
      return;
    }

    if(userRating == 0){
      showAlert(context, title: 'Add Rating',
          message: 'Please add rating');
      return;
    }

    onClickAddRating(context);
  }

  onClickAddRating(BuildContext context) async{
    showProgress(context);
    final req = await makeAddReviewRequest(userId: orderDetailResp!.userDetail!.id.toString(),
        preperId: orderDetailResp!.preperDetail!.id.toString(),
        rating: userRating.toString(), review: feedBack!,
        orderId: orderDetailResp!.id.toString(),);
    final resp = await SystemApiService.addReview(req);
    if (resp.isSuccess) {
      hideProgress(context);
      showSuccessAlert(context, title: 'Review Added',
          message: 'Your review added successfully', onConfirmClick: (){
            Navigator.pop(context);
            Navigator.pop(context);
          });
    } else {
      hideProgress(context);
      showErrorAlert(context,
          title: 'Error',
          message: resp.message ?? resp.error ?? 'Error occurred while adding review',
          onConfirmClick: () {
            Navigator.pop(context);
            Navigator.pop(context);
          });
    }
  }

  onClickSkipRating(BuildContext context) async{
    showProgress(context);
    final resp = await SystemApiService.skipReview(orderDetailResp!.id.toString());
    if (resp.isSuccess) {
      hideProgress(context);
      Navigator.pop(context);
    } else {
      hideProgress(context);
      Navigator.pop(context);
    }
  }

}
