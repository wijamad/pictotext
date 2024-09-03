part of 'pictotext_bloc.dart';

sealed class PictotextEvent {
  const PictotextEvent();
}

final class RecognizeImage extends PictotextEvent {}

final class ChangeisEditing extends PictotextEvent {
  const ChangeisEditing({required this.index});
  final int index;
}

final class ChangeisFullText extends PictotextEvent {
  const ChangeisFullText({required this.index});
  final int index;
}

final class SaveText extends PictotextEvent {
  const SaveText({required this.index, required this.text});
  final int index;
  final String text;
}
