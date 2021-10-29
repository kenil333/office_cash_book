import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './../../../controller/common/all.dart';

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
    final Stream _usersapi = FirebaseDatabase.instance
        .reference()
        .child(userfire)
        .orderByChild(compfire)
        .equalTo(comp)
        .onValue;
    return Scaffold(
      backgroundColor: screenback,
      appBar: AppBar(
        title: const Text(team),
        backgroundColor: prim,
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
      body: StreamBuilder(
        stream: _usersapi,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snap) {
          List<Usersm> _userlist = [];
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: prim),
            );
          } else if (snap.hasData && snap.data.snapshot.value != null) {
            Map data = snap.data.snapshot.value;
            data.forEach((key, value) {
              if (key != phonefrm) {
                _userlist.add(
                  Usersm(
                    phone: key,
                    name: value[namefire],
                  ),
                );
              }
            });
            if (_userlist.isEmpty) {
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
                itemCount: _userlist.length,
                itemBuilder: (context, i) => PersonWid(
                  size: size,
                  name: _userlist[i].name,
                  number: _userlist[i].phone,
                  persofunc: () {
                    CustMeth().shodi(
                      context,
                      size,
                      () {
                        if (lead) {
                          FirebaseConfi().delmemfire(
                            _userlist[i].phone,
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
