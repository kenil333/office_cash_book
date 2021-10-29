import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import './../../controller/common/all.dart';

class PDFcreate {
  static Future<Document> generatepdf(
    double width,
    List<Statment> list,
    String companyname,
    String closamount,
  ) async {
    final _pdf = Document();
    _pdf.addPage(
      MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const EdgeInsets.only(top: 0, bottom: 10, left: 0, right: 0),
        header: (context) => Column(
          children: [
            Container(
              color: PdfColor.fromHex('#0752AD'),
              padding: const EdgeInsets.only(top: 30, bottom: 30),
              width: double.infinity,
              alignment: Alignment.center,
              child: Text(
                companyname,
                style: TextStyle(
                  color: PdfColor.fromHex('#FFFFFF'),
                  fontSize: 30,
                ),
                maxLines: 1,
                textAlign: TextAlign.center,
                overflow: TextOverflow.clip,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 0, bottom: 5),
              decoration: const BoxDecoration(
                color: PdfColors.green100,
                border: Border(
                  bottom: BorderSide(
                    width: 1,
                    color: PdfColors.grey,
                  ),
                ),
              ),
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: width * 0.18,
                    alignment: Alignment.center,
                    child: Text(
                      'Date',
                      style: TextStyle(
                        fontSize: 15,
                        color: PdfColor.fromHex('#0752AD'),
                      ),
                    ),
                  ),
                  Container(
                    width: width * 0.23,
                    alignment: Alignment.center,
                    child: Text(
                      'Member',
                      style: TextStyle(
                        fontSize: 15,
                        color: PdfColor.fromHex('#0752AD'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Narration',
                        style: TextStyle(
                          fontSize: 15,
                          color: PdfColor.fromHex('#0752AD'),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: width * 0.18,
                    alignment: Alignment.center,
                    child: Text(
                      'Debit',
                      style: TextStyle(
                        fontSize: 15,
                        color: PdfColor.fromHex('#0752AD'),
                      ),
                    ),
                  ),
                  Container(
                    width: width * 0.18,
                    alignment: Alignment.center,
                    child: Text(
                      'Credit',
                      style: TextStyle(
                        fontSize: 15,
                        color: PdfColor.fromHex('#0752AD'),
                      ),
                    ),
                  ),
                  Container(
                    width: width * 0.18,
                    alignment: Alignment.center,
                    child: Text(
                      'Balance',
                      style: TextStyle(
                        fontSize: 15,
                        color: PdfColor.fromHex('#0752AD'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        build: (context) => [
          Container(
            color: PdfColor.fromHex("#FFFFFF"),
            child: Column(
              children: [
                for (int i = 0; i < list.length; i++)
                  Container(
                    decoration: const BoxDecoration(
                      color: PdfColors.white,
                      border: Border(
                        bottom: BorderSide(
                          width: 1,
                          color: PdfColors.grey,
                        ),
                      ),
                    ),
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: width * 0.18,
                          alignment: Alignment.center,
                          child: Text(
                            DateFormat("dd/MM/yyyy").format(list[i].date),
                            style: const TextStyle(
                              fontSize: 13,
                            ),
                          ),
                        ),
                        Container(
                          width: width * 0.23,
                          alignment: Alignment.center,
                          child: Text(
                            list[i].name,
                            style: const TextStyle(
                              fontSize: 13,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              list[i].remark,
                              style: const TextStyle(
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                        list[i].debit
                            ? Container(
                                width: width * 0.18,
                                alignment: Alignment.center,
                                child: Text(
                                  '- ${list[i].amount.toStringAsFixed(1)}',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: PdfColors.red,
                                  ),
                                ),
                              )
                            : Container(
                                width: width * 0.16,
                              ),
                        list[i].debit == false
                            ? Container(
                                width: width * 0.18,
                                alignment: Alignment.center,
                                child: Text(
                                  '+ ${list[i].amount.toStringAsFixed(1)}',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: PdfColors.green,
                                  ),
                                ),
                              )
                            : Container(
                                width: width * 0.16,
                              ),
                        Container(
                          width: width * 0.18,
                          alignment: Alignment.center,
                          child: Text(
                            list[i].lastamount.toStringAsFixed(1),
                            style: const TextStyle(
                              fontSize: 13,
                              color: PdfColors.orange,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 20, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Cloasing Amount : ",
                        style: const TextStyle(
                          fontSize: 20,
                          color: PdfColors.green,
                        ),
                      ),
                      Text(
                        closamount,
                        style: TextStyle(
                          fontSize: 20,
                          color: PdfColor.fromHex('#0752AD'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    return _pdf;
  }
}
