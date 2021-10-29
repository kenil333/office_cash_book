import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:printing/printing.dart';

import './../../../controller/common/all.dart';

class PdfGeneratorScreen extends StatefulWidget {
  const PdfGeneratorScreen({Key? key}) : super(key: key);

  @override
  State<PdfGeneratorScreen> createState() => _PdfGeneratorScreenState();
}

class _PdfGeneratorScreenState extends State<PdfGeneratorScreen> {
  final _bloc = LoadingBloc();
  final _cont = Get.put(GlobalGet());
  DateTime? _start;
  DateTime? _end;

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        const SizedBox(height: 30),
        Text(
          pdfdow,
          style: TextStyle(
            fontSize: size.width * 0.06,
            color: txtcol,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        Datechoose(
          size: size,
          title: "Starting Date",
          date: _start,
          datefunc: () async {
            _start = await CustMeth().pickthedate(context);
            setState(() {});
          },
        ),
        Datechoose(
          size: size,
          title: "Ending Date",
          date: _end,
          datefunc: () async {
            _end = await CustMeth().pickthedate(context);
            setState(() {});
          },
        ),
        const SizedBox(height: 60),
        StreamBuilder<bool>(
          stream: _bloc.loadingstrim,
          initialData: false,
          builder: (context, snapshot) {
            if (snapshot.data!) {
              return const Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator(color: prim),
              );
            } else {
              return Custbutton(
                title: download,
                size: size,
                custbutfunc: () async {
                  _bloc.loadingsink.add(true);
                  if (_start == null || _end == null) {
                    final List<Statment> _st = _cont.allfiltlist();
                    if (_st.isEmpty) {
                      _cont.custsnakg(noentryfound);
                      _bloc.loadingsink.add(false);
                    } else {
                      final pddf = await PDFcreate.generatepdf(
                        size.width,
                        _st,
                        _cont.compayrx.value,
                        _st[_st.length - 1].lastamount.toStringAsFixed(2),
                      );
                      _bloc.loadingsink.add(false);
                      await Printing.layoutPdf(
                        onLayout: (format) async => pddf.save(),
                      );
                    }
                  } else if (_start!.isAfter(_end!)) {
                    _cont.custsnakg(validmanner);
                    _bloc.loadingsink.add(false);
                  } else {
                    final List<Statment> _stat =
                        _cont.filterlist(_start!, _end!);
                    if (_stat.isEmpty) {
                      _cont.custsnakg(noentryfound);
                      _bloc.loadingsink.add(false);
                    } else {
                      final pddf = await PDFcreate.generatepdf(
                        size.width,
                        _stat,
                        _cont.compayrx.value,
                        _stat[_stat.length - 1].lastamount.toStringAsFixed(2),
                      );
                      _bloc.loadingsink.add(false);
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
    );
  }
}
