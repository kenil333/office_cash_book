import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './../../controller/common/all.dart';

class CredentialGet extends GetxController {
  TextEditingController lphonecont = TextEditingController();
  TextEditingController lpasscont = TextEditingController();
  TextEditingController rpasscont = TextEditingController();
  TextEditingController rconfpasscont = TextEditingController();
  TextEditingController rnamecont = TextEditingController();
  TextEditingController rcompanycont = TextEditingController();
  TextEditingController fpasscont = TextEditingController();
  TextEditingController fpassconfcont = TextEditingController();

  custsnak(String error) {
    Get.snackbar(
      "Alert !",
      error,
      backgroundColor: butred,
      borderRadius: 10,
      snackPosition: SnackPosition.TOP,
      colorText: whit,
    );
  }

  loginget(
    Function lldonefunc,
    Function llnotdonefunc,
  ) {
    if (lphonecont.text.isEmpty || lpasscont.text.isEmpty) {
      custsnak(allfeildsmandotory);
      llnotdonefunc();
    } else if (lpasscont.text.length < 8) {
      custsnak(pass8long);
      llnotdonefunc();
    } else {
      FirebaseConfi().loginfire(
        lphonecont.text,
        lpasscont.text,
        (
          String frmphon,
          String frmpass,
          String frmcomp,
          bool frmleader,
          String frmname,
        ) async {
          final SharedPreferences _prefs =
              await SharedPreferences.getInstance();
          await _prefs.setString(compfire, frmcomp);
          await _prefs.setString(phonefire, frmphon);
          await _prefs.setString(passfire, frmpass);
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
    FirebaseConfi().checkphonefire(
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
      custsnak(allfeildsmandotory);
      rrnotdonefunc();
    } else if (rpasscont.text.length < 8) {
      custsnak(pass8long);
      rrnotdonefunc();
    } else if (rpasscont.text != rconfpasscont.text) {
      custsnak(samepasshovi);
      rrnotdonefunc();
    } else {
      FirebaseConfi().registerfire(
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
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    final String _sphone = _prefs.getString(phonefire) ?? nst;
    final String _spass = _prefs.getString(passfire) ?? nst;
    final String _scomp = _prefs.getString(compfire) ?? nst;
    debugPrint(_sphone);
    debugPrint(_spass);
    debugPrint(_scomp);
    if (_sphone == nst || _spass == nst || _scomp == nst) {
      nologifunc();
    } else {
      FirebaseConfi().loginfire(
        _sphone,
        _spass,
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

  RxString verificidrx = nst.obs;

  sendotpget(
    String ssphone,
  ) {
    FirebaseConfi().sendotpfun(
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
    FirebaseConfi().veriotpfunc(
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
      custsnak(allfeildsmandotory);
      notedonn();
    } else if (fpasscont.text.length < 8) {
      custsnak(pass8long);
      notedonn();
    } else if (fpasscont.text != fpassconfcont.text) {
      custsnak(samepasshovi);
      notedonn();
    } else {
      FirebaseConfi().forgotpassfire(
        ppphone,
        fpasscont.text,
        () {
          donnn();
        },
      );
    }
  }
}
