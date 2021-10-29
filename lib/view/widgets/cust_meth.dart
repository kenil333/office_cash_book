import 'package:flutter/material.dart';

import './../../controller/common/all.dart';

class CustMeth {
  Future<DateTime?> pickthedate(BuildContext context) async {
    final DateTime? _date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.parse("20210101"),
      lastDate: DateTime.now(),
    );
    return _date;
  }

  replash(BuildContext context, Widget widget) {
    return Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
  }

  onlypu(BuildContext context, Widget widget) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
  }

  shodi(
    BuildContext context,
    Size size,
    Function delfunc,
  ) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Container(
          height: size.height * 0.2,
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.04,
            vertical: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Are You sure to Delete ?",
                style: TextStyle(
                  fontSize: size.width * 0.04,
                  color: txtcol,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: size.width * 0.2,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        width: double.infinity,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: butgreen,
                        ),
                        child: Text(
                          "No",
                          style: TextStyle(
                            fontSize: size.width * 0.05,
                            color: whit,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.2,
                    child: InkWell(
                      onTap: () {
                        delfunc();
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        width: double.infinity,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: butred,
                        ),
                        child: Text(
                          "Yes",
                          style: TextStyle(
                            fontSize: size.width * 0.05,
                            color: whit,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
