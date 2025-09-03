// Youtubre video player : v.0.7
//Youtube Player : responsive verion : v.0.0.1

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:video_player/video_player.dart';
// import 'package:flutter/services.dart';

// class VideoPlayerWidget extends StatefulWidget {
//   final String url;
//   const VideoPlayerWidget({super.key, required this.url});

//   @override
//   State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
// }

// class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
//   late VideoPlayerController _controller;
//   bool _isInitialized = false;
//   bool _showControls = false;
//   bool _isFullScreen = false;
//   Duration _currentPosition = Duration.zero;
//   Duration _totalDuration = Duration.zero;

//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url))
//       ..initialize().then((_) {
//         setState(() {
//           _isInitialized = true;
//           _totalDuration = _controller.value.duration;
//         });
//       });
//     _controller.addListener(_updatePosition);
//   }

//   void _updatePosition() {
//     if (mounted) {
//       setState(() {
//         _currentPosition = _controller.value.position;
//         _totalDuration = _controller.value.duration;
//       });
//     }
//   }

//   @override
//   void dispose() {
//     _controller.removeListener(_updatePosition);
//     _controller.dispose();
//     // Restore UI when leaving
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
//     super.dispose();
//   }

//   String _formatDuration(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, '0');
//     final minutes = twoDigits(duration.inMinutes.remainder(60));
//     final seconds = twoDigits(duration.inSeconds.remainder(60));
//     return '$minutes:$seconds';
//   }

//   void _seekForward() {
//     final newPosition = _currentPosition + const Duration(seconds: 10);
//     _controller
//         .seekTo(newPosition > _totalDuration ? _totalDuration : newPosition);
//   }

//   void _seekBackward() {
//     final newPosition = _currentPosition - const Duration(seconds: 10);
//     _controller
//         .seekTo(newPosition < Duration.zero ? Duration.zero : newPosition);
//   }

//   void _toggleMute() {
//     setState(() {
//       _controller.setVolume(_controller.value.volume == 0 ? 1 : 0);
//     });
//   }

//   void _setPlaybackSpeed(double speed) {
//     setState(() {
//       _controller.setPlaybackSpeed(speed);
//     });
//   }

//   void _togglePlayPause() {
//     setState(() {
//       if (_controller.value.isPlaying) {
//         _controller.pause();
//         _showControls = true;
//       } else {
//         _controller.play();
//         Future.delayed(const Duration(seconds: 3), () {
//           if (mounted && _controller.value.isPlaying) {
//             setState(() => _showControls = false);
//           }
//         });
//       }
//     });
//   }

//   void _toggleFullScreen() {
//     setState(() {
//       _isFullScreen = !_isFullScreen;
//     });

//     if (_isFullScreen) {
//       SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
//     } else {
//       SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         setState(() => _showControls = !_showControls);
//         if (_showControls) {
//           Future.delayed(const Duration(seconds: 3), () {
//             if (mounted && _showControls && _controller.value.isPlaying) {
//               setState(() => _showControls = false);
//             }
//           });
//         }
//       },
//       child: Card(
//         margin: EdgeInsets.all(8.w),
//         elevation: 4,
//         shape:
//             RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
//         child: Container(
//           width: double.infinity,
//           height: _isFullScreen
//               ? MediaQuery.of(context).size.height
//               : MediaQuery.of(context).size.width * 9 / 16,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(12.r),
//             color: Colors.black,
//           ),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(12.r),
//             child: Stack(
//               children: [
//                 // Video
//                 if (_isInitialized)
//                   Center(
//                     child: AspectRatio(
//                       aspectRatio: _controller.value.aspectRatio,
//                       child: VideoPlayer(_controller),
//                     ),
//                   )
//                 else
//                   const Center(
//                       child: CircularProgressIndicator(color: Colors.white)),

//                 // Overlay controls
//                 if (_showControls || !_controller.value.isPlaying)
//                   Positioned.fill(
//                     child: Container(
//                       color: Colors.black38,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           // Top bar
//                           Padding(
//                             padding: EdgeInsets.all(8.w),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 IconButton(
//                                   icon: Icon(Icons.arrow_back,
//                                       color: Colors.white, size: 24.sp),
//                                   onPressed: _toggleFullScreen,
//                                 ),
//                                 Expanded(
//                                   child: Text(
//                                     'Workout Video',
//                                     style: TextStyle(
//                                         color: Colors.white, fontSize: 14.sp),
//                                     textAlign: TextAlign.center,
//                                   ),
//                                 ),
//                                 IconButton(
//                                   icon: Icon(
//                                     _isFullScreen
//                                         ? Icons.fullscreen_exit
//                                         : Icons.fullscreen,
//                                     color: Colors.white,
//                                     size: 24.sp,
//                                   ),
//                                   onPressed: _toggleFullScreen,
//                                 ),
//                               ],
//                             ),
//                           ),

//                           // Center controls
//                           if (_showControls)
//                             Expanded(
//                               child: Center(
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceEvenly,
//                                   children: [
//                                     IconButton(
//                                       icon: Icon(Icons.replay_10,
//                                           color: Colors.white, size: 32.sp),
//                                       onPressed: _seekBackward,
//                                     ),
//                                     IconButton(
//                                       icon: Icon(
//                                         _controller.value.isPlaying
//                                             ? Icons.pause_circle
//                                             : Icons.play_circle,
//                                         color: Colors.white,
//                                         size: 60.sp,
//                                       ),
//                                       onPressed: _togglePlayPause,
//                                     ),
//                                     IconButton(
//                                       icon: Icon(Icons.forward_10,
//                                           color: Colors.white, size: 32.sp),
//                                       onPressed: _seekForward,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),

//                           // Bottom controls
//                           Padding(
//                             padding: EdgeInsets.all(8.w),
//                             child: Column(
//                               children: [
//                                 VideoProgressIndicator(
//                                   _controller,
//                                   allowScrubbing: true,
//                                   padding: EdgeInsets.symmetric(vertical: 4.h),
//                                   colors: const VideoProgressColors(
//                                     playedColor: Colors.red,
//                                     bufferedColor: Colors.white38,
//                                     backgroundColor: Colors.white24,
//                                   ),
//                                 ),
//                                 SizedBox(height: 4.h),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       "${_formatDuration(_currentPosition)} / ${_formatDuration(_totalDuration)}",
//                                       style: TextStyle(
//                                           color: Colors.white, fontSize: 12.sp),
//                                     ),
//                                     Row(
//                                       children: [
//                                         PopupMenuButton<double>(
//                                           icon: Icon(Icons.speed,
//                                               color: Colors.white, size: 20.sp),
//                                           itemBuilder: (context) => [
//                                             const PopupMenuItem(
//                                                 value: 0.5,
//                                                 child: Text('0.5x')),
//                                             const PopupMenuItem(
//                                                 value: 0.75,
//                                                 child: Text('0.75x')),
//                                             const PopupMenuItem(
//                                                 value: 1.0,
//                                                 child: Text('Normal')),
//                                             const PopupMenuItem(
//                                                 value: 1.25,
//                                                 child: Text('1.25x')),
//                                             const PopupMenuItem(
//                                                 value: 1.5,
//                                                 child: Text('1.5x')),
//                                             const PopupMenuItem(
//                                                 value: 2.0, child: Text('2x')),
//                                           ],
//                                           onSelected: _setPlaybackSpeed,
//                                         ),
//                                         IconButton(
//                                           icon: Icon(
//                                             _controller.value.volume == 0
//                                                 ? Icons.volume_off
//                                                 : Icons.volume_up,
//                                             color: Colors.white,
//                                             size: 20.sp,
//                                           ),
//                                           onPressed: _toggleMute,
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),

//                 // Central play button
//                 if (!_showControls &&
//                     _isInitialized &&
//                     !_controller.value.isPlaying)
//                   Positioned.fill(
//                     child: Center(
//                       child: Container(
//                         width: 40.w,
//                         height: 40.w,
//                         decoration: BoxDecoration(
//                           color: Colors.black45,
//                           shape: BoxShape.circle,
//                         ),
//                         child: Material(
//                           color: Colors.transparent,
//                           child: InkWell(
//                             borderRadius: BorderRadius.circular(20.r),
//                             onTap: _togglePlayPause,
//                             child: Center(
//                               child: Icon(
//                                 Icons.play_arrow,
//                                 color: Colors.white,
//                                 size: 36.sp,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

///video player : v.0.0.8
// Youtube video player : fixed version v1.0.0
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String url;
  const VideoPlayerWidget({super.key, required this.url});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;
  bool _showControls = false;
  bool _isFullScreen = false;
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    _initVideo(widget.url);
  }

  @override
  void didUpdateWidget(VideoPlayerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.url != widget.url) {
      _controller.removeListener(_updatePosition);
      _controller.dispose();
      _initVideo(widget.url);
    }
  }

  void _initVideo(String url) {
    _controller = VideoPlayerController.networkUrl(Uri.parse(url))
      ..initialize().then((_) {
        if (mounted) {
          setState(() {
            _isInitialized = true;
            _totalDuration = _controller.value.duration;
          });
        }
      });
    _controller.addListener(_updatePosition);
  }

  void _updatePosition() {
    if (mounted && _controller.value.isInitialized) {
      setState(() {
        _currentPosition = _controller.value.position;
        _totalDuration = _controller.value.duration;
      });
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_updatePosition);
    _controller.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  void _seekForward() {
    final newPosition = _currentPosition + const Duration(seconds: 10);
    _controller
        .seekTo(newPosition > _totalDuration ? _totalDuration : newPosition);
  }

  void _seekBackward() {
    final newPosition = _currentPosition - const Duration(seconds: 10);
    _controller
        .seekTo(newPosition < Duration.zero ? Duration.zero : newPosition);
  }

  void _toggleMute() {
    setState(() {
      _controller.setVolume(_controller.value.volume == 0 ? 1 : 0);
    });
  }

  void _setPlaybackSpeed(double speed) {
    setState(() {
      _controller.setPlaybackSpeed(speed);
    });
  }

  void _togglePlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
        _showControls = true;
      } else {
        _controller.play();
        Future.delayed(const Duration(seconds: 3), () {
          if (mounted && _controller.value.isPlaying) {
            setState(() => _showControls = false);
          }
        });
      }
    });
  }

  void _toggleFullScreen() {
    setState(() {
      _isFullScreen = !_isFullScreen;
    });
    if (_isFullScreen) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() => _showControls = !_showControls);
        if (_showControls) {
          Future.delayed(const Duration(seconds: 3), () {
            if (mounted && _showControls && _controller.value.isPlaying) {
              setState(() => _showControls = false);
            }
          });
        }
      },
      child: Card(
        margin: EdgeInsets.all(8.w),
        elevation: 4,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        child: Container(
          width: double.infinity,
          height: _isFullScreen
              ? MediaQuery.of(context).size.height
              : MediaQuery.of(context).size.width * 9 / 16,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: Colors.black,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Stack(
              children: [
                // Video
                if (_isInitialized)
                  Center(
                    child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    ),
                  )
                else
                  const Center(
                      child: CircularProgressIndicator(color: Colors.white)),

                // Overlay controls
                if (_showControls || !_controller.value.isPlaying)
                  Positioned.fill(
                    child: Container(
                      color: Colors.black38,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Top bar
                          Padding(
                            padding: EdgeInsets.all(8.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.arrow_back,
                                      color: Colors.white, size: 24.sp),
                                  onPressed: _toggleFullScreen,
                                ),
                                Expanded(
                                  child: Text(
                                    'Workout Video',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14.sp),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    _isFullScreen
                                        ? Icons.fullscreen_exit
                                        : Icons.fullscreen,
                                    color: Colors.white,
                                    size: 24.sp,
                                  ),
                                  onPressed: _toggleFullScreen,
                                ),
                              ],
                            ),
                          ),

                          // Center controls
                          if (_showControls)
                            Expanded(
                              child: Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.replay_10,
                                          color: Colors.white, size: 32.sp),
                                      onPressed: _seekBackward,
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        _controller.value.isPlaying
                                            ? Icons.pause_circle
                                            : Icons.play_circle,
                                        color: Colors.white,
                                        size: 60.sp,
                                      ),
                                      onPressed: _togglePlayPause,
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.forward_10,
                                          color: Colors.white, size: 32.sp),
                                      onPressed: _seekForward,
                                    ),
                                  ],
                                ),
                              ),
                            ),

                          // Bottom controls
                          Padding(
                            padding: EdgeInsets.all(8.w),
                            child: Column(
                              children: [
                                VideoProgressIndicator(
                                  _controller,
                                  allowScrubbing: true,
                                  padding: EdgeInsets.symmetric(vertical: 4.h),
                                  colors: const VideoProgressColors(
                                    playedColor: Colors.red,
                                    bufferedColor: Colors.white38,
                                    backgroundColor: Colors.white24,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${_formatDuration(_currentPosition)} / ${_formatDuration(_totalDuration)}",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12.sp),
                                    ),
                                    Row(
                                      children: [
                                        PopupMenuButton<double>(
                                          icon: Icon(Icons.speed,
                                              color: Colors.white, size: 20.sp),
                                          itemBuilder: (context) => const [
                                            PopupMenuItem(
                                                value: 0.5,
                                                child: Text('0.5x')),
                                            PopupMenuItem(
                                                value: 0.75,
                                                child: Text('0.75x')),
                                            PopupMenuItem(
                                                value: 1.0,
                                                child: Text('Normal')),
                                            PopupMenuItem(
                                                value: 1.25,
                                                child: Text('1.25x')),
                                            PopupMenuItem(
                                                value: 1.5,
                                                child: Text('1.5x')),
                                            PopupMenuItem(
                                                value: 2.0, child: Text('2x')),
                                          ],
                                          onSelected: _setPlaybackSpeed,
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            _controller.value.volume == 0
                                                ? Icons.volume_off
                                                : Icons.volume_up,
                                            color: Colors.white,
                                            size: 20.sp,
                                          ),
                                          onPressed: _toggleMute,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                // Central play button
                if (!_showControls &&
                    _isInitialized &&
                    !_controller.value.isPlaying)
                  Positioned.fill(
                    child: Center(
                      child: Container(
                        width: 40.w,
                        height: 40.w,
                        decoration: const BoxDecoration(
                          color: Colors.black45,
                          shape: BoxShape.circle,
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20.r),
                            onTap: _togglePlayPause,
                            child: Center(
                              child: Icon(Icons.play_arrow,
                                  color: Colors.white, size: 36.sp),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
