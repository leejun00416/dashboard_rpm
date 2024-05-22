import 'package:dashboard_rpm/exceptions/custom_exception.dart';
import 'package:flutter/material.dart';

void errorDialogWidget(BuildContext context, CustomException e) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          // 에러 코드
          title: Text(e.code),
          // 에러 내용
          content: Text(e.message),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('확인'),
            ),
          ],
        );
      },
  );
}