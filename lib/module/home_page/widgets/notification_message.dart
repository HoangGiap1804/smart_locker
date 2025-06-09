import 'package:flutter/material.dart';

class NotificationMessage {
  void notify(BuildContext context, String content) {
    showDialog(
      context: context,
      barrierDismissible: false, // Nhấn ra ngoài không tắt
      builder: (context) {
        return Center(
          child: Container(
            width: 300,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  (content == "Success")
                      ? Icons.check_circle
                      : Icons.error_sharp,
                  color:
                      (content == "Success")
                          ? Colors.greenAccent
                          : Colors.redAccent,
                  size: 48,
                ),
                SizedBox(height: 12),
                Text(
                  content,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Close"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
