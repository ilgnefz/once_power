// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh_CN locale. All the
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
  String get localeName => 'zh_CN';

  static String m0(file) => "【${file}】已被删除";

  static String m1(name) => "重命名为 ${name} 的文件已存在";

  static String m2(name) => "重命名失败,因为 ${name}";

  static String m3(count, total) => "选中 ${total} 个中 ${count} 个重命名失败";

  static String m4(total, count) => "${total} 个文件已选择 ${count} 个";

  static String m5(version) => "新的版本 ${version} 可以更新";

  static String m6(name) => "在 ${name} 中已不存在";

  static String m7(total) => "选中的 ${total} 个已全部重命名成功";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addFile": MessageLookupByLibrary.simpleMessage("添加文件"),
        "addFolder": MessageLookupByLibrary.simpleMessage("添加文件夹"),
        "after": MessageLookupByLibrary.simpleMessage("之后的"),
        "appendMode": MessageLookupByLibrary.simpleMessage("追加模式"),
        "applyChange": MessageLookupByLibrary.simpleMessage("应用更改"),
        "audio": MessageLookupByLibrary.simpleMessage("音频"),
        "before": MessageLookupByLibrary.simpleMessage("之前的"),
        "between": MessageLookupByLibrary.simpleMessage("之间的"),
        "caseDesc": MessageLookupByLibrary.simpleMessage("区分大小写"),
        "checkCompleted": MessageLookupByLibrary.simpleMessage("检查完成"),
        "checkFailed": MessageLookupByLibrary.simpleMessage("检查失败"),
        "checkUpdate": MessageLookupByLibrary.simpleMessage("检查更新"),
        "checking": MessageLookupByLibrary.simpleMessage("检查中"),
        "circularPrefixDesc": MessageLookupByLibrary.simpleMessage("循环前缀内容"),
        "circularSuffixDesc": MessageLookupByLibrary.simpleMessage("循环后缀内容"),
        "closeSaveConfig": MessageLookupByLibrary.simpleMessage("未开启保存配置"),
        "createdDate": MessageLookupByLibrary.simpleMessage("创建日期"),
        "createdTime": MessageLookupByLibrary.simpleMessage("创建日期"),
        "currentTask": MessageLookupByLibrary.simpleMessage("当前任务"),
        "date": MessageLookupByLibrary.simpleMessage("日期"),
        "dateDesc": MessageLookupByLibrary.simpleMessage("以日期命名"),
        "delete": MessageLookupByLibrary.simpleMessage("删除"),
        "deleteEmptyFolder": MessageLookupByLibrary.simpleMessage("删除空文件夹"),
        "deleteEmptyFolderDesc":
            MessageLookupByLibrary.simpleMessage("删除添加的文件夹下的所有空文件夹"),
        "deleteFailed": MessageLookupByLibrary.simpleMessage("删除失败"),
        "deleteInfo": m0,
        "deleteLog": MessageLookupByLibrary.simpleMessage("删除日志"),
        "deleteSuccessful": MessageLookupByLibrary.simpleMessage("删除成功"),
        "deleted": MessageLookupByLibrary.simpleMessage("删除未选择"),
        "digits": MessageLookupByLibrary.simpleMessage("位"),
        "download": MessageLookupByLibrary.simpleMessage("下载"),
        "earliestDate": MessageLookupByLibrary.simpleMessage("最早日期"),
        "enableSaveConfig": MessageLookupByLibrary.simpleMessage("已开启保存配置"),
        "exifDate": MessageLookupByLibrary.simpleMessage("拍摄日期"),
        "existsError": m1,
        "extension": MessageLookupByLibrary.simpleMessage("扩展"),
        "extensionDesc": MessageLookupByLibrary.simpleMessage("启用修改扩展名"),
        "failed": MessageLookupByLibrary.simpleMessage("重命名失败"),
        "failedError": m2,
        "failedNum": m3,
        "failureInfo": MessageLookupByLibrary.simpleMessage("删除空文件夹失败"),
        "fileCount": m4,
        "fileExtension": MessageLookupByLibrary.simpleMessage("文件扩展名"),
        "fileExtensionDesc": MessageLookupByLibrary.simpleMessage("新扩展名"),
        "fileName": MessageLookupByLibrary.simpleMessage("文件名"),
        "folder": MessageLookupByLibrary.simpleMessage("文件夹"),
        "image": MessageLookupByLibrary.simpleMessage("图片"),
        "imageViewMode": MessageLookupByLibrary.simpleMessage("图像查看模式"),
        "inputDisable": MessageLookupByLibrary.simpleMessage("输入已禁用"),
        "language": MessageLookupByLibrary.simpleMessage("语言"),
        "latestDate": MessageLookupByLibrary.simpleMessage("最晚日期"),
        "lengthDesc":
            MessageLookupByLibrary.simpleMessage("输入长度截取（两个数字之间加空格截取中间部分）"),
        "log": MessageLookupByLibrary.simpleMessage("日志"),
        "logDesc": MessageLookupByLibrary.simpleMessage("保存的日志会在目标文件夹内"),
        "match": MessageLookupByLibrary.simpleMessage("匹配的"),
        "matchHint": MessageLookupByLibrary.simpleMessage("匹配内容"),
        "matchLength": MessageLookupByLibrary.simpleMessage("输入数字或指定长度字符串"),
        "modifiedDate": MessageLookupByLibrary.simpleMessage("修改日期"),
        "modifiedTime": MessageLookupByLibrary.simpleMessage("修改日期"),
        "modifyTo": MessageLookupByLibrary.simpleMessage("修改为"),
        "moveError": MessageLookupByLibrary.simpleMessage("移动出错了"),
        "moveFailed": MessageLookupByLibrary.simpleMessage("移动失败"),
        "newVersionInfo": m5,
        "noNewVersionInfo": MessageLookupByLibrary.simpleMessage("当前已是最新版本"),
        "notExist": MessageLookupByLibrary.simpleMessage("不存在"),
        "notExistsError": m6,
        "openFolder": MessageLookupByLibrary.simpleMessage("打开文件夹"),
        "openFolderDesc":
            MessageLookupByLibrary.simpleMessage("双击右边文件列表，可以快速打开文件所在文件夹"),
        "organize": MessageLookupByLibrary.simpleMessage("整理"),
        "organizeDesc": MessageLookupByLibrary.simpleMessage("整理文件"),
        "organizeFolder": MessageLookupByLibrary.simpleMessage("整理功能"),
        "organizeFolderDesc": MessageLookupByLibrary.simpleMessage(
            "将添加的所有文件或文件夹下的所有子文件移动到目标文件夹内"),
        "organizeLogs": MessageLookupByLibrary.simpleMessage("整理日志"),
        "organizedSuccessfully": MessageLookupByLibrary.simpleMessage("整理成功"),
        "organizedSuccessfullyInfo":
            MessageLookupByLibrary.simpleMessage("已成功移动所有文件"),
        "organizingFailed": MessageLookupByLibrary.simpleMessage("整理失败"),
        "organizingFailedInfo":
            MessageLookupByLibrary.simpleMessage("以下几个移动失败"),
        "originalName": MessageLookupByLibrary.simpleMessage("原名称"),
        "other": MessageLookupByLibrary.simpleMessage("其他"),
        "prefix": MessageLookupByLibrary.simpleMessage("前缀"),
        "prefixContent": MessageLookupByLibrary.simpleMessage("添加前缀内容"),
        "renamedName": MessageLookupByLibrary.simpleMessage("重命名名称"),
        "replace": MessageLookupByLibrary.simpleMessage("替换"),
        "reserve": MessageLookupByLibrary.simpleMessage("保留"),
        "restartTip": MessageLookupByLibrary.simpleMessage("重启生效"),
        "saveLog": MessageLookupByLibrary.simpleMessage("保存日志"),
        "select": MessageLookupByLibrary.simpleMessage("选择"),
        "selectFolder": MessageLookupByLibrary.simpleMessage("选择文件夹"),
        "selectTargetFolder": MessageLookupByLibrary.simpleMessage("选择目标文件夹"),
        "serial": MessageLookupByLibrary.simpleMessage("增数"),
        "start": MessageLookupByLibrary.simpleMessage("开始"),
        "successInfo": MessageLookupByLibrary.simpleMessage("已成功删除所有空文件夹"),
        "successful": MessageLookupByLibrary.simpleMessage("重命名成功"),
        "successfulNum": m7,
        "suffix": MessageLookupByLibrary.simpleMessage("后缀"),
        "suffixContent": MessageLookupByLibrary.simpleMessage("添加后缀内容"),
        "swapPrefixDesc": MessageLookupByLibrary.simpleMessage("交换前缀和递增数字位置"),
        "swapSuffixDesc": MessageLookupByLibrary.simpleMessage("交换后缀和递增数字位置"),
        "takeTime": MessageLookupByLibrary.simpleMessage("用时"),
        "targetFolder": MessageLookupByLibrary.simpleMessage("目标文件夹"),
        "targetFolderDesc":
            MessageLookupByLibrary.simpleMessage("默认为列表第一个添加的文件的父文件夹或文件夹本身"),
        "text": MessageLookupByLibrary.simpleMessage("文本"),
        "tip": MessageLookupByLibrary.simpleMessage("拖动文件（夹）到这里"),
        "today": MessageLookupByLibrary.simpleMessage("今天日期"),
        "unselect": MessageLookupByLibrary.simpleMessage("取消选择"),
        "uploadDesc": MessageLookupByLibrary.simpleMessage("上传 .txt 文件"),
        "useDesc": MessageLookupByLibrary.simpleMessage("功能使用说明"),
        "video": MessageLookupByLibrary.simpleMessage("视频"),
        "yesterday": MessageLookupByLibrary.simpleMessage("昨天日期"),
        "zip": MessageLookupByLibrary.simpleMessage("压缩包")
      };
}
