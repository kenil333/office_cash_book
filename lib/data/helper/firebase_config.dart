import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../domain/all.dart';

class FirebaseConfi {
  static FirebaseDatabase fref = FirebaseDatabase.instance;
  static FirebaseAuth fauth = FirebaseAuth.instance;

  static Future<void> sendotpfun(
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

  static Future<void> veriotpfunc(
    String verificid,
    String smsotp,
    Function doneauth,
    Function notdoneauth,
  ) async {
    AuthCredential authcredential = PhoneAuthProvider.credential(
      verificationId: verificid,
      smsCode: smsotp,
    );
    await fauth.signInWithCredential(authcredential).then(
      (UserCredential uscred) {
        if (uscred.user != null) {
          doneauth();
        } else {
          notdoneauth(AlertString.entervalidotp);
        }
      },
    ).catchError((error) {
      notdoneauth(error.toString());
    });
  }

  static Future<void> loginfire(
    String lphone,
    String lpassword,
    Function loginfunc,
    Function nologinfunc,
  ) async {
    await fref.ref(FireString.userfire).child(lphone).once().then(
      (DatabaseEvent usnap) async {
        if (usnap.snapshot.value == null) {
          nologinfunc(AlertString.phonenotinused);
        } else if ((usnap.snapshot.value as Map)[FireString.passfire] !=
            lpassword) {
          nologinfunc(AlertString.passiswrong);
        } else {
          loginfunc(
            lphone,
            lpassword,
            (usnap.snapshot.value as Map)[FireString.compfire],
            (usnap.snapshot.value as Map)[FireString.leaderfire],
            (usnap.snapshot.value as Map)[FireString.namefire],
          );
        }
      },
    );
  }

  static Future<void> checkphonefire(
    String cphone,
    Function nulfunc,
    Function nonnulfunc,
  ) async {
    await fref.ref(FireString.userfire).child(cphone).once().then(
      (DatabaseEvent cpsnap) {
        if (cpsnap.snapshot.value == null) {
          nulfunc();
        } else {
          nonnulfunc();
        }
      },
    );
  }

  static Future<void> registerfire(
    String rcompany,
    String rname,
    String rphone,
    String rpassword,
    Function done,
    Function notdone,
  ) async {
    await fref.ref(FireString.compfire).child(rcompany).once().then(
      (DatabaseEvent csnap) async {
        if (csnap.snapshot.value != null) {
          notdone(AlertString.cmpanyalreadyinuse);
        } else {
          await fref
              .ref(FireString.compfire)
              .child(rcompany)
              .child(FireString.countclosefire)
              .set({
            FireString.closingamountfire: "00.00",
            FireString.statementcountfire: 0,
          }).then(
            (_) async {
              await fref.ref(FireString.userfire).child(rphone).set({
                FireString.compfire: rcompany,
                FireString.leaderfire: true,
                FireString.namefire: rname,
                FireString.passfire: rpassword,
              });
              done();
            },
          );
        }
      },
    );
  }

  static Future<void> forgotpassfire(
      String ffphone, String newpass, Function donen) async {
    await fref
        .ref(FireString.userfire)
        .child(ffphone)
        .child(FireString.passfire)
        .set(newpass)
        .then((_) {
      donen();
    });
  }

  static Future<void> addstatmentfire(
    String acompany,
    String auname,
    double aamount,
    String areamrk,
    String adate,
    bool adebit,
    Function done,
  ) async {
    double closeamount = 0.0;
    int count = 0;
    await fref
        .ref(FireString.compfire)
        .child(acompany)
        .child(FireString.countclosefire)
        .once()
        .then(
      (DatabaseEvent csnap) async {
        if (adebit) {
          closeamount = double.parse(
                  (csnap.snapshot.value as Map)[FireString.closingamountfire]) -
              aamount;
        } else {
          closeamount = double.parse(
                  (csnap.snapshot.value as Map)[FireString.closingamountfire]) +
              aamount;
        }
        count =
            (csnap.snapshot.value as Map)[FireString.statementcountfire] + 1;
        await fref
            .ref(FireString.compfire)
            .child(acompany)
            .child(FireString.statementfire)
            .push()
            .set({
          FireString.namefire: auname,
          FireString.contifire: count,
          FireString.amountfire: aamount.toStringAsFixed(2),
          FireString.lastamountfire: closeamount.toStringAsFixed(2),
          FireString.remarkfire: areamrk,
          FireString.datefire: adate,
          FireString.debitfire: adebit,
        }).then((_) async {
          await fref
              .ref(FireString.compfire)
              .child(acompany)
              .child(FireString.countclosefire)
              .set({
            FireString.closingamountfire: closeamount.toStringAsFixed(2),
            FireString.statementcountfire: count,
          }).then((_) {
            done();
          });
        });
      },
    );
  }

  static Future<void> deletelastentry(
    String dltcomp,
    String dltid,
    bool dltdebit,
    double dltamount,
  ) async {
    double finalamount = 0.0;
    int count = 0;
    await fref
        .ref(FireString.compfire)
        .child(dltcomp)
        .child(FireString.countclosefire)
        .once()
        .then(
      (DatabaseEvent cdlsnap) async {
        if (dltdebit) {
          finalamount = double.parse((cdlsnap.snapshot.value
                  as Map)[FireString.closingamountfire]) +
              dltamount;
        } else {
          finalamount = double.parse((cdlsnap.snapshot.value
                  as Map)[FireString.closingamountfire]) -
              dltamount;
        }
        count =
            (cdlsnap.snapshot.value as Map)[FireString.statementcountfire] - 1;

        await fref
            .ref(FireString.compfire)
            .child(dltcomp)
            .child(FireString.statementfire)
            .child(dltid)
            .remove()
            .then(
          (_) async {
            await fref
                .ref(FireString.compfire)
                .child(dltcomp)
                .child(FireString.countclosefire)
                .set(
              {
                FireString.closingamountfire: finalamount.toStringAsFixed(2),
                FireString.statementcountfire: count,
              },
            );
          },
        );
      },
    );
  }

  static Future<void> addmemberfireconfi(
    String addphone,
    String addname,
    String addpass,
    String addcomp,
    Function yesfunc,
    Function nofunc,
  ) async {
    await fref.ref(FireString.userfire).child(addphone).once().then(
      (DatabaseEvent apsnap) async {
        if (apsnap.snapshot.value != null) {
          nofunc();
        } else {
          await fref.ref(FireString.userfire).child(addphone).set({
            FireString.namefire: addname,
            FireString.passfire: addpass,
            FireString.compfire: addcomp,
            FireString.leaderfire: false,
          }).then((_) {
            yesfunc();
          });
        }
      },
    );
  }

  static Future<void> delmemfire(String pphone, Function donn) async {
    await fref.ref(FireString.userfire).child(pphone).remove().then((_) {
      donn();
    });
  }
}
