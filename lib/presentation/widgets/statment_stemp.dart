import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/all.dart';

class Statmentstemp extends StatefulWidget {
  final Size size;
  final int length;
  final int i;
  final Statment st;
  final Function longp;
  const Statmentstemp({
    Key? key,
    required this.size,
    required this.length,
    required this.i,
    required this.st,
    required this.longp,
  }) : super(key: key);

  @override
  State<Statmentstemp> createState() => _StatmentstempState();
}

class _StatmentstempState extends State<Statmentstemp> {
  final _loading = BoolStream();

  @override
  void dispose() {
    _loading.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: _loading.stream,
        initialData: false,
        builder: (context, snapshot) {
          return InkWell(
            onTap: () {
              _loading.sink.add(!snapshot.data!);
            },
            onLongPress: () {
              widget.longp();
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              margin: EdgeInsets.only(
                bottom: widget.length - 1 == widget.i
                    ? widget.size.height * 0.11
                    : widget.size.height * 0.03,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: widget.size.width * 0.05,
                vertical: widget.size.height * 0.025,
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColor.whit,
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 10),
                    blurRadius: 20,
                    color: AppColor.txtcol.withOpacity(0.23),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.st.name,
                              style: TextStyle(
                                fontSize: widget.size.width * 0.045,
                                fontWeight: FontWeight.bold,
                                color: AppColor.txtcol,
                              ),
                              maxLines: 1,
                            ),
                            SizedBox(height: widget.size.height * 0.01),
                            Text(
                              DateFormat('dd/MM/yyyy').format(widget.st.date),
                              style: TextStyle(
                                fontSize: widget.size.width * 0.035,
                                color: AppColor.txtcol,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        widget.st.debit
                            ? '- ${widget.st.amount.toStringAsFixed(2)}'
                            : '+ ${widget.st.amount.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: widget.st.debit
                              ? AppColor.butred
                              : AppColor.butgreen,
                          fontSize: widget.size.width * 0.05,
                        ),
                      ),
                    ],
                  ),
                  if (snapshot.data!)
                    Container(
                      margin: EdgeInsets.only(
                        top: widget.size.height * 0.03,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.st.remark,
                              style: TextStyle(
                                fontSize: widget.size.width * 0.035,
                                color: AppColor.txtcol,
                              ),
                            ),
                          ),
                          SizedBox(width: widget.size.width * 0.1),
                          Text(
                            widget.st.debit
                                ? AppString.debited
                                : AppString.credited,
                            style: TextStyle(
                              color: widget.st.debit
                                  ? AppColor.butred
                                  : AppColor.butgreen,
                              fontSize: widget.size.width * 0.035,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          );
        });
  }
}
