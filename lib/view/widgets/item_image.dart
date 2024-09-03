import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pictotext/bloc/pictotext_bloc.dart';

class ItemImage extends StatelessWidget {
  const ItemImage({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PictotextBloc, PictotextState>(
      buildWhen: (previous, current) =>
          previous.items[index] != current.items[index],
      builder: (context, state) {
        final TextEditingController textController =
            TextEditingController(text: state.items[index].text);
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Image.file(File(state.items[index].image.path),
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Text('Error')),
                  const SizedBox(height: 20),
                  state.items[index].isEditing
                      ? TextField(
                          controller: textController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        )
                      : (state.items[index].text.length > 60 &&
                              state.items[index].isFullText == false)
                          ? Text.rich(
                              TextSpan(
                                text:
                                    "${state.items[index].text.substring(0, 60)}...",
                                children: [
                                  TextSpan(
                                    text: "show more",
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        context.read<PictotextBloc>().add(
                                            ChangeisFullText(index: index));
                                      },
                                    style: const TextStyle(
                                      color: Colors.blue,
                                    ),
                                  )
                                ],
                              ),
                            )
                          : Text.rich(
                              TextSpan(
                                text: state.items[index].text,
                                children: [
                                  TextSpan(
                                    text: " show less",
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        context.read<PictotextBloc>().add(
                                            ChangeisFullText(index: index));
                                      },
                                    style: const TextStyle(
                                      color: Colors.red,
                                    ),
                                  )
                                ],
                              ),
                            ),
                  const SizedBox(height: 20),
                  state.items[index].isEditing
                      ? ButtonTrueEditing(
                          onCancel: () => context
                              .read<PictotextBloc>()
                              .add(ChangeisEditing(index: index)),
                          onSave: () => context.read<PictotextBloc>().add(
                              SaveText(
                                  index: index, text: textController.text)),
                        )
                      : ButtonFalseEditing(
                          onCopyPressed: () =>
                              ClipboardData(text: state.items[index].text),
                          onEditPressed: () =>
                              context.read<PictotextBloc>().add(
                                    ChangeisEditing(index: index),
                                  ),
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class ButtonFalseEditing extends StatelessWidget {
  const ButtonFalseEditing({
    super.key,
    required this.onCopyPressed,
    required this.onEditPressed,
  });

  final VoidCallback onCopyPressed;
  final VoidCallback onEditPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: onCopyPressed,
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
          child: const Text('Copy'),
        ),
        ElevatedButton(
          onPressed: onEditPressed,
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          child: const Text('Edit'),
        )
      ],
    );
  }
}

class ButtonTrueEditing extends StatelessWidget {
  const ButtonTrueEditing({
    super.key,
    required this.onCancel,
    required this.onSave,
  });

  final VoidCallback onCancel;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: onCancel,
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: onSave,
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          child: const Text('Save'),
        ),
      ],
    );
  }
}
