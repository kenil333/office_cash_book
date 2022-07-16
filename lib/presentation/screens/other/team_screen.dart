import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../domain/all.dart';

class TeamScreen extends StatelessWidget {
  final String comp;
  final bool lead;
  final String phonefrm;
  const TeamScreen({
    Key? key,
    required this.comp,
    required this.lead,
    required this.phonefrm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final Stream<DatabaseEvent> usersapi = FirebaseDatabase.instance
        .ref(FireString.userfire)
        .orderByChild(FireString.compfire)
        .equalTo(comp)
        .onValue;
    return Scaffold(
      backgroundColor: AppColor.screenback,
      appBar: AppBar(
        title: const Text(AppString.team),
        backgroundColor: AppColor.prim,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const Addmember(),
                ),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: StreamBuilder<DatabaseEvent>(
        stream: usersapi,
        builder: (BuildContext context, AsyncSnapshot<DatabaseEvent> snap) {
          List<Usersm> userlist = [];
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: AppColor.prim),
            );
          } else if (snap.data != null &&
              snap.hasData &&
              snap.data!.snapshot.value != null) {
            Map data = snap.data!.snapshot.value as Map;
            data.forEach((key, value) {
              if (key != phonefrm) {
                userlist.add(
                  Usersm(
                    phone: key,
                    name: value[FireString.namefire],
                  ),
                );
              }
            });
            if (userlist.isEmpty) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.07,
                  ),
                  child: Image.asset(
                    "assets/images/dnf.png",
                    fit: BoxFit.contain,
                  ),
                ),
              );
            } else {
              return ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 15),
                itemCount: userlist.length,
                itemBuilder: (context, i) => PersonWid(
                  size: size,
                  name: userlist[i].name,
                  number: userlist[i].phone,
                  persofunc: () {
                    CustMeth().shodi(
                      context,
                      size,
                      () {
                        if (lead) {
                          FirebaseConfi.delmemfire(
                            userlist[i].phone,
                            () {
                              Navigator.of(context).pop();
                            },
                          );
                        }
                      },
                    );
                  },
                ),
              );
            }
          } else {
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.07,
                ),
                child: Image.asset(
                  "assets/images/dnf.png",
                  fit: BoxFit.contain,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
