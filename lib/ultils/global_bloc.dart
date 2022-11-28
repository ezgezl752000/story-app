import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ns_read_story/model/user.dart';
import 'package:ns_read_story/page_routes.dart';
import 'package:ns_read_story/shared/dialog.dart';

class AppProvider with ChangeNotifier {
  String languageCode = "vi";
  String? token;
  UserModel user = UserModel();
  bool? isAuthor;
  bool? isAttended;
  String? typeLogin;

  bool interstitialReady = false;
  InterstitialAd? interstitialAd;

  RewardedAd? rewardedAd;
  int numRewardedLoadAttempts = 0;

  RewardedInterstitialAd? rewardedInterstitialAd;
  int numRewardedInterstitialLoadAttempts = 0;

  String firebaseToken = "";

  showDialogLogin(BuildContext context, String mess) {
    showDialog(
        context: context,
        builder: (_) {
          return Dialog(
            child: DialogLogin(
              action: () {
                Navigator.of(context, rootNavigator: true)
                    .pushNamed(PageRoutes.login, arguments: 0);
              },
              mess: mess,
            ),
          );
        });
  }

  void changeNavigation() {
    notifyListeners();
  }

  AppProvider._();

  static final AppProvider instance = AppProvider._();
}
