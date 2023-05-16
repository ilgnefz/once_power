// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'zh';

  static String m0(name, num, reason) =>
      "[ ${name} ] ${num} 个文件因为 [ ${reason} ] 更新失败。";

  static String m1(all, done) => "所选${all}个文件中${done}个已更名成功 🎉";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "LICENSE": MessageLookupByLibrary.simpleMessage("开源许可证"),
        "about": MessageLookupByLibrary.simpleMessage("关于"),
        "addFolder": MessageLookupByLibrary.simpleMessage("添加文件夹"),
        "adding": MessageLookupByLibrary.simpleMessage("正在添加"),
        "appendMode": MessageLookupByLibrary.simpleMessage("追加模式"),
        "applyChange": MessageLookupByLibrary.simpleMessage("应用更改"),
        "audio": MessageLookupByLibrary.simpleMessage("音频"),
        "cancelAdd": MessageLookupByLibrary.simpleMessage("取消添加"),
        "cancelProcessing": MessageLookupByLibrary.simpleMessage("取消处理"),
        "caseSensitive": MessageLookupByLibrary.simpleMessage("区分大小写"),
        "copyErrorMessage": MessageLookupByLibrary.simpleMessage("复制错误信息"),
        "copySucceeded": MessageLookupByLibrary.simpleMessage("复制成功"),
        "copySucceededText":
            MessageLookupByLibrary.simpleMessage("错误内容已成功复制到剪贴板 😃"),
        "createDate": MessageLookupByLibrary.simpleMessage("创建日期"),
        "currentLatest": MessageLookupByLibrary.simpleMessage("当前已是最新版本"),
        "currentVersion": MessageLookupByLibrary.simpleMessage("当前版本"),
        "darkTheme": MessageLookupByLibrary.simpleMessage("深色主题"),
        "dateRename": MessageLookupByLibrary.simpleMessage("日期命名"),
        "defaultFolder": MessageLookupByLibrary.simpleMessage("请选择一个文件夹"),
        "defaultMode": MessageLookupByLibrary.simpleMessage("默认模式"),
        "deleteEmptyFolder": MessageLookupByLibrary.simpleMessage("删除空文件夹"),
        "deleteFailed": MessageLookupByLibrary.simpleMessage("删除失败"),
        "deleteFailedText":
            MessageLookupByLibrary.simpleMessage("删除失败，因为没有可以删除的内容...😓"),
        "deleteLength": MessageLookupByLibrary.simpleMessage("删除指定长度"),
        "deleteSucceeded": MessageLookupByLibrary.simpleMessage("删除成功"),
        "deleteSucceededText":
            MessageLookupByLibrary.simpleMessage("已成功删除所有空文件夹 😁"),
        "deleteUnselected": MessageLookupByLibrary.simpleMessage("删除未选中"),
        "desc": MessageLookupByLibrary.simpleMessage(
            "🛠 一款基于 Flutter 开发的用于批量重命名文件的工具，还有移除无用嵌套文件夹的功能"),
        "detectError": MessageLookupByLibrary.simpleMessage("检测失败"),
        "detectVersions": MessageLookupByLibrary.simpleMessage("检测新版本"),
        "detecting": MessageLookupByLibrary.simpleMessage("检测中..."),
        "digitIncrementHint": MessageLookupByLibrary.simpleMessage("输入N位数个字符"),
        "digits": MessageLookupByLibrary.simpleMessage("位数"),
        "disable": MessageLookupByLibrary.simpleMessage("不使用"),
        "downloadLink": MessageLookupByLibrary.simpleMessage("下载链接"),
        "dropFile": MessageLookupByLibrary.simpleMessage("拖动文件夹到这里"),
        "earliestDate": MessageLookupByLibrary.simpleMessage("最早日期"),
        "enterNumbers": MessageLookupByLibrary.simpleMessage("输入数字"),
        "exchangeSeat": MessageLookupByLibrary.simpleMessage("交换递增数字位置"),
        "exifDate": MessageLookupByLibrary.simpleMessage("拍摄日期"),
        "folder": MessageLookupByLibrary.simpleMessage("文件夹"),
        "followSystem": MessageLookupByLibrary.simpleMessage("跟随系统"),
        "image": MessageLookupByLibrary.simpleMessage("图片"),
        "incrementalStartNumber":
            MessageLookupByLibrary.simpleMessage("递增开始数字"),
        "inputDisabled": MessageLookupByLibrary.simpleMessage("输入已禁用"),
        "inputError": MessageLookupByLibrary.simpleMessage("输入出错了"),
        "inputErrorText": MessageLookupByLibrary.simpleMessage("请输入正确的数字 😣"),
        "language": MessageLookupByLibrary.simpleMessage("语言"),
        "languageTip": MessageLookupByLibrary.simpleMessage("重启生效"),
        "latestDate": MessageLookupByLibrary.simpleMessage("最晚日期"),
        "latestVersion": MessageLookupByLibrary.simpleMessage("最新版本"),
        "lengthMatchText":
            MessageLookupByLibrary.simpleMessage("输入指定长度字符串或 *N（N为数字）"),
        "lengthMode": MessageLookupByLibrary.simpleMessage("长度模式"),
        "lightTheme": MessageLookupByLibrary.simpleMessage("浅色主题"),
        "link": MessageLookupByLibrary.simpleMessage("链接"),
        "log": MessageLookupByLibrary.simpleMessage("记录日志(默认在目标文件夹)"),
        "loopFileContent": MessageLookupByLibrary.simpleMessage("循环文件内容"),
        "matchText": MessageLookupByLibrary.simpleMessage("匹配内容"),
        "modifyDate": MessageLookupByLibrary.simpleMessage("修改日期"),
        "multiFailedText": m0,
        "name": MessageLookupByLibrary.simpleMessage("名称"),
        "newVersion": MessageLookupByLibrary.simpleMessage("有新版本"),
        "onlyPrefix": MessageLookupByLibrary.simpleMessage("仅前缀"),
        "onlySuffix": MessageLookupByLibrary.simpleMessage("仅后缀"),
        "organizeFailed": MessageLookupByLibrary.simpleMessage("文件整理失败"),
        "organizeFile": MessageLookupByLibrary.simpleMessage("整理文件"),
        "organizeSuccess": MessageLookupByLibrary.simpleMessage("文件整理成功"),
        "originalName": MessageLookupByLibrary.simpleMessage("原始名称"),
        "other": MessageLookupByLibrary.simpleMessage("其他"),
        "prefix": MessageLookupByLibrary.simpleMessage("前缀"),
        "prefixDigitIncrement": MessageLookupByLibrary.simpleMessage("前缀数字递增"),
        "processing": MessageLookupByLibrary.simpleMessage("正在处理"),
        "projectUrl": MessageLookupByLibrary.simpleMessage("项目地址"),
        "renameFailed": MessageLookupByLibrary.simpleMessage("重命名失败"),
        "renameFailedExists":
            MessageLookupByLibrary.simpleMessage("目录下已存在同名文件，请重新更名后再试 😥"),
        "renameFailedUnmodified":
            MessageLookupByLibrary.simpleMessage("新文件名和原名称一样 😤"),
        "renameName": MessageLookupByLibrary.simpleMessage("重命名名称"),
        "renameSucceeded": MessageLookupByLibrary.simpleMessage("重命名成功"),
        "renameSucceededText": m1,
        "reservedMode": MessageLookupByLibrary.simpleMessage("保留模式"),
        "selectFile": MessageLookupByLibrary.simpleMessage("选择文件"),
        "selectFolder": MessageLookupByLibrary.simpleMessage("选择文件夹"),
        "setting": MessageLookupByLibrary.simpleMessage("设置"),
        "showUnselected": MessageLookupByLibrary.simpleMessage("显示未选中"),
        "startOrganizing": MessageLookupByLibrary.simpleMessage("开始整理"),
        "suffix": MessageLookupByLibrary.simpleMessage("后缀"),
        "suffixDigitIncrement": MessageLookupByLibrary.simpleMessage("后缀数字递增"),
        "targetFolder": MessageLookupByLibrary.simpleMessage("目标文件夹"),
        "text": MessageLookupByLibrary.simpleMessage("文本"),
        "theme": MessageLookupByLibrary.simpleMessage("主题"),
        "updateText": MessageLookupByLibrary.simpleMessage("修改为"),
        "uploadFailed": MessageLookupByLibrary.simpleMessage("上传失败"),
        "uploadFailedText":
            MessageLookupByLibrary.simpleMessage("请上传使用换行或空格进行分隔了内容的文件 🥱"),
        "useAll": MessageLookupByLibrary.simpleMessage("全部使用"),
        "versionDesc": MessageLookupByLibrary.simpleMessage("版本描述"),
        "video": MessageLookupByLibrary.simpleMessage("视频")
      };
}
