import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';

class VideoPlayerWidget extends StatefulWidget {
  final String url; // The URL or path of the video to play

  const VideoPlayerWidget({Key? key, required this.url}) : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    // Check if the video is an asset or a local file and initialize accordingly
    if (widget.url.startsWith('assets/')) {
      _controller = VideoPlayerController.asset(widget.url) // For assets
        ..initialize().then((_) {
          setState(() {});
          _controller.setLooping(true); // Enable looping
          _controller.play(); // Play the video automatically
        });
    } else {
      _controller = VideoPlayerController.file(File(widget.url)) // For local files
        ..initialize().then((_) {
          setState(() {});
          _controller.setLooping(true); // Enable looping
          _controller.play(); // Play the video automatically
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      // Show loading indicator while the video is initializing
      return const Center(child: CircularProgressIndicator());
    }
    return VideoPlayer(_controller); // Display the video player
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose(); // Clean up when done
  }
}
