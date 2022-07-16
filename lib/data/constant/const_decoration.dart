import 'package:flutter/material.dart';

import './../../domain/all.dart';

class ConstDecoration {
  static final BoxDecoration containerdeco = BoxDecoration(
    color: AppColor.whit,
    borderRadius: BorderRadius.circular(8),
    boxShadow: [
      BoxShadow(
        offset: const Offset(0, 10),
        blurRadius: 20,
        color: AppColor.txtcol.withOpacity(0.23),
      ),
    ],
  );
}
