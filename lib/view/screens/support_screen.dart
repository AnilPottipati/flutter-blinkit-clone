import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/controller/support_controller.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  final SupportController controller = Get.put(SupportController());
  final TextEditingController messageController = TextEditingController();

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  Widget _buildMessage(SupportMessage message) {
    final isUser = message.isUser;
    final align = isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final bgColor = isUser ? Colors.blue[100] : Colors.grey[200];
    final textColor = Colors.black87;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.h),
      child: Column(
        crossAxisAlignment: align,
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            constraints: BoxConstraints(maxWidth: 250.w),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: message.file != null
                ? Column(
              crossAxisAlignment: align,
              children: [
                Icon(Icons.insert_drive_file, size: 40.w),
                SizedBox(height: 4.h),
                Text(
                  message.file!.path.split('/').last,
                  style: TextStyle(color: textColor, fontSize: 14.sp),
                ),
              ],
            )
                : Text(
              message.text ?? '',
              style: TextStyle(color: textColor, fontSize: 14.sp),
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            DateFormat('hh:mm a').format(message.timestamp),
            style: TextStyle(fontSize: 10.sp, color: Colors.grey),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil in build in case not initialized
    ScreenUtil.init(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Support Chat', style: TextStyle(fontSize: 18.sp)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                final messages = controller.messages;
                return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[messages.length - index - 1];
                    return Align(
                      alignment: message.isUser
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: _buildMessage(message),
                    );
                  },
                );
              }),
            ),
            Divider(height: 1.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.attach_file, size: 24.w),
                    onPressed: () => controller.sendFileWithMessage(context),
                  ),

                  Expanded(
                    child:
                    TextField(

                      controller: controller.inputController,
                      decoration: InputDecoration(
                        hintText: "Type a message...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
                      ),
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  IconButton(
                    icon: Icon(Icons.send, size: 24.w),
                    onPressed: controller.sendMessage,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
