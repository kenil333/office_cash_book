import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import './../../../controller/common/all.dart';

class Addmember extends StatefulWidget {
  const Addmember({Key? key}) : super(key: key);

  @override
  State<Addmember> createState() => _AddmemberState();
}

class _AddmemberState extends State<Addmember> {
  final _bloc = LoadingBloc();
  final _cont = Get.put(GlobalGet());

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: screenback,
      appBar: AppBar(
        title: const Text(addmember),
        backgroundColor: prim,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 18),
            TextfeildIcon(
              controller: _cont.amphoncont,
              size: size,
              title: phonenumber,
              icon: Icons.phone,
            ),
            TextfeildIcon(
              controller: _cont.amnamecont,
              size: size,
              title: name,
              icon: Icons.person,
            ),
            TextfeildIcon(
              controller: _cont.ampasscont,
              size: size,
              title: password,
              icon: Icons.lock_outline,
            ),
            TextfeildIcon(
              controller: _cont.amconfpasscont,
              size: size,
              title: confpassword,
              icon: Icons.lock_outline,
            ),
            const SizedBox(height: 50),
            StreamBuilder<bool>(
              initialData: false,
              stream: _bloc.loadingstrim,
              builder: (context, snapshot) {
                if (snapshot.data!) {
                  return const Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(color: prim),
                  );
                } else {
                  return Custbutton(
                    title: addstring,
                    size: size,
                    custbutfunc: () {
                      _bloc.loadingsink.add(true);
                      _cont.addmemget(
                        () {
                          _bloc.loadingsink.add(false);
                          Navigator.of(context).pop();
                        },
                        () {
                          _bloc.loadingsink.add(false);
                        },
                      );
                    },
                  );
                }
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
