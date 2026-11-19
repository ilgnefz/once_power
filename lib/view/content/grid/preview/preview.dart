import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:once_power/model/file.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/view/content/grid/preview/image.dart';

class PreviewView extends ConsumerStatefulWidget {
  const PreviewView({super.key, required this.index});

  final int index;

  @override
  ConsumerState<PreviewView> createState() => _PreviewViewState();
}

class _PreviewViewState extends ConsumerState<PreviewView> {
  late int index;
  late FileInfo file;
  List<FileInfo> list = [];

  @override
  void initState() {
    super.initState();
    index = widget.index;
    list = ref.read(sortListProvider);
    file = list[index];
  }

  void next() {
    index = index < list.length - 1 ? index + 1 : 0;
    file = list[index];
    setState(() {});
  }

  void prev() {
    index = index > 0 ? index - 1 : list.length - 1;
    file = list[index];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: file.id,
      createRectTween: (Rect? begin, Rect? end) =>
          RectTween(begin: begin, end: end),
      child: Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: InkWell(
          onTap: () => Navigator.pop(context),
          child: Stack(
            children: [
              Center(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 150),
                  child: PreviewImage(
                    key: ValueKey(file.id),
                    id: file.id,
                    file: file.path,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_left_rounded),
                  onPressed: prev,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: const Icon(Icons.arrow_right_rounded),
                  onPressed: next,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
