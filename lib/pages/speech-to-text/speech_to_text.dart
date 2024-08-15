import 'package:flutter/material.dart';
// import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as ttt;

class SpeechToText extends StatefulWidget {
  const SpeechToText({super.key});
  static String routhPath() => "/speechToText";

  @override
  State<SpeechToText> createState() => _SpeechToTextState();
}

class _SpeechToTextState extends State<SpeechToText> {
  final ttt.SpeechToText _speech = ttt.SpeechToText();
  bool _isAvailable = false;
  String _recognizedWords = 'init';

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  Future<void> _initSpeech() async {
    _isAvailable = await _speech.initialize(
      onStatus: (status) {
        print('Speech status: $status');
      },
      onError: (error) {
        print('Speech error: $error');
      },
    );
    setState(() {});
  }

  Future<void> _startListening() async {
    if (_isAvailable) {
      await _speech.listen(
        onResult: (result) {
          setState(() {
            _recognizedWords = result.recognizedWords;
            // Process recognized words here
          });
        },
        listenFor: const Duration(seconds: 5),
      );
    }
  }

  Future<void> _stopListening() async {
    await _speech.stop();
    setState(() {
      _recognizedWords = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Voice to Text'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_recognizedWords),
            ElevatedButton(
              onPressed: _startListening,
              child: const Text('Start'),
            ),
            ElevatedButton(
              onPressed: _stopListening,
              child: const Text('Stop'),
            ),
          ],
        ),
      ),
    );
  }
}
