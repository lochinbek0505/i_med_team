import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:i_med_team/models/end_model.dart';
import 'package:i_med_team/models/lesson_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../services/ApiService.dart';

class LessonsPage extends StatefulWidget {
  final num course_id;
  final num modul_id;
  final num lesson_id;

  const LessonsPage({
    Key? key,
    required this.course_id,
    required this.modul_id,
    required this.lesson_id,
  }) : super(key: key);

  @override
  State<LessonsPage> createState() => _LessonsPageState();
}

class _LessonsPageState extends State<LessonsPage> {
  late YoutubePlayerController? _youtubeController;
  bool _isDownloading = false;
  String _localFilePath = '';
  bool _isLoading = true;
  final ApiService apiService = ApiService('https://oztech.uz/api/v1');
  late Future<LessonModel> _lessonFuture;

  @override
  void initState() {
    super.initState();
    _lessonFuture = apiService.show_lesson(
        widget.course_id, widget.modul_id, widget.lesson_id);
    _initializeLesson();
  }

  void _endLesson() async {
    var data = await apiService.end_lesson(EndModel(
        course: widget.course_id,
        modul: widget.modul_id,
        lesson: widget.lesson_id));
    if (data.status == "success") {
      Navigator.pop(context);
    }
  }

  Future<void> _initializeLesson() async {
    try {
      final lesson = await _lessonFuture;
      final videoId = _extractVideoId(lesson.data!.video);

      _youtubeController = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          controlsVisibleAtStart: true,
          loop: true,
          forceHD: true,
        ),
      );

      await _downloadPdfIfNeeded(lesson);
    } catch (e) {
      debugPrint('Error initializing lesson: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _youtubeController?.dispose();
    super.dispose();
  }

  String _extractVideoId(String url) {
    try {
      final uri = Uri.parse(url);
      if (uri.host == 'youtu.be') {
        return uri.pathSegments.first;
      } else if (uri.host.contains('youtube.com') &&
          uri.queryParameters['v'] != null) {
        return uri.queryParameters['v']!;
      }
    } catch (e) {
      debugPrint('Invalid YouTube URL: $e');
    }
    throw Exception('Invalid YouTube URL');
  }

  Future<void> _downloadPdfIfNeeded(LessonModel lesson) async {
    try {
      final directory = await getExternalStorageDirectory();
      if (directory == null) {
        throw Exception('External storage not available.');
      }

      final customFolder = Directory('${directory.path}/IMedTeam');
      if (!customFolder.existsSync()) {
        customFolder.createSync(recursive: true);
      }

      final filePath = '${customFolder.path}/${lesson.data!.name}';
      final file = File(filePath);

      if (!file.existsSync()) {
        setState(() {
          _isDownloading = true;
        });

        final dio = Dio();
        await dio.download(
            "https://oztech.uz${lesson.data!.resource}", filePath);

        setState(() {
          _localFilePath = filePath;
        });

        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text('File downloaded to: $filePath')),
        // );
      } else {
        setState(() {
          _localFilePath = filePath;
        });
      }
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
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: FutureBuilder<LessonModel>(
          future: _lessonFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData) {
              return const Text('No data found.');
            } else {
              return Text(
                snapshot.data!.data!.name!,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              );
            }
          },
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                YoutubePlayerBuilder(
                  player: YoutubePlayer(controller: _youtubeController!),
                  builder: (context, player) => player,
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: _isDownloading
                      ? const Center(child: CircularProgressIndicator())
                      : _localFilePath.isNotEmpty
                          ? PDFView(
                              filePath: _localFilePath,
                              enableSwipe: true,
                            )
                          : const Center(
                              child: Text('Unable to load document')),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Container(
                    width: size.width / 0.9,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          )),
                      onPressed: _endLesson,
                      child: Text(
                        "Keyingi darsga o'tish",
                        style: TextStyle(color: Colors.white, fontSize: 19),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
