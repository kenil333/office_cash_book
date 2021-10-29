import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import './../common/all.dart';

class FirebaseConfi {
  final DatabaseReference fref = FirebaseDatabase.instance.reference();
  final FirebaseAuth fauth = FirebaseAuth.instance;

  sendotpfun(
    String ssphone,
    Function veriid,
    Function notdoneauth,
  ) async {
    await fauth.verifyPhoneNumber(
      phoneNumber: "+91$ssphone",
      //timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException fireexception) {
        notdoneauth(fireexception.message.toString());
      },
      codeSent: (String codestring, int? codeint) {
        veriid(codestring);
      },
      codeAutoRetrievalTimeout: (String codestring) {
        veriid(codestring);
      },
    );
  }

  veriotpfunc(
    String verificid,
    String smsotp,
    Function doneauth,
    Function notdoneauth,
  ) async {
    AuthCredential _authcredential = PhoneAuthProvider.credential(
      verificationId: verificid,
      smsCode: smsotp,
    );
    await fauth.signInWithCredential(_authcredential).then(
      (UserCredential uscred) {
        if (uscred.user != null) {
          doneauth();
        } else {
          notdoneauth(entervalidotp);
        }
      },
    ).catchError((error) {
      notdoneauth(error.toString());
    });
  }

  loginfire(
    String lphone,
    String lpassword,
    Function loginfunc,
    Function nologinfunc,
  ) async {
    await fref.child(userfire).child(lphone).once().then(
      (DataSnapshot usnap) async {
        if (usnap.value == null) {
          nologinfunc(phonenotinused);
        } else if (usnap.value[passfire] != lpassword) {
          nologinfunc(passiswrong);
        } else {
          loginfunc(
            lphone,
            lpassword,
            usnap.value[compfire],
            usnap.value[leaderfire],
            usnap.value[namefire],
          );
        }
      },
    );
  }

  checkphonefire(
    String cphone,
    Function nulfunc,
    Function nonnulfunc,
  ) async {
    await fref.child(userfire).child(cphone).once().then(
      (DataSnapshot cpsnap) {
        if (cpsnap.value == null) {
          nulfunc();
        } else {
          nonnulfunc();
        }
      },
    );
  }

  registerfire(
    String rcompany,
    String rname,
    String rphone,
    String rpassword,
    Function done,
    Function notdone,
  ) async {
    await fref.child(compfire).child(rcompany).once().then(
      (DataSnapshot csnap) async {
        if (csnap.value != null) {
          notdone(cmpanyalreadyinuse);
        } else {
          await fref
              .child(compfire)
              .child(rcompany)
              .child(closingamountfire)
              .set("00.00")
              .then(
            (_) async {
              await fref.child(userfire).child(rphone).set({
                compfire: rcompany,
                leaderfire: true,
                namefire: rname,
                passfire: rpassword,
              });
              done();
            },
          );
        }
      },
    );
  }

  forgotpassfire(String ffphone, String newpass, Function donen) async {
    await fref
        .child(userfire)
        .child(ffphone)
        .child(passfire)
        .set(newpass)
        .then((_) {
      donen();
    });
  }

  addstatmentfire(
    String acompany,
    String auname,
    double aamount,
    String areamrk,
    String adate,
    bool adebit,
    Function done,
  ) async {
    double _closeamount = 0.0;
    await fref
        .child(compfire)
        .child(acompany)
        .child(closingamountfire)
        .once()
        .then(
      (DataSnapshot csnap) async {
        if (adebit) {
          _closeamount = double.parse(csnap.value) - aamount;
        } else {
          _closeamount = double.parse(csnap.value) + aamount;
        }
        await fref
            .child(compfire)
            .child(acompany)
            .child(statementfire)
            .push()
            .set({
          namefire: auname,
          amountfire: aamount.toStringAsFixed(2),
          lastamountfire: _closeamount.toStringAsFixed(2),
          remarkfire: areamrk,
          datefire: adate,
          debitfire: adebit,
        }).then((_) async {
          await fref
              .child(compfire)
              .child(acompany)
              .child(closingamountfire)
              .set(
                _closeamount.toStringAsFixed(2),
              )
              .then((_) {
            done();
          });
        });
      },
    );
  }

  deletelastentry(
    String dltcomp,
    String dltid,
    bool dltdebit,
    double dltamount,
  ) async {
    double _finalamount = 0.0;
    await fref
        .child(compfire)
        .child(dltcomp)
        .child(closingamountfire)
        .once()
        .then(
      (DataSnapshot cdlsnap) async {
        if (dltdebit) {
          _finalamount = double.parse(cdlsnap.value) + dltamount;
        } else {
          _finalamount = double.parse(cdlsnap.value) - dltamount;
        }
        await fref
            .child(compfire)
            .child(dltcomp)
            .child(statementfire)
            .child(dltid)
            .remove()
            .then(
          (_) async {
            await fref
                .child(compfire)
                .child(dltcomp)
                .child(closingamountfire)
                .set(
                  _finalamount.toStringAsFixed(2),
                );
          },
        );
      },
    );
  }

  addmemberfireconfi(
    String addphone,
    String addname,
    String addpass,
    String addcomp,
    Function yesfunc,
    Function nofunc,
  ) async {
    await fref.child(userfire).child(addphone).once().then(
      (DataSnapshot apsnap) async {
        if (apsnap.value != null) {
          nofunc();
        } else {
          await fref.child(userfire).child(addphone).set({
            namefire: addname,
            passfire: addpass,
            compfire: addcomp,
            leaderfire: false,
          }).then((_) {
            yesfunc();
          });
        }
      },
    );
  }

  delmemfire(String pphone, Function donn) async {
    await fref.child(userfire).child(pphone).remove().then((_) {
      donn();
    });
  }
}
