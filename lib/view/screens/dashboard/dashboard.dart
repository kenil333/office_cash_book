import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:get/get.dart';

import './../../../controller/common/all.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final _cont = Get.put(GlobalGet());
    final Stream _closingamountapi = FirebaseDatabase.instance
        .reference()
        .child(compfire)
        .child(_cont.compayrx.value)
        .child(countclosefire)
        .child(closingamountfire)
        .onValue;
    final Stream _statmentapi = FirebaseDatabase.instance
        .reference()
        .child(compfire)
        .child(_cont.compayrx.value)
        .child(statementfire)
        .onValue;

    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      top: size.height * 0.008,
                    ),
                    height: size.height * 0.13,
                    width: double.infinity,
                    color: prim,
                    alignment: Alignment.topCenter,
                    child: Text(
                      _cont.compayrx.value,
                      style: TextStyle(
                        fontSize: size.width * 0.05,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: size.width * 0.08,
                      vertical: size.height * 0.05,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.06,
                      vertical: 10,
                    ),
                    height: size.height * 0.15,
                    width: double.infinity,
                    decoration: containerdeco,
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Balance :',
                              style: TextStyle(
                                fontSize: size.width * 0.05,
                                color: butred,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: ClosingAmountWid(
                              size: size,
                              api: _closingamountapi,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              StreamBuilder(
                stream: _statmentapi,
                builder: (BuildContext context, AsyncSnapshot<dynamic> snap) {
                  List<Statment> _statmentlist = [];
                  if (snap.connectionState == ConnectionState.waiting) {
                    return Container(
                      width: double.infinity,
                      height: size.height * 0.5,
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(color: prim),
                    );
                  } else if (snap.hasData && snap.data.snapshot.value != null) {
                    Map data = snap.data.snapshot.value;
                    data.forEach(
                      (key, value) {
                        _statmentlist.add(
                          Statment(
                            id: key,
                            count: value[contifire],
                            name: value[namefire],
                            remark: value[remarkfire],
                            debit: value[debitfire],
                            date: DateTime.parse(value[datefire]),
                            amount: double.parse(value[amountfire]),
                            lastamount: double.parse(value[lastamountfire]),
                          ),
                        );
                      },
                    );
                    if (_statmentlist.length > 1) {
                      _statmentlist.sort(
                        (a, b) {
                          return b.count.compareTo(a.count);
                        },
                      );
                    }
                    _cont.changestatlist(_statmentlist);
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _statmentlist.length,
                      itemBuilder: (context, i) => Statmentstemp(
                        length: _statmentlist.length,
                        i: i,
                        size: size,
                        st: _statmentlist[i],
                        longp: () {
                          if (i == 0) {
                            CustMeth().shodi(
                              context,
                              size,
                              () {
                                _cont.deleteentryget(
                                  _statmentlist[i].id,
                                  _statmentlist[i].debit,
                                  _statmentlist[i].amount,
                                );
                              },
                            );
                          }
                        },
                      ),
                    );
                  } else {
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.1,
                        vertical: size.height * 0.1,
                      ),
                      child: Image.asset(
                        "assets/images/dnf.png",
                        fit: BoxFit.contain,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: SizedBox(
            width: size.width * 0.5,
            child: Custbutton(
              title: statement,
              size: size,
              custbutfunc: () {
                pushNewScreen(
                  context,
                  screen: AddStatmentScreen(compname: _cont.compayrx.value),
                  withNavBar: false,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
