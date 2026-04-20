import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

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
  const TextState({this.items = const []});

  TextState copyWith({List<String>? items}) {
    return TextState(items: items ?? this.items);
  }

  @override
  List<Object?> get props => [items];
}

class TextBloc extends Bloc<TextEvent, TextState> {
  TextBloc() : super(const TextState()) {
    on<AddTextEvent>((event, emit) {
      final trimmed = event.text.trim();
      if (trimmed.isEmpty) return;

      final updatedItems = List<String>.from(state.items)..add(trimmed);
      emit(state.copyWith(items: updatedItems));
    });
  }
}

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BLoC List Demo',
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
      body: Padding(
        padding: const EdgeInsets.only(top: 100.0, left: 20.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Введите текст',
                      labelStyle: TextStyle(
                        color: Colors.pink.shade200,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.pink.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.pink.shade200, width: 2.0),
                      ),
                    ),
                    onSubmitted: (_) => _onAddPressed(),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _onAddPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink.shade600,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 4,
                  ),
                  child: const Text('Добавить'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: BlocBuilder<TextBloc, TextState>(
                builder: (context, state) {
                  if (state.items.isEmpty) {
                    return Center(
                      child: Text(
                        'Список пуст\nДобавьте первый элемент',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey.shade500, fontSize: 16),
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: state.items.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.grey.shade900,
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          leading: const Icon(Icons.text_snippet, color: Colors.pink),
                          title: Text(
                            state.items[index],
                            style: const TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}