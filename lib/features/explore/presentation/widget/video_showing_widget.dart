// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';

// class VideoPlayerWidget extends StatefulWidget {
//   final String url;
//   const VideoPlayerWidget({super.key, required this.url});

//   @override
//   State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
// }

// class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
//   late VideoPlayerController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url))
//       ..initialize().then((_) {
//         setState(() {});
//       });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.all(8),
//       child: Column(
//         children: [
//           _controller.value.isInitialized
//               ? AspectRatio(
//                   aspectRatio: _controller.value.aspectRatio,
//                   child: VideoPlayer(_controller),
//                 )
//               : const SizedBox(
//                   height: 200,
//                   child: Center(child: CircularProgressIndicator())),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               IconButton(
//                 icon: Icon(_controller.value.isPlaying
//                     ? Icons.pause
//                     : Icons.play_arrow),
//                 onPressed: () {
//                   setState(() {
//                     _controller.value.isPlaying
//                         ? _controller.pause()
//                         : _controller.play();
//                   });
//                 },
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';

// class VideoPlayerWidget extends StatefulWidget {
//   final String url;
//   const VideoPlayerWidget({super.key, required this.url});

//   @override
//   State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
// }

// class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
//   late VideoPlayerController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url))
//       ..initialize().then((_) {
//         setState(() {});
//       });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.all(8),
//       child: ConstrainedBox(
//         constraints: BoxConstraints(
//           maxHeight: 200, // Set a maximum height constraint
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min, // Use minimum space needed
//           children: [
//             Expanded(
//               // Use Expanded to let the video take available space
//               child: _controller.value.isInitialized
//                   ? AspectRatio(
//                       aspectRatio: _controller.value.aspectRatio,
//                       child: VideoPlayer(_controller),
//                     )
//                   : const Center(child: CircularProgressIndicator()),
//             ),
//             Container(
//               padding: EdgeInsets.symmetric(vertical: 4),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 mainAxisSize: MainAxisSize.min, // Use minimum horizontal space
//                 children: [
//                   IconButton(
//                     icon: Icon(
//                       _controller.value.isPlaying
//                           ? Icons.pause
//                           : Icons.play_arrow,
//                       size: 24, // Smaller icon size
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         _controller.value.isPlaying
//                             ? _controller.pause()
//                             : _controller.play();
//                       });
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

///This version is working properly excepet first long video and the videos come out of the container when played

// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';

// class VideoPlayerWidget extends StatefulWidget {
//   final String url;
//   const VideoPlayerWidget({super.key, required this.url});

//   @override
//   State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
// }

// class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
//   late VideoPlayerController _controller;
//   bool _isInitialized = false;

//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url))
//       ..initialize().then((_) {
//         setState(() {
//           _isInitialized = true;
//         });
//       });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.all(8),
//       elevation: 4,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Container(
//         width: double.infinity, // Take full width
//         height: 200, // Fixed height for consistency
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(12),
//           color: Colors.black,
//         ),
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
//             // Video player with consistent sizing
//             if (_isInitialized)
//               Container(
//                 width: double.infinity,
//                 height: double.infinity,
//                 child: FittedBox(
//                   fit: BoxFit
//                       .cover, // Cover the container while maintaining aspect ratio
//                   child: SizedBox(
//                     width: _controller.value.size.width,
//                     height: _controller.value.size.height,
//                     child: VideoPlayer(_controller),
//                   ),
//                 ),
//               )
//             else
//               const Center(
//                 child: CircularProgressIndicator(
//                   color: Colors.white,
//                 ),
//               ),

//             // Play/Pause button overlay (only show when video is paused or not playing)
//             if (_isInitialized &&
//                 (!_controller.value.isPlaying ||
//                     _controller.value.position == _controller.value.duration))
//               Container(
//                 color: Colors.black38,
//                 child: Center(
//                   child: IconButton(
//                     icon: Icon(
//                       _controller.value.isPlaying
//                           ? Icons.pause
//                           : Icons.play_arrow,
//                       size: 48,
//                       color: Colors.white,
//                     ),
//                     onPressed: _togglePlayPause,
//                   ),
//                 ),
//               ),

//             // Video progress indicator at bottom
//             if (_isInitialized)
//               Positioned(
//                 bottom: 0,
//                 left: 0,
//                 right: 0,
//                 child: VideoProgressIndicator(
//                   _controller,
//                   allowScrubbing: true,
//                   colors: const VideoProgressColors(
//                     playedColor: Colors.red,
//                     bufferedColor: Colors.grey,
//                     backgroundColor: Colors.grey,
//                   ),
//                 ),
//               ),

//             // Loading overlay
//             if (!_isInitialized)
//               const Positioned.fill(
//                 child: Center(
//                   child: CircularProgressIndicator(
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _togglePlayPause() {
//     setState(() {
//       if (_controller.value.isPlaying) {
//         _controller.pause();
//       } else {
//         _controller.play();
//       }
//     });
//   }
// }

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String url;
  const VideoPlayerWidget({super.key, required this.url});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url))
      ..initialize().then((_) {
        setState(() {
          _isInitialized = true;
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: double.infinity, // Take full width
        height: 200, // Fixed height for consistency
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.black,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Video player with proper containment
              if (_isInitialized)
                Center(
                  child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: Container(
                      color: Colors.black,
                      child: VideoPlayer(_controller),
                    ),
                  ),
                )
              else
                const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),

              // Play/Pause button overlay
              if (_isInitialized)
                Positioned.fill(
                  child: AnimatedOpacity(
                    opacity: _controller.value.isPlaying ? 0.0 : 1.0,
                    duration: const Duration(milliseconds: 300),
                    child: Container(
                      color: Colors.black38,
                      child: Center(
                        child: IconButton(
                          icon: Icon(
                            _controller.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                            size: 48,
                            color: Colors.white,
                          ),
                          onPressed: _togglePlayPause,
                        ),
                      ),
                    ),
                  ),
                ),

              // Video progress indicator at bottom
              if (_isInitialized)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: Colors.black54,
                    child: VideoProgressIndicator(
                      _controller,
                      allowScrubbing: true,
                      colors: const VideoProgressColors(
                        playedColor: Colors.red,
                        bufferedColor: Colors.grey,
                        backgroundColor: Colors.grey,
                      ),
                    ),
                  ),
                ),

              // Loading overlay
              if (!_isInitialized)
                const Positioned.fill(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _togglePlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
      } else {
        _controller.play();
      }
    });
  }
}
