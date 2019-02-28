import 'photo.dart';
import 'slide.dart';
import 'dart:math';

class Slideshow{

  List<Photo> allPhotos;
  List<Slide> allSlides;

  Slideshow(List<String> data){
    int numberOfImages = int.parse(data.removeAt(0));
    
    // Load all photos
    this.allPhotos = [];
    for(int i = 0; i < numberOfImages; i++){
      allPhotos.add(Photo(data[i], i));
    }

    this.allSlides = [];
  }

  List<Slide> covertAllPhotosToUnorderedSlides(){

    _addAllHorizontalPhotosIntoSlides();

    _addAllVerticalPhotosIntoSlides();

    return allSlides;
  }

  _addAllHorizontalPhotosIntoSlides(){
    for(int i = allPhotos.length-1; i>=0; i--){
      if(allPhotos[i].isHorizontal){
        allSlides.add(Slide(allPhotos.removeAt(i)));
      }
    }
  }

  _addAllVerticalPhotosIntoSlides() {
    while(allPhotos.isNotEmpty){
      Photo anyVerticalPhoto = allPhotos.removeAt(0);
      Photo bestPairingVerticalPhoto = _findBestPairingPhoto(anyVerticalPhoto);

      allSlides.add(Slide(anyVerticalPhoto, bestPairingVerticalPhoto));
    }
  }

  Photo _findBestPairingPhoto(Photo currentPhoto){
    int bestScore = -1;
    int bestIndex = -1;
    int currentPhotoTags =currentPhoto.tags.length;
    
    for(int i=0; i<_newSearchSizeToPreventOverflow; i++){
      int additionalUniqueTags = allPhotos[i].tags.where((tag) => !currentPhoto.tags.contains(tag)).length;
      
      int totalUniqueTags =currentPhotoTags + additionalUniqueTags;

      if(totalUniqueTags > bestScore){
        bestScore = totalUniqueTags;
        bestIndex = i;
      }
    }
    print('Best score $bestScore @$bestIndex ${allPhotos.length} : ${allSlides.length}');

    return allPhotos.removeAt(bestIndex);
  }

  int get _newSearchSizeToPreventOverflow => min(allPhotos.length, 100);

}