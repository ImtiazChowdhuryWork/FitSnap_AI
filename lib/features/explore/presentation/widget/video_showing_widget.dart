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

///Inhanced version : 0.2

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
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(12),
//           child: Stack(
//             alignment: Alignment.center,
//             children: [
//               // Video player with proper containment
//               if (_isInitialized)
//                 Center(
//                   child: AspectRatio(
//                     aspectRatio: _controller.value.aspectRatio,
//                     child: Container(
//                       color: Colors.black,
//                       child: VideoPlayer(_controller),
//                     ),
//                   ),
//                 )
//               else
//                 const Center(
//                   child: CircularProgressIndicator(
//                     color: Colors.white,
//                   ),
//                 ),

//               // Play/Pause button overlay
//               if (_isInitialized)
//                 Positioned.fill(
//                   child: AnimatedOpacity(
//                     opacity: _controller.value.isPlaying ? 0.0 : 1.0,
//                     duration: const Duration(milliseconds: 300),
//                     child: Container(
//                       color: Colors.black38,
//                       child: Center(
//                         child: IconButton(
//                           icon: Icon(
//                             _controller.value.isPlaying
//                                 ? Icons.pause
//                                 : Icons.play_arrow,
//                             size: 48,
//                             color: Colors.white,
//                           ),
//                           onPressed: _togglePlayPause,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),

//               // Video progress indicator at bottom
//               if (_isInitialized)
//                 Positioned(
//                   bottom: 0,
//                   left: 0,
//                   right: 0,
//                   child: Container(
//                     color: Colors.black54,
//                     child: VideoProgressIndicator(
//                       _controller,
//                       allowScrubbing: true,
//                       colors: const VideoProgressColors(
//                         playedColor: Colors.red,
//                         bufferedColor: Colors.grey,
//                         backgroundColor: Colors.grey,
//                       ),
//                     ),
//                   ),
//                 ),

//               // Loading overlay
//               if (!_isInitialized)
//                 const Positioned.fill(
//                   child: Center(
//                     child: CircularProgressIndicator(
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//             ],
//           ),
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

///Inhanced Version : 0.3 : DeepSeek Version
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
//     super.dispose();
//   }

//   String _formatDuration(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, '0');
//     final hours = twoDigits(duration.inHours);
//     final minutes = twoDigits(duration.inMinutes.remainder(60));
//     final seconds = twoDigits(duration.inSeconds.remainder(60));

//     return duration.inHours > 0
//         ? '$hours:$minutes:$seconds'
//         : '$minutes:$seconds';
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

//   void _toggleFullScreen() {
//     setState(() {
//       _isFullScreen = !_isFullScreen;
//     });
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

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           _showControls = !_showControls;
//         });

//         // Auto hide controls after 3 seconds
//         if (_showControls) {
//           Future.delayed(const Duration(seconds: 3), () {
//             if (mounted && _showControls && _controller.value.isPlaying) {
//               setState(() {
//                 _showControls = false;
//               });
//             }
//           });
//         }
//       },
//       child: Card(
//         margin: const EdgeInsets.all(8),
//         elevation: 4,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         child: Container(
//           width: double.infinity,
//           height: _isFullScreen ? MediaQuery.of(context).size.height : 200,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(12),
//             color: Colors.black,
//           ),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(12),
//             child: Stack(
//               alignment: Alignment.center,
//               children: [
//                 // Video player
//                 if (_isInitialized)
//                   Center(
//                     child: AspectRatio(
//                       aspectRatio: _controller.value.aspectRatio,
//                       child: Container(
//                         color: Colors.black,
//                         child: VideoPlayer(_controller),
//                       ),
//                     ),
//                   )
//                 else
//                   const Center(
//                     child: CircularProgressIndicator(color: Colors.white),
//                   ),

//                 // Controls overlay
//                 if (_showControls || !_controller.value.isPlaying)
//                   Positioned.fill(
//                     child: Container(
//                       color: Colors.black38,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           // Top controls
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 // Back button (for full screen)
//                                 if (_isFullScreen)
//                                   IconButton(
//                                     icon: const Icon(Icons.arrow_back,
//                                         color: Colors.white),
//                                     onPressed: _toggleFullScreen,
//                                   )
//                                 else
//                                   const SizedBox(width: 48),

//                                 // Video title or empty space
//                                 const Expanded(
//                                   child: Text(
//                                     'Workout Video',
//                                     style: TextStyle(color: Colors.white),
//                                     textAlign: TextAlign.center,
//                                   ),
//                                 ),

//                                 // Full screen button
//                                 IconButton(
//                                   icon: Icon(
//                                     _isFullScreen
//                                         ? Icons.fullscreen_exit
//                                         : Icons.fullscreen,
//                                     color: Colors.white,
//                                   ),
//                                   onPressed: _toggleFullScreen,
//                                 ),
//                               ],
//                             ),
//                           ),

//                           // Center controls (Play/Pause, Seek)
//                           Expanded(
//                             child: Center(
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   // Seek backward
//                                   IconButton(
//                                     icon: const Icon(Icons.replay_10,
//                                         color: Colors.white, size: 32),
//                                     onPressed: _seekBackward,
//                                   ),

//                                   // Play/Pause
//                                   IconButton(
//                                     icon: Icon(
//                                       _controller.value.isPlaying
//                                           ? Icons.pause_circle
//                                           : Icons.play_circle,
//                                       color: Colors.white,
//                                       size: 48,
//                                     ),
//                                     onPressed: _togglePlayPause,
//                                   ),

//                                   // Seek forward
//                                   IconButton(
//                                     icon: const Icon(Icons.forward_10,
//                                         color: Colors.white, size: 32),
//                                     onPressed: _seekForward,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),

//                           // Bottom controls
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Column(
//                               children: [
//                                 // Progress bar
//                                 VideoProgressIndicator(
//                                   _controller,
//                                   allowScrubbing: true,
//                                   colors: const VideoProgressColors(
//                                     playedColor: Colors.red,
//                                     bufferedColor: Colors.grey,
//                                     backgroundColor: Colors.white54,
//                                   ),
//                                 ),

//                                 const SizedBox(height: 8),

//                                 // Bottom row controls
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     // Current time
//                                     Text(
//                                       _formatDuration(_currentPosition),
//                                       style:
//                                           const TextStyle(color: Colors.white),
//                                     ),

//                                     // Additional controls
//                                     Row(
//                                       children: [
//                                         // Playback speed
//                                         PopupMenuButton<double>(
//                                           icon: const Icon(Icons.speed,
//                                               color: Colors.white),
//                                           itemBuilder: (context) => [
//                                             PopupMenuItem(
//                                                 value: 0.5,
//                                                 child: Text('0.5x')),
//                                             PopupMenuItem(
//                                                 value: 0.75,
//                                                 child: Text('0.75x')),
//                                             PopupMenuItem(
//                                                 value: 1.0,
//                                                 child: Text('1.0x')),
//                                             PopupMenuItem(
//                                                 value: 1.25,
//                                                 child: Text('1.25x')),
//                                             PopupMenuItem(
//                                                 value: 1.5,
//                                                 child: Text('1.5x')),
//                                             PopupMenuItem(
//                                                 value: 2.0,
//                                                 child: Text('2.0x')),
//                                           ],
//                                           onSelected: _setPlaybackSpeed,
//                                         ),

//                                         const SizedBox(width: 8),

//                                         // Mute/Unmute
//                                         IconButton(
//                                           icon: Icon(
//                                             _controller.value.volume == 0
//                                                 ? Icons.volume_off
//                                                 : Icons.volume_up,
//                                             color: Colors.white,
//                                           ),
//                                           onPressed: _toggleMute,
//                                         ),
//                                       ],
//                                     ),

//                                     // Total duration
//                                     Text(
//                                       _formatDuration(_totalDuration),
//                                       style:
//                                           const TextStyle(color: Colors.white),
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

//                 // Loading indicator
//                 if (!_isInitialized)
//                   const Positioned.fill(
//                     child: Center(
//                       child: CircularProgressIndicator(color: Colors.white),
//                     ),
//                   ),

//                 // Play button (always visible when paused and controls are hidden)
//                 if (!_showControls &&
//                     _isInitialized &&
//                     !_controller.value.isPlaying)
//                   Positioned.fill(
//                     child: Align(
//                       alignment: Alignment.center,
//                       child: IconButton(
//                         icon: const Icon(Icons.play_arrow,
//                             size: 48, color: Colors.white),
//                         onPressed: _togglePlayPause,
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

//   void _togglePlayPause() {
//     setState(() {
//       if (_controller.value.isPlaying) {
//         _controller.pause();
//         _showControls = true; // Show controls when pausing
//       } else {
//         _controller.play();
//         // Auto-hide controls after 3 seconds when playing
//         Future.delayed(const Duration(seconds: 3), () {
//           if (mounted && _controller.value.isPlaying) {
//             setState(() {
//               _showControls = false;
//             });
//           }
//         });
//       }
//     });
//   }
// }

///Inhansive version : DeppSeek version : 0.4 : youtube player version : 0.1

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
//   bool _showControls = true;
//   bool _isFullScreen = false;
//   Duration _currentPosition = Duration.zero;
//   Duration _totalDuration = Duration.zero;
//   bool _isBuffering = false;
//   double _playbackSpeed = 1.0;

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

//     _controller.addListener(_updatePlayerState);
//   }

//   void _updatePlayerState() {
//     if (mounted) {
//       setState(() {
//         _currentPosition = _controller.value.position;
//         _totalDuration = _controller.value.duration;
//         _isBuffering = _controller.value.isBuffering;

//         // Auto-show controls when buffering
//         if (_isBuffering) {
//           _showControls = true;
//         }
//       });
//     }
//   }

//   @override
//   void dispose() {
//     _controller.removeListener(_updatePlayerState);
//     _controller.dispose();
//     super.dispose();
//   }

//   String _formatDuration(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, '0');
//     final hours = twoDigits(duration.inHours);
//     final minutes = twoDigits(duration.inMinutes.remainder(60));
//     final seconds = twoDigits(duration.inSeconds.remainder(60));

//     return duration.inHours > 0
//         ? '$hours:$minutes:$seconds'
//         : '$minutes:$seconds';
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

//   void _toggleFullScreen() {
//     setState(() {
//       _isFullScreen = !_isFullScreen;
//       _showControls = true; // Show controls when toggling fullscreen
//     });

//     // Auto-hide controls after 3 seconds
//     if (_isFullScreen) {
//       Future.delayed(const Duration(seconds: 3), () {
//         if (mounted && _controller.value.isPlaying && !_isBuffering) {
//           setState(() {
//             _showControls = false;
//           });
//         }
//       });
//     }
//   }

//   void _toggleMute() {
//     setState(() {
//       _controller.setVolume(_controller.value.volume == 0 ? 1 : 0);
//     });
//   }

//   void _setPlaybackSpeed(double speed) {
//     setState(() {
//       _playbackSpeed = speed;
//       _controller.setPlaybackSpeed(speed);
//     });
//   }

//   void _seekToPosition(double value) {
//     final position = value * _totalDuration.inMilliseconds;
//     _controller.seekTo(Duration(milliseconds: position.round()));
//   }

//   void _showControlsTemporarily() {
//     setState(() {
//       _showControls = true;
//     });

//     Future.delayed(const Duration(seconds: 3), () {
//       if (mounted && _controller.value.isPlaying && !_isBuffering) {
//         setState(() {
//           _showControls = false;
//         });
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           _showControls = !_showControls;
//         });

//         if (_showControls) {
//           _showControlsTemporarily();
//         }
//       },
//       child: Container(
//         width: double.infinity,
//         height: _isFullScreen ? MediaQuery.of(context).size.height : 220,
//         decoration: BoxDecoration(
//           color: Colors.black,
//           borderRadius:
//               _isFullScreen ? BorderRadius.zero : BorderRadius.circular(12),
//         ),
//         child: ClipRRect(
//           borderRadius:
//               _isFullScreen ? BorderRadius.zero : BorderRadius.circular(12),
//           child: Stack(
//             fit: StackFit.expand,
//             children: [
//               // Video player
//               if (_isInitialized)
//                 Center(
//                   child: AspectRatio(
//                     aspectRatio: _controller.value.aspectRatio,
//                     child: VideoPlayer(_controller),
//                   ),
//                 )
//               else
//                 const Center(
//                   child: CircularProgressIndicator(color: Colors.white),
//                 ),

//               // Buffering indicator
//               if (_isBuffering)
//                 const Center(
//                   child: CircularProgressIndicator(
//                     color: Colors.red,
//                     strokeWidth: 3,
//                   ),
//                 ),

//               // Controls overlay with fade animation
//               AnimatedOpacity(
//                 opacity: _showControls ? 1.0 : 0.0,
//                 duration: const Duration(milliseconds: 200),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       begin: Alignment.topCenter,
//                       end: Alignment.bottomCenter,
//                       colors: [
//                         Colors.black.withOpacity(0.6),
//                         Colors.transparent,
//                         Colors.transparent,
//                         Colors.black.withOpacity(0.8),
//                       ],
//                     ),
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       // Top controls
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 16, vertical: 8),
//                         child: Row(
//                           children: [
//                             if (_isFullScreen)
//                               IconButton(
//                                 icon: const Icon(Icons.arrow_back,
//                                     color: Colors.white, size: 24),
//                                 onPressed: _toggleFullScreen,
//                               ),
//                             const Spacer(),
//                             IconButton(
//                               icon: Icon(
//                                 Icons.fullscreen,
//                                 color: Colors.white,
//                                 size: 24,
//                               ),
//                               onPressed: _toggleFullScreen,
//                             ),
//                           ],
//                         ),
//                       ),

//                       // Center play controls
//                       Expanded(
//                         child: Center(
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               // Seek backward
//                               IconButton(
//                                 icon: const Icon(Icons.replay_10,
//                                     color: Colors.white, size: 32),
//                                 onPressed: _seekBackward,
//                               ),

//                               // Play/Pause
//                               Container(
//                                 decoration: BoxDecoration(
//                                   color: Colors.black54,
//                                   shape: BoxShape.circle,
//                                 ),
//                                 child: IconButton(
//                                   icon: Icon(
//                                     _controller.value.isPlaying
//                                         ? Icons.pause
//                                         : Icons.play_arrow,
//                                     color: Colors.white,
//                                     size: 36,
//                                   ),
//                                   onPressed: _togglePlayPause,
//                                 ),
//                               ),

//                               // Seek forward
//                               IconButton(
//                                 icon: const Icon(Icons.forward_10,
//                                     color: Colors.white, size: 32),
//                                 onPressed: _seekForward,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),

//                       // Bottom controls
//                       Container(
//                         padding: const EdgeInsets.all(16),
//                         child: Column(
//                           children: [
//                             // Custom progress bar
//                             SliderTheme(
//                               data: SliderThemeData(
//                                 trackHeight: 3,
//                                 thumbShape: RoundSliderThumbShape(
//                                     enabledThumbRadius: 8),
//                                 overlayShape:
//                                     RoundSliderOverlayShape(overlayRadius: 14),
//                                 activeTrackColor: Colors.red,
//                                 inactiveTrackColor:
//                                     Colors.white.withOpacity(0.3),
//                                 thumbColor: Colors.red,
//                               ),
//                               child: Slider(
//                                 value: _totalDuration.inMilliseconds > 0
//                                     ? _currentPosition.inMilliseconds /
//                                         _totalDuration.inMilliseconds
//                                     : 0.0,
//                                 onChanged: _seekToPosition,
//                                 onChangeEnd: _seekToPosition,
//                               ),
//                             ),

//                             const SizedBox(height: 8),

//                             // Bottom row controls
//                             Row(
//                               children: [
//                                 // Current time
//                                 Text(
//                                   _formatDuration(_currentPosition),
//                                   style: const TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),

//                                 const Spacer(),

//                                 // Playback speed indicator
//                                 GestureDetector(
//                                   onTap: () {
//                                     showModalBottomSheet(
//                                       context: context,
//                                       builder: (context) => Container(
//                                         padding: const EdgeInsets.all(16),
//                                         child: Column(
//                                           mainAxisSize: MainAxisSize.min,
//                                           children: [
//                                             const Text(
//                                               'Playback Speed',
//                                               style: TextStyle(
//                                                   fontSize: 18,
//                                                   fontWeight: FontWeight.bold),
//                                             ),
//                                             const SizedBox(height: 16),
//                                             Wrap(
//                                               spacing: 8,
//                                               children: [
//                                                 0.25,
//                                                 0.5,
//                                                 0.75,
//                                                 1.0,
//                                                 1.25,
//                                                 1.5,
//                                                 1.75,
//                                                 2.0
//                                               ].map((speed) {
//                                                 return ChoiceChip(
//                                                   label: Text('${speed}x'),
//                                                   selected:
//                                                       _playbackSpeed == speed,
//                                                   onSelected: (_) =>
//                                                       _setPlaybackSpeed(speed),
//                                                 );
//                                               }).toList(),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                   child: Container(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 8, vertical: 4),
//                                     decoration: BoxDecoration(
//                                       color: Colors.white.withOpacity(0.2),
//                                       borderRadius: BorderRadius.circular(4),
//                                     ),
//                                     child: Text(
//                                       '${_playbackSpeed}x',
//                                       style: const TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ),
//                                   ),
//                                 ),

//                                 const SizedBox(width: 12),

//                                 // Volume control
//                                 IconButton(
//                                   icon: Icon(
//                                     _controller.value.volume == 0
//                                         ? Icons.volume_off
//                                         : Icons.volume_up,
//                                     color: Colors.white,
//                                     size: 20,
//                                   ),
//                                   onPressed: _toggleMute,
//                                 ),

//                                 const SizedBox(width: 8),

//                                 // Total duration
//                                 Text(
//                                   _formatDuration(_totalDuration),
//                                   style: const TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               // Play button overlay when paused and controls are hidden
//               if (!_showControls &&
//                   _isInitialized &&
//                   !_controller.value.isPlaying)
//                 Positioned.fill(
//                   child: GestureDetector(
//                     onTap: _showControlsTemporarily,
//                     child: Container(
//                       color: Colors.black38,
//                       child: const Center(
//                         child: Icon(
//                           Icons.play_circle_filled,
//                           color: Colors.white,
//                           size: 64,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),

//               // Loading indicator
//               if (!_isInitialized)
//                 const Center(
//                   child: CircularProgressIndicator(
//                     color: Colors.red,
//                     strokeWidth: 3,
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _togglePlayPause() {
//     setState(() {
//       if (_controller.value.isPlaying) {
//         _controller.pause();
//         _showControls = true;
//       } else {
//         _controller.play();
//         _showControlsTemporarily();
//       }
//     });
//   }
// }

///Youturbe Player : Version : 0.4
///Current version Problem : Threre are currently two playing buttons showing by layer.

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
//     super.dispose();
//   }

//   String _formatDuration(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, '0');
//     final hours = twoDigits(duration.inHours);
//     final minutes = twoDigits(duration.inMinutes.remainder(60));
//     final seconds = twoDigits(duration.inSeconds.remainder(60));
//     return duration.inHours > 0
//         ? '$hours:$minutes:$seconds'
//         : '$minutes:$seconds';
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

//   void _toggleFullScreen() {
//     setState(() {
//       _isFullScreen = !_isFullScreen;
//     });
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
//             setState(() {
//               _showControls = false;
//             });
//           }
//         });
//       }
//     });
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
//         margin: const EdgeInsets.all(8),
//         elevation: 4,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         child: Container(
//           width: double.infinity,
//           height: _isFullScreen ? MediaQuery.of(context).size.height : 200,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(12),
//             color: Colors.black,
//           ),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(12),
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
//                             padding: const EdgeInsets.all(8.0),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 if (_isFullScreen)
//                                   IconButton(
//                                     icon: const Icon(Icons.arrow_back,
//                                         color: Colors.white),
//                                     onPressed: _toggleFullScreen,
//                                   )
//                                 else
//                                   const SizedBox(width: 48),
//                                 const Expanded(
//                                   child: Text(
//                                     'Workout Video',
//                                     style: TextStyle(color: Colors.white),
//                                     textAlign: TextAlign.center,
//                                   ),
//                                 ),
//                                 IconButton(
//                                   icon: Icon(
//                                     _isFullScreen
//                                         ? Icons.fullscreen_exit
//                                         : Icons.fullscreen,
//                                     color: Colors.white,
//                                   ),
//                                   onPressed: _toggleFullScreen,
//                                 ),
//                               ],
//                             ),
//                           ),

//                           // Center controls
//                           Expanded(
//                             child: Center(
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   IconButton(
//                                     icon: const Icon(Icons.replay_10,
//                                         color: Colors.white, size: 32),
//                                     onPressed: _seekBackward,
//                                   ),
//                                   IconButton(
//                                     icon: Icon(
//                                       _controller.value.isPlaying
//                                           ? Icons.pause_circle
//                                           : Icons.play_circle,
//                                       color: Colors.white,
//                                       size: 60,
//                                     ),
//                                     onPressed: _togglePlayPause,
//                                   ),
//                                   IconButton(
//                                     icon: const Icon(Icons.forward_10,
//                                         color: Colors.white, size: 32),
//                                     onPressed: _seekForward,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),

//                           // Bottom controls
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Column(
//                               children: [
//                                 // Progress bar
//                                 VideoProgressIndicator(
//                                   _controller,
//                                   allowScrubbing: true,
//                                   padding:
//                                       const EdgeInsets.symmetric(vertical: 4),
//                                   colors: const VideoProgressColors(
//                                     playedColor: Colors.red,
//                                     bufferedColor: Colors.white38,
//                                     backgroundColor: Colors.white24,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 2),
//                                 // Time & right controls
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       "${_formatDuration(_currentPosition)} / ${_formatDuration(_totalDuration)}",
//                                       style: const TextStyle(
//                                           color: Colors.white, fontSize: 12),
//                                     ),
//                                     Row(
//                                       children: [
//                                         // Playback speed
//                                         PopupMenuButton<double>(
//                                           icon: const Icon(Icons.speed,
//                                               color: Colors.white),
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

//                 // Central play button when hidden
//                 if (!_showControls &&
//                     _isInitialized &&
//                     !_controller.value.isPlaying)
//                   Positioned.fill(
//                     child: Align(
//                       alignment: Alignment.center,
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: Colors.black45,
//                           shape: BoxShape.circle,
//                         ),
//                         child: IconButton(
//                           icon: const Icon(Icons.play_arrow,
//                               color: Colors.white, size: 60),
//                           onPressed: _togglePlayPause,
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

///Youtube Player version : 0.5
/// In this version circle behind the playbutton stays staticly when I scroll down
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
//     super.dispose();
//   }

//   String _formatDuration(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, '0');
//     final hours = twoDigits(duration.inHours);
//     final minutes = twoDigits(duration.inMinutes.remainder(60));
//     final seconds = twoDigits(duration.inSeconds.remainder(60));
//     return duration.inHours > 0
//         ? '$hours:$minutes:$seconds'
//         : '$minutes:$seconds';
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

//   void _toggleFullScreen() {
//     setState(() {
//       _isFullScreen = !_isFullScreen;
//     });
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
//             setState(() {
//               _showControls = false;
//             });
//           }
//         });
//       }
//     });
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
//         margin: const EdgeInsets.all(8),
//         elevation: 4,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         child: Container(
//           width: double.infinity,
//           height: _isFullScreen ? MediaQuery.of(context).size.height : 200,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(12),
//             color: Colors.black,
//           ),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(12),
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
//                             padding: const EdgeInsets.all(8.0),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 if (_isFullScreen)
//                                   IconButton(
//                                     icon: const Icon(Icons.arrow_back,
//                                         color: Colors.white),
//                                     onPressed: _toggleFullScreen,
//                                   )
//                                 else
//                                   const SizedBox(width: 48),
//                                 const Expanded(
//                                   child: Text(
//                                     'Workout Video',
//                                     style: TextStyle(color: Colors.white),
//                                     textAlign: TextAlign.center,
//                                   ),
//                                 ),
//                                 IconButton(
//                                   icon: Icon(
//                                     _isFullScreen
//                                         ? Icons.fullscreen_exit
//                                         : Icons.fullscreen,
//                                     color: Colors.white,
//                                   ),
//                                   onPressed: _toggleFullScreen,
//                                 ),
//                               ],
//                             ),
//                           ),

//                           // Center controls (show only when controls are visible)
//                           if (_showControls)
//                             Expanded(
//                               child: Center(
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceEvenly,
//                                   children: [
//                                     IconButton(
//                                       icon: const Icon(Icons.replay_10,
//                                           color: Colors.white, size: 32),
//                                       onPressed: _seekBackward,
//                                     ),
//                                     IconButton(
//                                       icon: Icon(
//                                         _controller.value.isPlaying
//                                             ? Icons.pause_circle
//                                             : Icons.play_circle,
//                                         color: Colors.white,
//                                         size: 60,
//                                       ),
//                                       onPressed: _togglePlayPause,
//                                     ),
//                                     IconButton(
//                                       icon: const Icon(Icons.forward_10,
//                                           color: Colors.white, size: 32),
//                                       onPressed: _seekForward,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),

//                           // Bottom controls
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Column(
//                               children: [
//                                 // Progress bar
//                                 VideoProgressIndicator(
//                                   _controller,
//                                   allowScrubbing: true,
//                                   padding:
//                                       const EdgeInsets.symmetric(vertical: 4),
//                                   colors: const VideoProgressColors(
//                                     playedColor: Colors.red,
//                                     bufferedColor: Colors.white38,
//                                     backgroundColor: Colors.white24,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 4),
//                                 // Time & right controls
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       "${_formatDuration(_currentPosition)} / ${_formatDuration(_totalDuration)}",
//                                       style: const TextStyle(
//                                           color: Colors.white, fontSize: 12),
//                                     ),
//                                     Row(
//                                       children: [
//                                         // Playback speed
//                                         PopupMenuButton<double>(
//                                           icon: const Icon(Icons.speed,
//                                               color: Colors.white),
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

//                 // Central play button when controls are hidden
//                 if (!_showControls &&
//                     _isInitialized &&
//                     !_controller.value.isPlaying)
//                   Positioned.fill(
//                     child: Align(
//                       alignment: Alignment.center,
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: Colors.black45,
//                           shape: BoxShape.circle,
//                         ),
//                         child: IconButton(
//                           icon: const Icon(Icons.play_arrow,
//                               color: Colors.white, size: 60),
//                           onPressed: _togglePlayPause,
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

///Youtube : v0.6
///In this version : transparent background circle shows behind the play button
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
//     super.dispose();
//   }

//   String _formatDuration(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, '0');
//     final hours = twoDigits(duration.inHours);
//     final minutes = twoDigits(duration.inMinutes.remainder(60));
//     final seconds = twoDigits(duration.inSeconds.remainder(60));
//     return duration.inHours > 0
//         ? '$hours:$minutes:$seconds'
//         : '$minutes:$seconds';
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

//   void _toggleFullScreen() {
//     setState(() {
//       _isFullScreen = !_isFullScreen;
//     });
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
//             setState(() {
//               _showControls = false;
//             });
//           }
//         });
//       }
//     });
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
//         margin: const EdgeInsets.all(8),
//         elevation: 4,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         child: Container(
//           width: double.infinity,
//           height: _isFullScreen ? MediaQuery.of(context).size.height : 200,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(12),
//             color: Colors.black,
//           ),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(12),
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
//                             padding: const EdgeInsets.all(8.0),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 if (_isFullScreen)
//                                   IconButton(
//                                     icon: const Icon(Icons.arrow_back,
//                                         color: Colors.white),
//                                     onPressed: _toggleFullScreen,
//                                   )
//                                 else
//                                   const SizedBox(width: 48),
//                                 const Expanded(
//                                   child: Text(
//                                     'Workout Video',
//                                     style: TextStyle(color: Colors.white),
//                                     textAlign: TextAlign.center,
//                                   ),
//                                 ),
//                                 IconButton(
//                                   icon: Icon(
//                                     _isFullScreen
//                                         ? Icons.fullscreen_exit
//                                         : Icons.fullscreen,
//                                     color: Colors.white,
//                                   ),
//                                   onPressed: _toggleFullScreen,
//                                 ),
//                               ],
//                             ),
//                           ),

//                           // Center controls (show only when controls are visible)
//                           if (_showControls)
//                             Expanded(
//                               child: Center(
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceEvenly,
//                                   children: [
//                                     IconButton(
//                                       icon: const Icon(Icons.replay_10,
//                                           color: Colors.white, size: 32),
//                                       onPressed: _seekBackward,
//                                     ),
//                                     IconButton(
//                                       icon: Icon(
//                                         _controller.value.isPlaying
//                                             ? Icons.pause_circle
//                                             : Icons.play_circle,
//                                         color: Colors.white,
//                                         size: 60,
//                                       ),
//                                       onPressed: _togglePlayPause,
//                                     ),
//                                     IconButton(
//                                       icon: const Icon(Icons.forward_10,
//                                           color: Colors.white, size: 32),
//                                       onPressed: _seekForward,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),

//                           // Bottom controls
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Column(
//                               children: [
//                                 // Progress bar
//                                 VideoProgressIndicator(
//                                   _controller,
//                                   allowScrubbing: true,
//                                   padding:
//                                       const EdgeInsets.symmetric(vertical: 4),
//                                   colors: const VideoProgressColors(
//                                     playedColor: Colors.red,
//                                     bufferedColor: Colors.white38,
//                                     backgroundColor: Colors.white24,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 4),
//                                 // Time & right controls
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       "${_formatDuration(_currentPosition)} / ${_formatDuration(_totalDuration)}",
//                                       style: const TextStyle(
//                                           color: Colors.white, fontSize: 12),
//                                     ),
//                                     Row(
//                                       children: [
//                                         // Playback speed
//                                         PopupMenuButton<double>(
//                                           icon: const Icon(Icons.speed,
//                                               color: Colors.white),
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

//                 // Central play button when controls are hidden
//                 if (!_showControls &&
//                     _isInitialized &&
//                     !_controller.value.isPlaying)
//                   Positioned(
//                     top: 0,
//                     left: 0,
//                     right: 0,
//                     bottom: 0,
//                     child: Align(
//                       alignment: Alignment.center,
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: Colors.black45,
//                           shape: BoxShape.circle,
//                         ),
//                         child: IconButton(
//                           icon: const Icon(Icons.play_arrow,
//                               color: Colors.white, size: 60),
//                           onPressed: _togglePlayPause,
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

///Youtubre video player : v.0.7
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
  bool _showControls = false;
  bool _isFullScreen = false;
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url))
      ..initialize().then((_) {
        setState(() {
          _isInitialized = true;
          _totalDuration = _controller.value.duration;
        });
      });
    _controller.addListener(_updatePosition);
  }

  void _updatePosition() {
    if (mounted) {
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

  void _toggleFullScreen() {
    setState(() {
      _isFullScreen = !_isFullScreen;
    });
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
            setState(() {
              _showControls = false;
            });
          }
        });
      }
    });
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
        margin: const EdgeInsets.all(8),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          width: double.infinity,
          // height: _isFullScreen ? MediaQuery.of(context).size.height : 200,
          height: _isFullScreen
              ? MediaQuery.of(context).size.height
              : MediaQuery.of(context).size.width * 9 / 16, // 16:9 aspect ratio

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.black,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
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
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                if (_isFullScreen)
                                  IconButton(
                                    icon: const Icon(Icons.arrow_back,
                                        color: Colors.white),
                                    onPressed: _toggleFullScreen,
                                  )
                                else
                                  const SizedBox(width: 48),
                                const Expanded(
                                  child: Text(
                                    'Workout Video',
                                    style: TextStyle(color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    _isFullScreen
                                        ? Icons.fullscreen_exit
                                        : Icons.fullscreen,
                                    color: Colors.white,
                                  ),
                                  onPressed: _toggleFullScreen,
                                ),
                              ],
                            ),
                          ),

                          // Center controls (show only when controls are visible)
                          if (_showControls)
                            Expanded(
                              child: Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.replay_10,
                                          color: Colors.white, size: 32),
                                      onPressed: _seekBackward,
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        _controller.value.isPlaying
                                            ? Icons.pause_circle
                                            : Icons.play_circle,
                                        color: Colors.white,
                                        size: 60,
                                      ),
                                      onPressed: _togglePlayPause,
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.forward_10,
                                          color: Colors.white, size: 32),
                                      onPressed: _seekForward,
                                    ),
                                  ],
                                ),
                              ),
                            ),

                          // Bottom controls
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                // Progress bar
                                VideoProgressIndicator(
                                  _controller,
                                  allowScrubbing: true,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  colors: const VideoProgressColors(
                                    playedColor: Colors.red,
                                    bufferedColor: Colors.white38,
                                    backgroundColor: Colors.white24,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                // Time & right controls
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${_formatDuration(_currentPosition)} / ${_formatDuration(_totalDuration)}",
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                    Row(
                                      children: [
                                        // Playback speed
                                        PopupMenuButton<double>(
                                          icon: const Icon(Icons.speed,
                                              color: Colors.white),
                                          itemBuilder: (context) => [
                                            const PopupMenuItem(
                                                value: 0.5,
                                                child: Text('0.5x')),
                                            const PopupMenuItem(
                                                value: 0.75,
                                                child: Text('0.75x')),
                                            const PopupMenuItem(
                                                value: 1.0,
                                                child: Text('Normal')),
                                            const PopupMenuItem(
                                                value: 1.25,
                                                child: Text('1.25x')),
                                            const PopupMenuItem(
                                                value: 1.5,
                                                child: Text('1.5x')),
                                            const PopupMenuItem(
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

                // Central play button when paused and controls are hidden
                if (!_showControls &&
                    _isInitialized &&
                    !_controller.value.isPlaying)
                  Positioned.fill(
                    child: Center(
                      child: Container(
                        // width: 80,
                        // height: 80,
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Colors.black45,
                          shape: BoxShape.circle,
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: _togglePlayPause,
                            child: const Center(
                              child: Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                                // size: 50,
                                size: 36,
                              ),
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
