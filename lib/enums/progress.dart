enum RunState { uploading, complete, applying }

extension RunStateExtension on RunState {
  bool get isUploading => this == RunState.uploading;
  bool get isComplete => this == RunState.complete;
  bool get isApplying => this == RunState.applying;
}
