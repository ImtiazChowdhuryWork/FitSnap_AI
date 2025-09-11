///Working version : v.0.0.1
// import 'dart:io';
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:video_player/video_player.dart';
// import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;

// class CachedVideoPlayerWidget extends StatefulWidget {
//   final String url;
//   const CachedVideoPlayerWidget({super.key, required this.url});

//   @override
//   State<CachedVideoPlayerWidget> createState() =>
//       _CachedVideoPlayerWidgetState();
// }

// class _CachedVideoPlayerWidgetState extends State<CachedVideoPlayerWidget> {
//   VideoPlayerController? _controller;
//   bool _isInitialized = false;
//   bool _showControls = false;
//   bool _isFullScreen = false;
//   Duration _currentPosition = Duration.zero;
//   Duration _totalDuration = Duration.zero;
//   File? _cachedFile;

//   @override
//   void initState() {
//     super.initState();
//     _prepareVideo(widget.url);
//   }

//   @override
//   void didUpdateWidget(CachedVideoPlayerWidget oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (oldWidget.url != widget.url) {
//       _controller?.dispose();
//       _prepareVideo(widget.url);
//     }
//   }

//   Future<void> _prepareVideo(String url) async {
//     _cachedFile = await _getCachedVideo(url);
//     _controller = VideoPlayerController.file(_cachedFile!)
//       ..initialize().then((_) {
//         if (mounted) {
//           setState(() {
//             _isInitialized = true;
//             _totalDuration = _controller!.value.duration;
//           });
//         }
//       });
//     _controller!.addListener(_updatePosition);
//     _controller!.setLooping(false);
//   }

//   Future<File> _getCachedVideo(String url) async {
//     final cacheDir = await getTemporaryDirectory();
//     final fileName = Uri.parse(url).pathSegments.join("_").replaceAll(" ", "_");
//     final file = File("${cacheDir.path}/$fileName");

//     // If file exists, use cached file
//     if (await file.exists()) return file;

//     // Download & cache video
//     // final response = await http.get(Uri.parse(url));
//     final response = await http.get(Uri.parse(url));
//     await file.writeAsBytes(response.bodyBytes);
//     return file;
//   }

//   void _updatePosition() {
//     if (mounted && _controller!.value.isInitialized) {
//       setState(() {
//         _currentPosition = _controller!.value.position;
//         _totalDuration = _controller!.value.duration;
//       });
//     }
//   }

//   @override
//   void dispose() {
//     _controller?.removeListener(_updatePosition);
//     _controller?.dispose();
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
//     _controller!
//         .seekTo(newPosition > _totalDuration ? _totalDuration : newPosition);
//   }

//   void _seekBackward() {
//     final newPosition = _currentPosition - const Duration(seconds: 10);
//     _controller!
//         .seekTo(newPosition < Duration.zero ? Duration.zero : newPosition);
//   }

//   void _toggleMute() {
//     _controller!.setVolume(_controller!.value.volume == 0 ? 1 : 0);
//     setState(() {});
//   }

//   void _setPlaybackSpeed(double speed) {
//     _controller!.setPlaybackSpeed(speed);
//     setState(() {});
//   }

//   void _togglePlayPause() {
//     if (_controller!.value.isPlaying) {
//       _controller!.pause();
//       setState(() => _showControls = true);
//     } else {
//       _controller!.play();
//       Future.delayed(const Duration(seconds: 3), () {
//         if (mounted && _controller!.value.isPlaying)
//           {
//             setState(() => _showControls = false);
//           }
//       });
//     }
//   }

//   void _toggleFullScreen() {
//     _isFullScreen = !_isFullScreen;
//     if (_isFullScreen) {
//       SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
//     } else {
//       SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
//     }
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         setState(() => _showControls = !_showControls);
//         if (_showControls) {
//           Future.delayed(const Duration(seconds: 3), () {
//             if (mounted && _showControls && _controller!.value.isPlaying) {
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
//                 if (_isInitialized)
//                   Center(
//                     child: AspectRatio(
//                       aspectRatio: _controller!.value.aspectRatio,
//                       child: VideoPlayer(_controller!),
//                     ),
//                   )
//                 else
//                   const Center(
//                       child: CircularProgressIndicator(color: Colors.white)),

//                 // Controls Overlay
//                 if (_showControls ||
//                     (_isInitialized && !_controller!.value.isPlaying))
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
//                                         _controller!.value.isPlaying
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
//                                   _controller!,
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
//                                           itemBuilder: (context) => const [
//                                             PopupMenuItem(
//                                                 value: 0.5,
//                                                 child: Text('0.5x')),
//                                             PopupMenuItem(
//                                                 value: 0.75,
//                                                 child: Text('0.75x')),
//                                             PopupMenuItem(
//                                                 value: 1.0,
//                                                 child: Text('Normal')),
//                                             PopupMenuItem(
//                                                 value: 1.25,
//                                                 child: Text('1.25x')),
//                                             PopupMenuItem(
//                                                 value: 1.5,
//                                                 child: Text('1.5x')),
//                                             PopupMenuItem(
//                                                 value: 2.0, child: Text('2x')),
//                                           ],
//                                           onSelected: _setPlaybackSpeed,
//                                         ),
//                                         IconButton(
//                                           icon: Icon(
//                                             _controller!.value.volume == 0
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
//                     !_controller!.value.isPlaying)
//                   Positioned.fill(
//                     child: Center(
//                       child: Container(
//                         width: 40.w,
//                         height: 40.w,
//                         decoration: const BoxDecoration(
//                             color: Colors.black45, shape: BoxShape.circle),
//                         child: Material(
//                           color: Colors.transparent,
//                           child: InkWell(
//                             borderRadius: BorderRadius.circular(20.r),
//                             onTap: _togglePlayPause,
//                             child: Center(
//                               child: Icon(Icons.play_arrow,
//                                   color: Colors.white, size: 36.sp),
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

///Working version : v.0.0.3 - Fixed URL construction and error handling
import 'dart:io';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';

import '../../../../networks/dio/dio.dart';

class CachedVideoPlayerWidget extends StatefulWidget {
  final String url;
  const CachedVideoPlayerWidget({super.key, required this.url});

  @override
  State<CachedVideoPlayerWidget> createState() =>
      _CachedVideoPlayerWidgetState();
}

class _CachedVideoPlayerWidgetState extends State<CachedVideoPlayerWidget> {
  VideoPlayerController? _controller;
  bool _isInitialized = false;
  bool _showControls = false;
  bool _isFullScreen = false;
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;
  bool _isDownloading = false;
  double _downloadProgress = 0;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  @override
  void didUpdateWidget(CachedVideoPlayerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.url != widget.url) {
      _controller?.dispose();
      _initializeVideo();
    }
  }

  Future<void> _initializeVideo() async {
    setState(() {
      _isDownloading = false;
      _downloadProgress = 0;
      _isInitialized = false;
      _errorMessage = null;
    });

    try {
      // Validate URL first
      if (!_isValidUrl(widget.url)) {
        setState(() {
          _errorMessage = 'Invalid video URL: ${widget.url}';
        });
        return;
      }

      print('Attempting to load video: ${widget.url}');

      // First try direct network URL
      await _initializeFromNetwork(widget.url);
    } catch (e) {
      print('Error initializing video: $e');
      setState(() {
        _errorMessage = 'Failed to load video: ${e.toString()}';
      });
    }
  }

  bool _isValidUrl(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https');
    } catch (e) {
      return false;
    }
  }

  Future<void> _initializeFromNetwork(String url) async {
    try {
      _controller = VideoPlayerController.networkUrl(Uri.parse(url));
      await _controller!.initialize();

      if (mounted) {
        _controller!.addListener(_updatePosition);
        _controller!.setLooping(false);

        setState(() {
          _isInitialized = true;
          _totalDuration = _controller!.value.duration;
        });

        print(
            'Video initialized successfully from network. Duration: ${_totalDuration.inSeconds}s');
      }
    } catch (e) {
      print('Network initialization failed, trying cached version: $e');
      // If network fails, try to get cached version or download
      await _initializeFromCache(url);
    }
  }

  Future<void> _initializeFromCache(String url) async {
    try {
      final cachedFile = await _getCachedVideo(url);
      if (cachedFile != null && await cachedFile.exists()) {
        _controller = VideoPlayerController.file(cachedFile);
        await _controller!.initialize();

        if (mounted) {
          _controller!.addListener(_updatePosition);
          _controller!.setLooping(false);

          setState(() {
            _isInitialized = true;
            _totalDuration = _controller!.value.duration;
          });

          print(
              'Video initialized successfully from cache. Duration: ${_totalDuration.inSeconds}s');
        }
      } else {
        throw Exception('Failed to cache video');
      }
    } catch (e) {
      print('Cache initialization also failed: $e');
      rethrow;
    }
  }

  Future<File?> _getCachedVideo(String url) async {
    try {
      final cacheDir = await getTemporaryDirectory();
      final fileName =
          Uri.parse(url).pathSegments.join("_").replaceAll(" ", "_");
      final file = File("${cacheDir.path}/$fileName");

      if (await file.exists()) {
        print('Using cached file: ${file.path}');
        return file;
      }

      print('Downloading video for caching...');
      setState(() {
        _isDownloading = true;
        _downloadProgress = 0;
      });

      final dio = Dio();
      await dio.download(
        url,
        file.path,
        onReceiveProgress: (received, total) {
          if (total != -1 && mounted) {
            setState(() {
              _downloadProgress = received / total;
            });
          }
        },
        cancelToken: DioSingleton.cancelToken,
      );

      if (mounted) {
        setState(() {
          _isDownloading = false;
        });
      }

      print('Video downloaded and cached successfully');
      return file;
    } catch (e) {
      print('Caching failed: $e');
      if (mounted) {
        setState(() {
          _isDownloading = false;
        });
      }
      return null;
    }
  }

  void _updatePosition() {
    if (mounted && _controller!.value.isInitialized) {
      setState(() {
        _currentPosition = _controller!.value.position;
        _totalDuration = _controller!.value.duration;
      });
    }
  }

  @override
  void dispose() {
    _controller?.removeListener(_updatePosition);
    _controller?.dispose();
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
    _controller!
        .seekTo(newPosition > _totalDuration ? _totalDuration : newPosition);
  }

  void _seekBackward() {
    final newPosition = _currentPosition - const Duration(seconds: 10);
    _controller!
        .seekTo(newPosition < Duration.zero ? Duration.zero : newPosition);
  }

  void _toggleMute() {
    _controller!.setVolume(_controller!.value.volume == 0 ? 1 : 0);
    setState(() {});
  }

  void _setPlaybackSpeed(double speed) {
    _controller!.setPlaybackSpeed(speed);
    setState(() {});
  }

  void _togglePlayPause() {
    if (_controller!.value.isPlaying) {
      _controller!.pause();
      setState(() => _showControls = true);
    } else {
      _controller!.play();
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted && _controller!.value.isPlaying)
          setState(() => _showControls = false);
      });
    }
  }

  void _toggleFullScreen() {
    _isFullScreen = !_isFullScreen;
    if (_isFullScreen) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // Show downloading progress
    if (_isDownloading) {
      return SizedBox(
        height: MediaQuery.of(context).size.width * 9 / 16,
        child: Card(
          margin: EdgeInsets.all(8.w),
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: Colors.black,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    value: _downloadProgress,
                    color: Colors.white,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Downloading video... ${(_downloadProgress * 100).toStringAsFixed(0)}%',
                    style: TextStyle(color: Colors.white, fontSize: 14.sp),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    // Show error state
    if (_errorMessage != null) {
      return SizedBox(
        height: MediaQuery.of(context).size.width * 9 / 16,
        child: Card(
          margin: EdgeInsets.all(8.w),
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: Colors.black,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, color: Colors.red, size: 48.sp),
                  SizedBox(height: 8.h),
                  Text(
                    'Video Error',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Text(
                      _errorMessage!,
                      style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  ElevatedButton(
                    onPressed: _initializeVideo,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        setState(() => _showControls = !_showControls);
        if (_showControls) {
          Future.delayed(const Duration(seconds: 3), () {
            if (mounted && _showControls && _controller!.value.isPlaying) {
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
                if (_isInitialized)
                  Center(
                    child: AspectRatio(
                      aspectRatio: _controller!.value.aspectRatio,
                      child: VideoPlayer(_controller!),
                    ),
                  )
                else
                  const Center(
                      child: CircularProgressIndicator(color: Colors.white)),
                // Controls overlay
                if (_showControls ||
                    (_isInitialized && !_controller!.value.isPlaying))
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
                                        _controller!.value.isPlaying
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
                                  _controller!,
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
                                            _controller!.value.volume == 0
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
                    !_controller!.value.isPlaying)
                  Positioned.fill(
                    child: Center(
                      child: Container(
                        width: 40.w,
                        height: 40.w,
                        decoration: const BoxDecoration(
                            color: Colors.black45, shape: BoxShape.circle),
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
