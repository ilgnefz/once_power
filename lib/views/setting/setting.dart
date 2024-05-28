import 'package:flutter/material.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 80),
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 1200,
          maxHeight: 800,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('功能-整理文件夹、记录元数据、图片自动全屏、日期间隔、日期长度'),
            Text('整理文件：'),
            Text('主题-浅色、深色、跟随系统、自定义'),
            Text('语言'),
            Text('开源地址'),
            Text('许可证'),
            Text('版本信息'),
          ],
        ),
      ),
    );
  }
}
