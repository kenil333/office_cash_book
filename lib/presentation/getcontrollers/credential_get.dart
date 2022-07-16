import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/all.dart';

class CredentialGet extends GetxController {
  TextEditingController lphonecont = TextEditingController();
  TextEditingController lpasscont = TextEditingController();
  TextEditingController rpasscont = TextEditingController();
  TextEditingController rconfpasscont = TextEditingController();
  TextEditingController rnamecont = TextEditingController();
  TextEditingController rcompanycont = TextEditingController();
  TextEditingController fpasscont = TextEditingController();
  TextEditingController fpassconfcont = TextEditingController();
  RxBool loadingotp = false.obs;

  custsnak(String error) {
    Get.snackbar(
      "Alert !",
      error,
      backgroundColor: AppColor.butred,
      borderRadius: 10,
      snackPosition: SnackPosition.TOP,
      colorText: AppColor.whit,
    );
  }

  loginget(
    Function lldonefunc,
    Function llnotdonefunc,
  ) {
    if (lphonecont.text.isEmpty || lpasscont.text.isEmpty) {
      custsnak(AlertString.allfeildsmandotory);
      llnotdonefunc();
    } else if (lpasscont.text.length < 8) {
      custsnak(AlertString.pass8long);
      llnotdonefunc();
    } else {
      FirebaseConfi.loginfire(
        lphonecont.text,
        lpasscont.text,
        (
          String frmphon,
          String frmpass,
          String frmcomp,
          bool frmleader,
          String frmname,
        ) async {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString(FireString.compfire, frmcomp);
          await prefs.setString(FireString.phonefire, frmphon);
          await prefs.setString(FireString.passfire, frmpass);
          lldonefunc(
            frmleader,
            frmcomp,
            frmphon,
            frmname,
          );
        },
        (String error) {
          custsnak(error);
          llnotdonefunc();
        },
      );
    }
  }

  checkphoneget(
    String cpphone,
    Function nulfoundfunc,
    Function notnulfoundfunc,
  ) {
    FirebaseConfi.checkphonefire(
      cpphone,
      () {
        nulfoundfunc();
      },
      () {
        notnulfoundfunc();
      },
    );
  }

  registerget(
    String rrphone,
    Function rrdonefunc,
    Function rrnotdonefunc,
  ) {
    if (rpasscont.text.isEmpty ||
        rconfpasscont.text.isEmpty ||
        rnamecont.text.isEmpty ||
        rcompanycont.text.isEmpty) {
      custsnak(AlertString.allfeildsmandotory);
      rrnotdonefunc();
    } else if (rpasscont.text.length < 8) {
      custsnak(AlertString.pass8long);
      rrnotdonefunc();
    } else if (rpasscont.text != rconfpasscont.text) {
      custsnak(AlertString.samepasshovi);
      rrnotdonefunc();
    } else {
      FirebaseConfi.registerfire(
        rcompanycont.text,
        rnamecont.text,
        rrphone,
        rpasscont.text,
        () {
          rrdonefunc();
        },
        (String error) {
          custsnak(error);
          rrnotdonefunc();
        },
      );
    }
  }

  autologinget(
    Function logifunc,
    Function nologifunc,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String sphone =
        prefs.getString(FireString.phonefire) ?? AppString.nst;
    final String spass = prefs.getString(FireString.passfire) ?? AppString.nst;
    final String scomp = prefs.getString(FireString.compfire) ?? AppString.nst;
    debugPrint(sphone);
    debugPrint(spass);
    debugPrint(scomp);
    if (sphone == AppString.nst ||
        spass == AppString.nst ||
        scomp == AppString.nst) {
      nologifunc();
    } else {
      FirebaseConfi.loginfire(
        sphone,
        spass,
        (
          String frmphon,
          String frmpass,
          String frmcomp,
          bool frmleader,
          String frmname,
        ) {
          logifunc(frmleader, frmcomp, frmphon, frmname);
        },
        (String error) {
          nologifunc();
        },
      );
    }
  }

  RxString verificidrx = AppString.nst.obs;

  sendotpget(
    String ssphone,
  ) {
    FirebaseConfi.sendotpfun(
      ssphone,
      (String iiid) {
        verificidrx.value = iiid;
      },
      (String error) {
        custsnak(error);
      },
    );
  }

  confirmotpget(
    String smsotps,
    Function domnen,
    Function notdones,
  ) {
    FirebaseConfi.veriotpfunc(
      verificidrx.value,
      smsotps,
      () {
        domnen();
      },
      (String error) {
        notdones();
        custsnak(error);
      },
    );
  }

  forgotpassget(
    String ppphone,
    Function donnn,
    Function notedonn,
  ) {
    if (fpasscont.text.isEmpty || fpassconfcont.text.isEmpty) {
      custsnak(AlertString.allfeildsmandotory);
      notedonn();
    } else if (fpasscont.text.length < 8) {
      custsnak(AlertString.pass8long);
      notedonn();
    } else if (fpasscont.text != fpassconfcont.text) {
      custsnak(AlertString.samepasshovi);
      notedonn();
    } else {
      FirebaseConfi.forgotpassfire(
        ppphone,
        fpasscont.text,
        () {
          donnn();
        },
      );
    }
  }
}
