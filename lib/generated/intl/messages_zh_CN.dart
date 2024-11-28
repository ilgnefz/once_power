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

  static String m4(count, total) => "已选择 ${count}/${total}";

  static String m5(version) => "新的版本 ${version} 可以更新";

  static String m6(name) => "在 ${name} 中已不存在";

  static String m7(total) => "已成功移动所选中的${total}个文件";

  static String m8(count) => "已移除${count}个非图片文件";

  static String m9(total) => "选中的 ${total} 个已全部重命名成功";

  static String m10(count, total) => "选中 ${total} 个中 ${count} 个取消重命名失败";

  static String m11(total) => "选中的 ${total} 个已全部撤销操作";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addFile": MessageLookupByLibrary.simpleMessage("添加文件"),
        "addFolder": MessageLookupByLibrary.simpleMessage("添加文件夹"),
        "addSubfolder": MessageLookupByLibrary.simpleMessage("获取文件夹的子文件夹"),
        "after": MessageLookupByLibrary.simpleMessage("之后的"),
        "allExtension": MessageLookupByLibrary.simpleMessage("全部扩展"),
        "appendMode": MessageLookupByLibrary.simpleMessage("追加模式"),
        "applyChange": MessageLookupByLibrary.simpleMessage("应用更改"),
        "audio": MessageLookupByLibrary.simpleMessage("音频"),
        "before": MessageLookupByLibrary.simpleMessage("之前的"),
        "between": MessageLookupByLibrary.simpleMessage("之间的"),
        "caseClassify": MessageLookupByLibrary.simpleMessage("区分类型"),
        "caseDesc": MessageLookupByLibrary.simpleMessage("区分大小写"),
        "caseExtension": MessageLookupByLibrary.simpleMessage("区分扩展"),
        "checkCompleted": MessageLookupByLibrary.simpleMessage("检查完成"),
        "checkFailed": MessageLookupByLibrary.simpleMessage("检查失败"),
        "checkUpdate": MessageLookupByLibrary.simpleMessage("检查更新"),
        "checking": MessageLookupByLibrary.simpleMessage("检查中"),
        "circularPrefixDesc": MessageLookupByLibrary.simpleMessage("循环前缀内容"),
        "circularSuffixDesc": MessageLookupByLibrary.simpleMessage("循环后缀内容"),
        "classifiedFile": MessageLookupByLibrary.simpleMessage("分类文件"),
        "classifiedFileDesc":
            MessageLookupByLibrary.simpleMessage("根据不同类型或不同修改时间为文件创建父文件夹"),
        "createdDate": MessageLookupByLibrary.simpleMessage("创建日期"),
        "createdTime": MessageLookupByLibrary.simpleMessage("创建日期"),
        "currentTask": MessageLookupByLibrary.simpleMessage("当前任务"),
        "date": MessageLookupByLibrary.simpleMessage("日期"),
        "dateDesc": MessageLookupByLibrary.simpleMessage("以日期命名"),
        "decodeCSVError": MessageLookupByLibrary.simpleMessage("文件解析出错了"),
        "deleteChecked": MessageLookupByLibrary.simpleMessage("删除选中的文件"),
        "deleteEmptyFolder": MessageLookupByLibrary.simpleMessage("删除空文件夹"),
        "deleteEmptyFolderDesc":
            MessageLookupByLibrary.simpleMessage("删除所选文件夹下的所有空文件夹"),
        "deleteFailed": MessageLookupByLibrary.simpleMessage("删除失败"),
        "deleteInfo": m0,
        "deleteLog": MessageLookupByLibrary.simpleMessage("删除日志"),
        "deleteSuccessful": MessageLookupByLibrary.simpleMessage("删除成功"),
        "detailTitle": MessageLookupByLibrary.simpleMessage("所有文件扩展"),
        "digits": MessageLookupByLibrary.simpleMessage("位"),
        "document": MessageLookupByLibrary.simpleMessage("文档"),
        "download": MessageLookupByLibrary.simpleMessage("下载"),
        "earliestDate": MessageLookupByLibrary.simpleMessage("最早日期"),
        "errorImage": MessageLookupByLibrary.simpleMessage("加载失败 "),
        "exifDate": MessageLookupByLibrary.simpleMessage("拍摄日期"),
        "existsError": m1,
        "exit": MessageLookupByLibrary.simpleMessage("退出"),
        "exitOperation": MessageLookupByLibrary.simpleMessage("退出操作"),
        "extension": MessageLookupByLibrary.simpleMessage("扩展"),
        "extensionDesc": MessageLookupByLibrary.simpleMessage("启用修改扩展名"),
        "failed": MessageLookupByLibrary.simpleMessage("重命名失败"),
        "failedError": m2,
        "failedNum": m3,
        "failureDeleteInfo": MessageLookupByLibrary.simpleMessage("删除选中的文件失败"),
        "failureEmptyInfo": MessageLookupByLibrary.simpleMessage("删除空文件夹失败"),
        "fileCount": m4,
        "fileExtension": MessageLookupByLibrary.simpleMessage("文件扩展名"),
        "fileExtensionDesc": MessageLookupByLibrary.simpleMessage("新扩展名"),
        "fileName": MessageLookupByLibrary.simpleMessage("文件名"),
        "folder": MessageLookupByLibrary.simpleMessage("文件夹"),
        "image": MessageLookupByLibrary.simpleMessage("图片"),
        "inputDisable": MessageLookupByLibrary.simpleMessage("输入已禁用"),
        "latestDate": MessageLookupByLibrary.simpleMessage("最晚日期"),
        "lengthDesc":
            MessageLookupByLibrary.simpleMessage("输入长度截取（两个数字之间加空格截取中间部分）"),
        "loadingImage": MessageLookupByLibrary.simpleMessage("加载中..."),
        "log": MessageLookupByLibrary.simpleMessage("日志"),
        "logDesc": MessageLookupByLibrary.simpleMessage(
            "目标文件夹不为空保存在目标文件夹下，否则保存在软件目录 logs 文件夹下"),
        "match": MessageLookupByLibrary.simpleMessage("匹配的"),
        "matchHint": MessageLookupByLibrary.simpleMessage("匹配内容"),
        "matchLength": MessageLookupByLibrary.simpleMessage("输入数字或指定长度字符串"),
        "matchName": MessageLookupByLibrary.simpleMessage("匹配名称"),
        "modifiedDate": MessageLookupByLibrary.simpleMessage("修改日期"),
        "modifiedTime": MessageLookupByLibrary.simpleMessage("修改日期"),
        "modifyName": MessageLookupByLibrary.simpleMessage("修改名称"),
        "modifyTo": MessageLookupByLibrary.simpleMessage("修改为"),
        "moveError": MessageLookupByLibrary.simpleMessage("移动出错了"),
        "moveFailed": MessageLookupByLibrary.simpleMessage("移动失败"),
        "moveToFirst": MessageLookupByLibrary.simpleMessage("移至首位"),
        "moveToLast": MessageLookupByLibrary.simpleMessage("移至末尾"),
        "newName": MessageLookupByLibrary.simpleMessage("新名称"),
        "newVersionInfo": m5,
        "noNewVersionInfo": MessageLookupByLibrary.simpleMessage("当前已是最新版本"),
        "notExist": MessageLookupByLibrary.simpleMessage("不存在"),
        "notExistsError": m6,
        "openFolder": MessageLookupByLibrary.simpleMessage("打开文件夹"),
        "openFolderDesc":
            MessageLookupByLibrary.simpleMessage("鼠标左键点击文件列表可以快速打开文件所在文件夹"),
        "organize": MessageLookupByLibrary.simpleMessage("整理"),
        "organizeBtn": MessageLookupByLibrary.simpleMessage("整理文件"),
        "organizeFolderDesc": MessageLookupByLibrary.simpleMessage(
            "将添加的所有文件或文件夹下的所有子文件移动到目标文件夹内，如果目标文件夹为空，并且选择使用顶级父文件夹，则会将所有文件移动到所选文件除磁盘根目录以外的顶级父文件夹内"),
        "organizeLogs": MessageLookupByLibrary.simpleMessage("整理日志"),
        "organizeMenu": MessageLookupByLibrary.simpleMessage("整理菜单"),
        "organizedSuccessfully": MessageLookupByLibrary.simpleMessage("整理成功"),
        "organizedSuccessfullyInfo": m7,
        "organizingFailed": MessageLookupByLibrary.simpleMessage("整理失败"),
        "organizingFailedInfo":
            MessageLookupByLibrary.simpleMessage("以下几个移动失败"),
        "originalName": MessageLookupByLibrary.simpleMessage("原名称"),
        "other": MessageLookupByLibrary.simpleMessage("其他"),
        "prefix": MessageLookupByLibrary.simpleMessage("前缀"),
        "prefixContent": MessageLookupByLibrary.simpleMessage("添加前缀内容"),
        "regeditTip": MessageLookupByLibrary.simpleMessage(
            "开启右键快捷菜单（软件未运行时windows系统只允许一次传入一个文件路径，所以未运行本软件时只允许传入一个文件夹路径，你可以将所有文件放置到一个文件夹中。若想一次传入多个请将该软件的快捷方式放置在\"发送到\"文件夹下（打开文件资源管理器，在地址栏中输入 shell:sendto 并回车），使用\"发送到\"传入）"),
        "remove": MessageLookupByLibrary.simpleMessage("移除"),
        "removeNonImage": m8,
        "removeSelected": MessageLookupByLibrary.simpleMessage("移除已选中"),
        "removeUnselected": MessageLookupByLibrary.simpleMessage("移除未选中"),
        "renameLogs": MessageLookupByLibrary.simpleMessage("重命名日志"),
        "renameName": MessageLookupByLibrary.simpleMessage("重命名名称"),
        "replace": MessageLookupByLibrary.simpleMessage("替换"),
        "reserve": MessageLookupByLibrary.simpleMessage("保留"),
        "restartTip": MessageLookupByLibrary.simpleMessage("重启生效"),
        "saveConfig": MessageLookupByLibrary.simpleMessage("保存配置"),
        "saveLog":
            MessageLookupByLibrary.simpleMessage("保存日志（默认在软件文件夹下的 logs 文件夹内）"),
        "select": MessageLookupByLibrary.simpleMessage("选择"),
        "selectAllSwitch": MessageLookupByLibrary.simpleMessage("全选切换"),
        "selectFolder": MessageLookupByLibrary.simpleMessage("选择文件夹"),
        "selectReserve": MessageLookupByLibrary.simpleMessage("全部反选"),
        "selectTargetFolder": MessageLookupByLibrary.simpleMessage("选择目标文件夹"),
        "serial": MessageLookupByLibrary.simpleMessage("增数"),
        "shortcutTip1": MessageLookupByLibrary.simpleMessage("添加所有子文件到"),
        "shortcutTip2": MessageLookupByLibrary.simpleMessage("添加到"),
        "start": MessageLookupByLibrary.simpleMessage("开始"),
        "successDeleteInfo":
            MessageLookupByLibrary.simpleMessage("已成功删除所有选中的文件"),
        "successEmptyInfo": MessageLookupByLibrary.simpleMessage("已成功删除所有空文件夹"),
        "successful": MessageLookupByLibrary.simpleMessage("重命名成功"),
        "successfulNum": m9,
        "suffix": MessageLookupByLibrary.simpleMessage("后缀"),
        "suffixContent": MessageLookupByLibrary.simpleMessage("添加后缀内容"),
        "swapPrefixDesc": MessageLookupByLibrary.simpleMessage("交换前缀和递增数字位置"),
        "swapSuffixDesc": MessageLookupByLibrary.simpleMessage("交换后缀和递增数字位置"),
        "tableInfo": MessageLookupByLibrary.simpleMessage("已选择原名称列为："),
        "takeTime": MessageLookupByLibrary.simpleMessage("用时"),
        "targetFolder": MessageLookupByLibrary.simpleMessage("目标文件夹"),
        "text": MessageLookupByLibrary.simpleMessage("文本"),
        "tip": MessageLookupByLibrary.simpleMessage("拖动文件（夹）到这里"),
        "tipButton1": MessageLookupByLibrary.simpleMessage("我已知晓，不再提醒"),
        "tipButton2": MessageLookupByLibrary.simpleMessage("我已知晓"),
        "tipImage": MessageLookupByLibrary.simpleMessage("拖动图片文件（夹）到这里"),
        "tipMessage": MessageLookupByLibrary.simpleMessage(
            "该操作会将文件从系统中删除，且无法恢复。取消请点击弹窗外面的区域。"),
        "tipTitle": MessageLookupByLibrary.simpleMessage("提示"),
        "today": MessageLookupByLibrary.simpleMessage("今天日期"),
        "topParentFolder": MessageLookupByLibrary.simpleMessage("顶级父文件夹"),
        "tvSeriesInfo": MessageLookupByLibrary.simpleMessage("获取剧集信息"),
        "undo": MessageLookupByLibrary.simpleMessage("撤销"),
        "undoFailed": MessageLookupByLibrary.simpleMessage("撤销重命名失败"),
        "undoFailedNum": m10,
        "undoSuccessful": MessageLookupByLibrary.simpleMessage("已成功撤销"),
        "undoSuccessfulNum": m11,
        "unselect": MessageLookupByLibrary.simpleMessage("取消选择"),
        "uploadCSV": MessageLookupByLibrary.simpleMessage(
            "上传以\",\"分隔新旧名称的csv、txt文件或本软件生成的oplog文件"),
        "uploadDesc": MessageLookupByLibrary.simpleMessage("上传 .txt 文件"),
        "useDesc": MessageLookupByLibrary.simpleMessage("功能使用说明"),
        "useTimeClassification":
            MessageLookupByLibrary.simpleMessage("使用文件修改时间进行分类"),
        "video": MessageLookupByLibrary.simpleMessage("视频"),
        "viewMode": MessageLookupByLibrary.simpleMessage("视图模式"),
        "zip": MessageLookupByLibrary.simpleMessage("压缩包")
      };
}
