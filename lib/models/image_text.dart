import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class ImageText extends Equatable {
  final XFile image;
  final String text;
  final bool isEditing;
  final bool isFullText;

  const ImageText(
      {required this.image,
      required this.text,
      this.isEditing = false,
      this.isFullText = false});

  ImageText copyWith({
    XFile? image,
    String? text,
    bool? isEditing,
    bool? isFullText,
  }) {
    return ImageText(
      image: image ?? this.image,
      text: text ?? this.text,
      isEditing: isEditing ?? this.isEditing,
      isFullText: isFullText ?? this.isFullText,
    );
  }

  @override
  List<Object?> get props => [image, text, isEditing, isFullText];
}
