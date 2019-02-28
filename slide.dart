import 'photo.dart';

class Slide{
  
  List<int> photoIds;
  Set<String> tags;

  Slide(Photo firstPhoto, [Photo secondPhoto]){
    
    this.photoIds = [];
    this.tags = Set();

    _addPhotoData(firstPhoto);
    if(!firstPhoto.isHorizontal && !secondPhoto.isHorizontal){
      _addPhotoData(secondPhoto);
    }
  }

  _addPhotoData(Photo photo){
    this.photoIds.add(photo.id);
    this.tags.addAll(photo.tags.toSet());
  }

  @override
  String toString() => "SLIDE: $photoIds, $tags"; 

}