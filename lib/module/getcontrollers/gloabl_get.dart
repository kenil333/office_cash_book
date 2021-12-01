import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './../../controller/common/all.dart';

class GlobalGet extends GetxController {
  RxString compayrx = nst.obs;
  RxString phonerx = nst.obs;
  RxString namerx = nst.obs;
  RxBool leaderx = false.obs;

  RxList<Statment> statlistrx = <Statment>[].obs;

  changeuserdata(bool lead, String comp, String phone, String namei) {
    compayrx.value = comp;
    phonerx.value = phone;
    leaderx.value = lead;
    namerx.value = namei;
  }

  changestatlist(List<Statment> list) {
    statlistrx.value = list;
  }

  List<Statment> allfiltlist() {
    List<Statment> _dummy = statlistrx;
    _dummy.sort((a, b) {
      return a.count.compareTo(b.count);
    });
    return _dummy;
  }

  List<Statment> filterlist(DateTime st, DateTime ed) {
    List<Statment> _stat = [];
    for (int i = 0; i < statlistrx.length; i++) {
      if (statlistrx[i].date.isAfter(st.subtract(const Duration(days: 1))) &&
          statlistrx[i].date.isBefore(ed.add(const Duration(days: 1)))) {
        _stat.add(statlistrx[i]);
      }
    }
    _stat.sort((a, b) {
      return a.count.compareTo(b.count);
    });
    return _stat;
  }

  double gettotalcredit(DateTime? start, DateTime? end) {
    double _totalamount = 0;
    for (int i = 0; i < statlistrx.length; i++) {
      if (start != null && end != null) {
        if (start.isBefore(end)) {
          if (statlistrx[i].debit == false) {
            if (statlistrx[i]
                    .date
                    .isAfter(start.subtract(const Duration(days: 1))) &&
                statlistrx[i].date.isBefore(end.add(const Duration(days: 1)))) {
              _totalamount += statlistrx[i].amount;
            }
          }
        } else {
          if (statlistrx[i].debit == false) {
            _totalamount += statlistrx[i].amount;
          }
        }
      } else {
        if (statlistrx[i].debit == false) {
          _totalamount += statlistrx[i].amount;
        }
      }
    }
    return _totalamount;
  }

  double gettotaldebit(DateTime? start, DateTime? end) {
    double _totalamount = 0;
    for (int i = 0; i < statlistrx.length; i++) {
      if (start != null && end != null) {
        if (start.isBefore(end)) {
          if (statlistrx[i].debit) {
            if (statlistrx[i]
                    .date
                    .isAfter(start.subtract(const Duration(days: 1))) &&
                statlistrx[i].date.isBefore(end.add(const Duration(days: 1)))) {
              _totalamount += statlistrx[i].amount;
            }
          }
        } else {
          if (statlistrx[i].debit) {
            _totalamount += statlistrx[i].amount;
          }
        }
      } else {
        if (statlistrx[i].debit) {
          _totalamount += statlistrx[i].amount;
        }
      }
    }
    return _totalamount;
  }

  custsnakg(String error) {
    Get.snackbar(
      "Alert !",
      error,
      backgroundColor: butred,
      borderRadius: 10,
      snackPosition: SnackPosition.TOP,
      colorText: whit,
    );
  }

  TextEditingController aamountcont = TextEditingController();
  TextEditingController aremarkcont = TextEditingController();
  TextEditingController amphoncont = TextEditingController();
  TextEditingController amnamecont = TextEditingController();
  TextEditingController ampasscont = TextEditingController();
  TextEditingController amconfpasscont = TextEditingController();

  addstatmentget(
    DateTime? agdate,
    bool agdebit,
    Function done,
    Function notdone,
  ) {
    if (aamountcont.text.isEmpty || aremarkcont.text.isEmpty) {
      custsnakg(allfeildsmandotory);
      notdone();
    } else {
      FirebaseConfi().addstatmentfire(
        compayrx.value,
        namerx.value,
        double.parse(aamountcont.text),
        aremarkcont.text,
        DateFormat("yyyyMMdd").format(agdate!),
        agdebit,
        () {
          done();
          aamountcont.clear();
          aremarkcont.clear();
        },
      );
    }
  }

  deleteentryget(
    String dsid,
    bool dsdebit,
    double dsamount,
  ) {
    FirebaseConfi().deletelastentry(
      compayrx.value,
      dsid,
      dsdebit,
      dsamount,
    );
  }

  logoutget(Function loutfunc) async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString(compfire, nst);
    await _prefs.setString(phonefire, nst);
    await _prefs.setString(passfire, nst);
    loutfunc();
  }

  addmemget(
    Function donn,
    Function notdonn,
  ) {
    if (amphoncont.text.isEmpty ||
        amnamecont.text.isEmpty ||
        ampasscont.text.isEmpty ||
        amconfpasscont.text.isEmpty) {
      custsnakg(allfeildsmandotory);
      notdonn();
    } else if (ampasscont.text.length < 8) {
      custsnakg(pass8long);
      notdonn();
    } else if (ampasscont.text != amconfpasscont.text) {
      custsnakg(samepasshovi);
      notdonn();
    } else {
      FirebaseConfi().addmemberfireconfi(
        amphoncont.text,
        amnamecont.text,
        ampasscont.text,
        compayrx.value,
        () {
          donn();
          amphoncont.clear();
          amnamecont.clear();
          ampasscont.clear();
          amconfpasscont.clear();
        },
        () {
          custsnakg(phoneninused);
          notdonn();
        },
      );
    }
  }
}
