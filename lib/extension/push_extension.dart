import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension pushExtension on BuildContext{

  Future<dynamic> pushEnd(Widget page)async{
    return Navigator.pushAndRemoveUntil(this,
     MaterialPageRoute(builder: (context) => page), (route) => false);
  }

  Future<dynamic> push(Widget page)async{
    return Navigator.push(this,
     MaterialPageRoute(builder: (context) => page));
  }

}

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBarNoti(BuildContext context,String message){
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 12,
        dismissDirection: DismissDirection.horizontal,
        content: Text(message,
        style:const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),),
        backgroundColor: Colors.red[700],
        behavior: SnackBarBehavior.floating,
         shape:const RoundedRectangleBorder(
       borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      ),
    );
  }