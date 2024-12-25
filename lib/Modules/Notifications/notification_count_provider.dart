// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../Utilities/router_config.dart';
// import '../../Utilities/shared_preferences.dart';
// import '../../Utilities/toast_helper.dart';
//
// class NotificationCountProvider extends ChangeNotifier {
//   int count =0;
//   int totalCount =0;
//   bool isOpenChatDetails =true;
//   incrementChatCount() {
//     print("entered count");
//     count++;
//     SharedPref.saveChatCount(chatCount:count);
//     notifyListeners();
//   }
//   // incrementChatTotalCount() {
//   //   totalCount+=1;
//   //   SharedPref.saveTotalChatCount(chatCount:totalCount);
//   //   notifyListeners();
//   // }
//   decrementChatTotalCount({required int singleCount}){
//     if(count>0)
//     {
//       count-=singleCount;
//       SharedPref.saveChatCount(chatCount:count);
//     }
//     notifyListeners();
//   }
//   clearChatCount() {
//     count=0;
//     SharedPref.saveChatCount(chatCount:count);
//     notifyListeners();
//   }
//   // clearTotalChatCount() {
//   //   totalCount=0;
//   //   SharedPref.saveTotalChatCount(chatCount:count);
//   //   notifyListeners();
//   // }
//   getChatCount() {
//     count=SharedPref.getChatCount()??count;
//     notifyListeners();
//   }
//   // getTotalChatCount() {
//   //   totalCount=SharedPref.getTotalChatCount()??totalCount;
//   //   notifyListeners();
//   // }
//   onChangeShowLocalNotification({bool showLocalNotification=true}) {
//     isOpenChatDetails=showLocalNotification;
//     notifyListeners();
//   }
//
// }
