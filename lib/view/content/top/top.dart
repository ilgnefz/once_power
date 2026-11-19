import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/number.dart';
import 'package:once_power/enmu/app.dart';
import 'package:once_power/model/file.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/switch.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/view/content/top/filter.dart';
import 'package:once_power/view/content/top/normal.dart';
import 'package:once_power/view/content/top/view.dart';
import 'package:once_power/widget/base/checkbox.dart';
import 'package:once_power/widget/base/icon.dart';

class ContentTop extends StatelessWidget {
  const ContentTop({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppNumber.topHeight,
      padding: .only(right: AppNumber.padding),
      child: Row(
        children: [
          Consumer(
            builder: (_, ref, _) {
              // 全选框只是列表状态的投影，不另存一份 state——存了就会和
              // fileListProvider 打架：checkAll 之后列表一变，build 重算又把
              // 手写的 state 覆盖掉。record 做 key，只有这两项真的变了才重建。
              // 三态：全选 true / 部分 null / 没选 false。
              final (bool isEmpty, bool? checked) = ref.watch(
                fileListProvider.select((List<FileInfo> files) {
                  final int checkedCount = files
                      .where((FileInfo file) => file.checked)
                      .length;
                  return (
                    files.isEmpty,
                    checkedCount == 0
                        ? false
                        : checkedCount == files.length
                        ? true
                        : null,
                  );
                }),
              );
              return EasyCheckbox(
                checked: checked,
                // 空列表没有可切换的对象，禁用比让它空点一下闪一下要好。
                // 勾着 → 全不选；横杠 / 空 → 全选；忽略 value，Checkbox 的
                // tristate 循环顺序（false→true→null）跟业务语义对不上。
                onChanged: isEmpty
                    ? null
                    : (value) => ref
                          .read(fileListProvider.notifier)
                          .toggleAllChecked(checked != true),
              );
            },
          ),
          Expanded(
            child: Consumer(
              builder: (_, ref, _) {
                bool isOrganize = ref.watch(
                  currentModeProvider.select((m) => m.isOrganize),
                );
                bool isViewMode = ref.watch(isViewModeProvider);
                if (!isOrganize && isViewMode) return ViewTop();
                return NormalTop(isOrganize: isOrganize);
              },
            ),
          ),
          const TopFilter(),
          Consumer(
            builder: (_, ref, _) => ClickIcon(
              onPressed: ref.read(fileListProvider.notifier).clear,
              icon: Icons.delete,
            ),
          ),
        ],
      ),
    );
  }
}
