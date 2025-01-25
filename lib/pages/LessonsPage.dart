import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../models/end_model.dart';
import '../models/lesson_model.dart';
import '../services/ApiService.dart';
import '../widgets/dialog.dart';

class LessonsPage extends StatefulWidget {
  final num courseId;
  final num moduleId;
  final num lessonId;

  const LessonsPage({
    Key? key,
    required this.courseId,
    required this.moduleId,
    required this.lessonId,
  }) : super(key: key);

  @override
  State<LessonsPage> createState() => _LessonsPageState();
}

class _LessonsPageState extends State<LessonsPage> {
  late YoutubePlayerController? _youtubeController;
  late Future<LessonModel> _lessonFuture;
  bool _isDownloading = false;
  String? _localFilePath;
  final ApiService _apiService = ApiService('https://oztech.uz/api/v1');

  @override
  void initState() {
    super.initState();
    _lessonFuture = _apiService.show_lesson(
      widget.courseId,
      widget.moduleId,
      widget.lessonId,
    );
    _initializeLesson();
  }

  @override
  void dispose() {
    _youtubeController?.dispose();
    super.dispose();
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
        ),
      );

      await _downloadPdfIfNeeded(lesson);
    } catch (e) {
      debugPrint('Error initializing lesson: $e');
    }
  }

  Future<void> _downloadPdfIfNeeded(LessonModel lesson) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/${lesson.data!.name}.pdf';
      final file = File(filePath);

      if (!file.existsSync()) {
        setState(() => _isDownloading = true);
        final dio = Dio();
        await dio.download(
          'https://oztech.uz${lesson.data!.resource}',
          filePath,
        );
        debugPrint('PDF downloaded to $filePath');
      }

      setState(() => _localFilePath = filePath);
    } catch (e) {
      debugPrint('Error downloading PDF: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to download the file.')),
      );
    } finally {
      setState(() => _isDownloading = false);
    }
  }

  String _extractVideoId(String url) {
    try {
      final uri = Uri.parse(url);
      if (uri.host == 'youtu.be') {
        return uri.pathSegments.first;
      } else if (uri.host.contains('youtube.com') && uri.queryParameters['v'] != null) {
        return uri.queryParameters['v']!;
      }
    } catch (e) {
      debugPrint('Invalid YouTube URL: $e');
    }
    throw Exception('Invalid YouTube URL');
  }

  void _endLesson() async {
    LoadingDialog.show_dialog(context);

    try {
      final response = await _apiService.end_lesson(EndModel(
        course: widget.courseId,
        modul: widget.moduleId,
        lesson: widget.lessonId,
      ));
      LoadingDialog.hide_dialog(context);

      if (response.status == 'success') {
        Navigator.pop(context, 'refresh');
      }
    } catch (e) {
      LoadingDialog.hide_dialog(context);
      debugPrint('Error ending lesson: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<LessonModel>(
          future: _lessonFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('Loading...');
            } else if (snapshot.hasError) {
              return const Text('Error loading lesson');
            } else {
              return Text(snapshot.data?.data?.name ?? 'Lesson');
            }
          },
        ),
      ),
      body: FutureBuilder<LessonModel>(
        future: _lessonFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No data found'));
          }

          return Column(
            children: [
              YoutubePlayerBuilder(
                player: YoutubePlayer(controller: _youtubeController!),
                builder: (context, player) => player,
              ),
              const SizedBox(height: 10),
              Expanded(
                child: _isDownloading
                    ? const Center(child: CircularProgressIndicator())
                    : _localFilePath != null
                    ? PDFView(
                  filePath: _localFilePath!,
                  enableSwipe: true,
                )
                    : const Center(child: Text('Unable to load document')),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child:Container(
                  width: size.width / 0.9,
                  height: 50,
                  child: ElevatedButton(
                    style: Theme.of(context).elevatedButtonTheme.style,
                    onPressed: _endLesson,
                    child: Text(
                      "Keyingi darsga o'tish",
                      style: TextStyle(color: Colors.white, fontSize: 19),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
