import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:reactive_image_picker/image_file.dart';
import 'package:video_player/video_player.dart';

class VideoView extends StatefulWidget {
  final SelectedFileVideo video;

  const VideoView({
    super.key,
    required this.video,
  });

  @override
  VideoViewState createState() => VideoViewState();
}

class VideoViewState extends State<VideoView> {
  VideoPlayerController? _controller;
  bool? initialized = false;

  void _onVideoControllerUpdate() {
    if (!mounted) {
      return;
    }
    if (initialized != _controller?.value.isInitialized) {
      initialized = _controller?.value.isInitialized;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();

    final file = widget.video.file;

    if (file != null) {
      _controller = kIsWeb
          ? VideoPlayerController.network(file.path)
          : VideoPlayerController.file(file);
      _controller?.addListener(_onVideoControllerUpdate);
    }

    final url = widget.video.url;

    if (url != null) {
      _controller = VideoPlayerController.network(url);
      _controller?.addListener(_onVideoControllerUpdate);
    }

    if (_controller != null) {
      _play(_controller);
    }
  }

  Future<void> _play(VideoPlayerController? controller) async {
    await controller?.setVolume(0);
    await controller?.initialize();
    await controller?.setLooping(true);
    await controller?.play();
  }

  @override
  void dispose() {
    _controller?.removeListener(_onVideoControllerUpdate);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;
    if (initialized == true && controller != null) {
      return Center(
        child: AspectRatio(
          aspectRatio: controller.value.aspectRatio,
          child: VideoPlayer(controller),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
