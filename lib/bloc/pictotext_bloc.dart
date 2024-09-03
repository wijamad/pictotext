import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pictotext/models/models.dart';
import 'dart:developer' as developer;

part 'pictotext_event.dart';
part 'pictotext_state.dart';

class PictotextBloc extends Bloc<PictotextEvent, PictotextState> {
  PictotextBloc() : super(const PictotextState()) {
    on<RecognizeImage>(_onRecognizeImage);
    on<ChangeisEditing>(_onChangeisEditing);
    on<SaveText>(_onEditSave);
    on<ChangeisFullText>(_onChangeisFullText);
  }

  void _onRecognizeImage(
      RecognizeImage event, Emitter<PictotextState> emit) async {
    emit(state.copyWith(status: TextStatus.loading));
    final List<XFile> images = await ImagePicker().pickMultiImage();
    List<ImageText> items = [...state.items];

    for (final XFile image in images) {
      final InputImage inputImage = InputImage.fromFilePath(image.path);
      final textRecognizer =
          TextRecognizer(script: TextRecognitionScript.latin);
      final RecognizedText recognizedText =
          await textRecognizer.processImage(inputImage);
      items.add(ImageText(image: image, text: recognizedText.text));
      developer.log('"imagesText : ${items.length} items : ${images.length}");',
          name: 'status images');
    }
    emit(state.copyWith(
      items: [...items],
      status: TextStatus.success,
    ));
    developer.log("status state : ${state.items.length}");
  }

  void _onChangeisEditing(ChangeisEditing event, Emitter<PictotextState> emit) {
    final List<ImageText> items = [...state.items];
    ImageText imageText = items[event.index];
    items[event.index] = imageText.copyWith(
      isEditing: !imageText.isEditing,
    );
    emit(state.copyWith(
      status: TextStatus.success,
      items: items,
    ));
  }

  void _onEditSave(SaveText event, Emitter<PictotextState> emit) {
    final List<ImageText> items = [...state.items];
    ImageText imageText = items[event.index];
    items[event.index] = imageText.copyWith(
      text: event.text,
      isEditing: !imageText.isEditing,
    );

    emit(state.copyWith(
      status: TextStatus.success,
      items: items,
    ));
  }

  void _onChangeisFullText(
      ChangeisFullText event, Emitter<PictotextState> emit) {
    final List<ImageText> items = [...state.items];
    ImageText imageText = items[event.index];
    items[event.index] = imageText.copyWith(
      isFullText: !imageText.isFullText,
    );
    emit(state.copyWith(
      status: TextStatus.success,
      items: items,
    ));
  }
}
