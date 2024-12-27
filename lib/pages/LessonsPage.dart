import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LessonsPage extends StatefulWidget {
  final String videoUrl; // YouTube video URL
  final String pdfUrl; // PDF file URL
  final String title; // PDF file name

  const LessonsPage({
    Key? key,
    required this.videoUrl,
    required this.pdfUrl,
    required this.title,
  }) : super(key: key);

  @override
  State<LessonsPage> createState() => _LessonsPageState();
}

class _LessonsPageState extends State<LessonsPage> {
  late YoutubePlayerController? _youtubeController;
  bool? _isDownloading = false;
  String? _localFilePath = '';

  @override
  void initState() {
    super.initState();
    String videoId = _extractVideoId(widget.videoUrl);
    _youtubeController = YoutubePlayerController(
      initialVideoId: videoId,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        controlsVisibleAtStart: true,
        disableDragSeek: true,
        hideThumbnail: false,
        loop: true,
        showLiveFullscreenButton: true,
        forceHD: true,
        useHybridComposition: true,
      ),
    );
    _downloadPdfIfNeeded();
  }

  @override
  void dispose() {
    _youtubeController!.dispose();
    super.dispose();
  }

  /// Extracts the video ID from a YouTube URL
  String _extractVideoId(String url) {
    Uri uri = Uri.parse(url);
    if (uri.host == 'youtu.be') {
      return uri.pathSegments.first;
    } else if (uri.host.contains('youtube.com') &&
        uri.queryParameters['v'] != null) {
      return uri.queryParameters['v']!;
    }
    throw Exception('Invalid YouTube URL');
  }

  Future<void> _downloadPdfIfNeeded() async {
    // Use the path_provider to get the external storage directory
    final directory = await getExternalStorageDirectory();
    if (directory == null) {
      debugPrint('External storage is not available.');
      return;
    }

    // Define a custom folder path (e.g., "MyAppDownloads")
    final customFolder = Directory('${directory.path}/IMedTeam');

    // Create the folder if it doesn't already exist
    if (!customFolder.existsSync()) {
      customFolder.createSync(recursive: true);
    }

    final filePath = '${customFolder.path}/${widget.title}';
    final file = File(filePath);

    if (!file.existsSync()) {
      setState(() {
        _isDownloading = true;
      });

      try {
        final dio = Dio();
        await dio.download(widget.pdfUrl, filePath);
        setState(() {
          _localFilePath = filePath;
        });

        // Notify the user of the saved location
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('File downloaded to: $filePath')),
        );
      } catch (e) {
        debugPrint('Error downloading PDF: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to download the file.')),
        );
      } finally {
        setState(() {
          _isDownloading = false;
        });
      }
    } else {
      setState(() {
        _localFilePath = filePath;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _youtubeController!,
        showVideoProgressIndicator: true,
        onReady: () {
          debugPrint('YouTube Player is ready.');
        },
        onEnded: (metaData) {
          debugPrint("Video ended: ${metaData.videoId}");
        },
      ),
      builder: (context, player) {
        return Scaffold(
          backgroundColor: Colors.grey[50],
          appBar: AppBar(
            backgroundColor: Colors.redAccent,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context); // Navigate back
                  },
                ),
                Center(
                    child: Text(
                  widget.title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.white),
                )),
                IconButton(
                    alignment: Alignment.topRight,
                    onPressed: () async {
                      final directory =
                          await getApplicationDocumentsDirectory();
                      final filePath = '${directory.path}/${widget.title}';

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Document downloaded to $filePath'),
                      ));
                    },
                    icon: Icon(
                      Icons.download,
                      color: Colors.white,
                    )),
              ],
            ),
          ),
          body: Column(
            children: [
              // YouTube Player
              player,
              const SizedBox(height: 10),
              // Document Viewer
              Expanded(
                child: _isDownloading!
                    ? const Center(child: CircularProgressIndicator())
                    : _localFilePath!.isNotEmpty
                        ? PDFView(
                            filePath: _localFilePath,
                            enableSwipe: true,
                            swipeHorizontal: false,
                            autoSpacing: true,
                            pageFling: true,
                          )
                        : const Center(child: Text('Unable to load document')),
              ),
              // Download Button
              Container(
                margin: EdgeInsets.only(bottom: 15, left: 15, right: 15),
                width: size.width,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () async {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Document downloaded to '),
                    ));
                  },
                  child: Text(
                    "Keyingi dars",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
