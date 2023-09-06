import 'dart:convert';
import 'dart:developer';

import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/material.dart';
import 'package:notink/feature/home/presentaion/widgets/editor.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late WidgetBuilder _widgetBuilder;
  late EditorState _editorState;
  late Future<String> _jsonString;

  @override
  void initState() {
    super.initState();
    _jsonString = Future<String>.value(
      jsonEncode(
        EditorState.blank(withInitialText: true).document.toJson(),
      ).toString(),
    );
    _widgetBuilder = (context) => Editor(
          jsonString: _jsonString,
          onEditorStateChange: (editorState) {
            _editorState = editorState;
            _jsonString = Future.value(
              jsonEncode(_editorState.document.toJson()),
            );
          },
        );
  }

  @override
  void reassemble() {
    super.reassemble();

    _widgetBuilder = (context) => Editor(
          jsonString: _jsonString,
          onEditorStateChange: (editorState) {
            _editorState = editorState;
            _jsonString = Future.value(
              jsonEncode(_editorState.document.toJson()),
            );
            log("String: ${_editorState.document.toJson().runtimeType}");
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          TextField(),
          const SizedBox(height: 20),
          Divider(),
          const SizedBox(height: 20),
          Expanded(
            child: Builder(builder: _widgetBuilder),
          ),
        ],
      ),
    );
  }
}
