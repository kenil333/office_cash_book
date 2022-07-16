import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:printing/printing.dart';

import '../../../domain/all.dart';

class PdfGeneratorScreen extends StatefulWidget {
  const PdfGeneratorScreen({Key? key}) : super(key: key);

  @override
  State<PdfGeneratorScreen> createState() => _PdfGeneratorScreenState();
}

class _PdfGeneratorScreenState extends State<PdfGeneratorScreen> {
  final GlobalGet _cont = Get.find();
  final _loading = BoolStream();
  final _start = DateTimeStream();
  final _end = DateTimeStream();

  @override
  void dispose() {
    _loading.dispose();
    _start.dispose();
    _end.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return StreamBuilder<DateTime?>(
      stream: _start.stream,
      initialData: null,
      builder: (context, startsnap) => StreamBuilder<DateTime?>(
        stream: _end.stream,
        initialData: null,
        builder: (context, endsnap) => Column(
          children: [
            const SizedBox(height: 30),
            Text(
              AppString.pdfdow,
              style: TextStyle(
                fontSize: size.width * 0.06,
                color: AppColor.txtcol,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Datechoose(
              size: size,
              title: "Starting Date",
              date: startsnap.data,
              datefunc: () async {
                _start.sink.add(await CustMeth().pickthedate(context));
              },
            ),
            Datechoose(
              size: size,
              title: "Ending Date",
              date: endsnap.data,
              datefunc: () async {
                _end.sink.add(await CustMeth().pickthedate(context));
              },
            ),
            const SizedBox(height: 60),
            StreamBuilder<bool>(
              stream: _loading.stream,
              initialData: false,
              builder: (context, snapshot) {
                if (snapshot.data!) {
                  return const Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(color: AppColor.prim),
                  );
                } else {
                  return Custbutton(
                    title: AppString.download,
                    size: size,
                    custbutfunc: () async {
                      _loading.sink.add(true);
                      if (startsnap.data == null || endsnap.data == null) {
                        final List<Statment> st = _cont.allfiltlist();
                        if (st.isEmpty) {
                          _cont.custsnakg(AlertString.noentryfound);
                          _loading.sink.add(false);
                        } else {
                          final pddf = await PDFcreate.generatepdf(
                            size.width,
                            st,
                            _cont.compayrx.value,
                            st[st.length - 1].lastamount.toStringAsFixed(2),
                          );
                          _loading.sink.add(false);
                          await Printing.layoutPdf(
                            onLayout: (format) async => pddf.save(),
                          );
                        }
                      } else if (startsnap.data!.isAfter(endsnap.data!)) {
                        _cont.custsnakg(AlertString.validmanner);
                        _loading.sink.add(false);
                      } else {
                        final List<Statment> stat =
                            _cont.filterlist(startsnap.data!, endsnap.data!);
                        if (stat.isEmpty) {
                          _cont.custsnakg(AlertString.noentryfound);
                          _loading.sink.add(false);
                        } else {
                          final pddf = await PDFcreate.generatepdf(
                            size.width,
                            stat,
                            _cont.compayrx.value,
                            stat[stat.length - 1].lastamount.toStringAsFixed(2),
                          );
                          _loading.sink.add(false);
                          await Printing.layoutPdf(
                            onLayout: (format) async => pddf.save(),
                          );
                        }
                      }
                    },
                  );
                }
              },
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
