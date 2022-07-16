import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../domain/all.dart';

class Addmember extends StatefulWidget {
  const Addmember({Key? key}) : super(key: key);

  @override
  State<Addmember> createState() => _AddmemberState();
}

class _AddmemberState extends State<Addmember> {
  final _loading = BoolStream();
  final GlobalGet _cont = Get.find();

  @override
  void dispose() {
    _loading.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.screenback,
      appBar: AppBar(
        title: const Text(AppString.addmember),
        backgroundColor: AppColor.prim,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 18),
            TextfeildIcon(
              controller: _cont.amphoncont,
              size: size,
              title: AppString.phonenumber,
              icon: Icons.phone,
            ),
            TextfeildIcon(
              controller: _cont.amnamecont,
              size: size,
              title: AppString.name,
              icon: Icons.person,
            ),
            TextfeildIcon(
              controller: _cont.ampasscont,
              size: size,
              title: AppString.password,
              icon: Icons.lock_outline,
            ),
            TextfeildIcon(
              controller: _cont.amconfpasscont,
              size: size,
              title: AppString.confpassword,
              icon: Icons.lock_outline,
            ),
            const SizedBox(height: 50),
            StreamBuilder<bool>(
              initialData: false,
              stream: _loading.stream,
              builder: (context, snapshot) {
                if (snapshot.data!) {
                  return const Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(color: AppColor.prim),
                  );
                } else {
                  return Custbutton(
                    title: AppString.addstring,
                    size: size,
                    custbutfunc: () {
                      _loading.sink.add(true);
                      _cont.addmemget(
                        () {
                          _loading.sink.add(false);
                          Navigator.of(context).pop();
                        },
                        () {
                          _loading.sink.add(false);
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
