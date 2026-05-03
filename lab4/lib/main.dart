import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

abstract class TextEvent extends Equatable {
  const TextEvent();

  @override
  List<Object?> get props => [];
}

class AddTextEvent extends TextEvent {
  final String text;

  const AddTextEvent(this.text);

  @override
  List<Object?> get props => [text];
}

class TextState extends Equatable {
  final List<String> items;
  final bool isLoading;

  const TextState({
    this.items = const [],
    this.isLoading = false,
  });

  TextState copyWith({
    List<String>? items,
    bool? isLoading,
  }) {
    return TextState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [items, isLoading];
}

class TextBloc extends HydratedBloc<TextEvent, TextState> {
  TextBloc() : super(const TextState()) {
    on<AddTextEvent>(
      _onAddText,
      transformer: sequential(),
    );
  }

  Future<void> _onAddText(
    AddTextEvent event,
    Emitter<TextState> emit,
  ) async {
    final trimmed = event.text.trim();

    if (trimmed.isEmpty) return;

    emit(
      state.copyWith(
        isLoading: true,
        items: state.items,
      ),
    );

    await Future.delayed(const Duration(seconds: 2));

    final updatedItems = List<String>.from(state.items)..add(trimmed);

    emit(
      state.copyWith(
        items: updatedItems,
        isLoading: false,
      ),
    );
  }

  @override
  TextState? fromJson(Map<String, dynamic> json) {
    try {
      final itemsJson = json['items'] as List<dynamic>? ?? [];

      return TextState(
        items: itemsJson.map((item) => item.toString()).toList(),

        isLoading: false,
      );
    } catch (_) {
      return const TextState();
    }
  }

  @override
  Map<String, dynamic>? toJson(TextState state) {
    return {
      'items': state.items,
      'isLoading': state.isLoading,
    };
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BLoC List Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.black,
      ),
      home: BlocProvider(
        create: (_) => TextBloc(),
        child: const InputScreen(),
      ),
    );
  }
}

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _onAddPressed() {
    final text = _textController.text;

    if (text.trim().isNotEmpty) {
      context.read<TextBloc>().add(AddTextEvent(text));
      _textController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TextBloc, TextState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(
              top: 100.0,
              left: 20.0,
              right: 20.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _textController,
                        enabled: !state.isLoading,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Введите текст',
                          labelStyle: TextStyle(
                            color: Colors.pink.shade200,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.pink.shade300,
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade700,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.pink.shade200,
                              width: 2.0,
                            ),
                          ),
                        ),
                        onSubmitted: (_) {
                          if (!state.isLoading) {
                            _onAddPressed();
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: state.isLoading ? null : _onAddPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink.shade600,
                        foregroundColor: Colors.white,
                        disabledBackgroundColor: Colors.grey.shade700,
                        disabledForegroundColor: Colors.grey.shade400,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 4,
                      ),
                      child: state.isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text('Добавить'),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                if (state.isLoading) ...[
                  LinearProgressIndicator(
                    color: Colors.pink.shade300,
                    backgroundColor: Colors.grey.shade900,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Добавляем слово...',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.pink.shade100,
                      fontSize: 14,
                    ),
                  ),
                ] else
                  const SizedBox(height: 20),

                Expanded(
                  child: state.items.isEmpty
                      ? Center(
                          child: Text(
                            'Список пуст\nДобавьте первый элемент',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 16,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: state.items.length,
                          itemBuilder: (context, index) {
                            return Card(
                              color: Colors.grey.shade900,
                              margin: const EdgeInsets.only(bottom: 8),
                              child: ListTile(
                                leading: const Icon(
                                  Icons.text_snippet,
                                  color: Colors.pink,
                                ),
                                title: Text(
                                  state.items[index],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}