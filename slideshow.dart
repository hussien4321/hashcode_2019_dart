import 'photo.dart';
import 'slide.dart';
import 'dart:math';

class Slideshow{
  int controlThreshold = 20;

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

    if(allPhotos.isNotEmpty){
      this.allPhotos.sort((photoA, photoB) => -photoA.tags.length.compareTo(photoB.tags.length));
      print(allPhotos.first);
      print(allPhotos.last);
    }
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
      Photo longestVerticalPhoto = allPhotos.removeLast();
      Photo bestPairingVerticalPhoto = _findBestPairingPhoto(longestVerticalPhoto);

      allSlides.add(Slide(longestVerticalPhoto, bestPairingVerticalPhoto));
    }
  }

  Photo _findBestPairingPhoto(Photo currentPhoto){
    int bestScore = -1;
    int bestIndex = -1;
    int currentPhotoTags =currentPhoto.tags.length;
    
    for(int i=0; i<_newSearchSizeToPreventOverflow; i++){
      if(allPhotos[i].tags.where((tag) => currentPhoto.tags.contains(tag)).length == 0){
        bestIndex = i;
        bestScore =currentPhotoTags + allPhotos[i].tags.length;
        break;
      }
    }

    if(bestIndex == -1){
      bestIndex = 0;
      bestScore = currentPhotoTags + allPhotos[0].tags.length;
    }
    print('Best score $bestScore @$bestIndex ${allPhotos.length} : ${allSlides.length}');

    return allPhotos.removeAt(bestIndex);
  }

  int get _newSearchSizeToPreventOverflow => min(10000, allPhotos.length);

}