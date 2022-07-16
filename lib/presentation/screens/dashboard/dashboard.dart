import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:get/get.dart';

import '../../../domain/all.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final GlobalGet globalcontroller = Get.find();
    final Stream<DatabaseEvent> closingamountapi = FirebaseDatabase.instance
        .ref(FireString.compfire)
        .child(globalcontroller.compayrx.value)
        .child(FireString.countclosefire)
        .child(FireString.closingamountfire)
        .onValue;
    final Stream<DatabaseEvent> statmentapi = FirebaseDatabase.instance
        .ref(FireString.compfire)
        .child(globalcontroller.compayrx.value)
        .child(FireString.statementfire)
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
                    color: AppColor.prim,
                    alignment: Alignment.topCenter,
                    child: Text(
                      globalcontroller.compayrx.value,
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
                    decoration: ConstDecoration.containerdeco,
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Balance :',
                              style: TextStyle(
                                fontSize: size.width * 0.05,
                                color: AppColor.butred,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: ClosingAmountWid(
                              size: size,
                              api: closingamountapi,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              StreamBuilder<DatabaseEvent>(
                stream: statmentapi,
                builder:
                    (BuildContext context, AsyncSnapshot<DatabaseEvent> snap) {
                  List<Statment> statmentlist = [];
                  if (snap.connectionState == ConnectionState.waiting) {
                    return Container(
                      width: double.infinity,
                      height: size.height * 0.5,
                      alignment: Alignment.center,
                      child:
                          const CircularProgressIndicator(color: AppColor.prim),
                    );
                  } else if (snap.data != null &&
                      snap.hasData &&
                      snap.data!.snapshot.value != null) {
                    Map data = snap.data!.snapshot.value as Map;
                    data.forEach(
                      (key, value) {
                        statmentlist.add(
                          Statment(
                            id: key,
                            count: value[FireString.contifire],
                            name: value[FireString.namefire],
                            remark: value[FireString.remarkfire],
                            debit: value[FireString.debitfire],
                            date: DateTime.parse(value[FireString.datefire]),
                            amount: double.parse(value[FireString.amountfire]),
                            lastamount:
                                double.parse(value[FireString.lastamountfire]),
                          ),
                        );
                      },
                    );
                    if (statmentlist.length > 1) {
                      statmentlist.sort(
                        (a, b) {
                          return b.count.compareTo(a.count);
                        },
                      );
                    }
                    globalcontroller.changestatlist(statmentlist);
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: statmentlist.length,
                      itemBuilder: (context, i) => Statmentstemp(
                        length: statmentlist.length,
                        i: i,
                        size: size,
                        st: statmentlist[i],
                        longp: () {
                          if (i == 0) {
                            CustMeth().shodi(
                              context,
                              size,
                              () {
                                globalcontroller.deleteentryget(
                                  statmentlist[i].id,
                                  statmentlist[i].debit,
                                  statmentlist[i].amount,
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
          bottom: size.height * 0.012,
          right: size.width * 0.025,
          child: SizedBox(
            width: size.width * 0.5,
            child: Custbutton(
              title: AppString.statement,
              size: size,
              custbutfunc: () {
                pushNewScreen(
                  context,
                  screen: AddStatmentScreen(
                      compname: globalcontroller.compayrx.value),
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
