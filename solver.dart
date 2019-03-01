import 'dart:math';
import 'slide.dart';

class Solver{

  int controlThreshold = 0;

  List<Slide> sortedSlides;
  List<Slide> currentSlides;

  Solver(List<Slide> slides){
    this.currentSlides = slides;
    this.sortedSlides = [];
  }


  List<Slide> solve() {
    

    currentSlides.sort((slideA, slideB) => slideA.tags.length.compareTo(slideB.tags.length));
    // currentSlides.sort((slideA, slideB) => _calculateInterestScore(slideA, slideB));
    _initialiseSlideshow();

    while(currentSlides.isNotEmpty){

      _appendBestMatchingSlideToTheEndOfSlideshow();

      if(currentSlides.isNotEmpty){
        _appendBestMatchingSlideToTheStartOfSlideshow();
      }

    }

    return sortedSlides;
  }

  _initialiseSlideshow(){
    Slide initialSlide = currentSlides.removeLast();//TOOD: Could be randomised for potentially better score

    sortedSlides.add(initialSlide);
  }

  _appendBestMatchingSlideToTheEndOfSlideshow(){
    Slide slideAtEnd = sortedSlides.last;
    
    int bestScore = -1;
    int bestIndex = -1;


    for(int i = 0; i < _newIndexToPreventOverFlow; i++){

      int currentScore = _calculateInterestScore(currentSlides[i], slideAtEnd);
    
      if(currentScore > bestScore){
        bestScore = currentScore;
        bestIndex = i;
      }
      
      if(currentScore >= 3){
        break;
      }
    }

    print('Best slide score $bestScore @$bestIndex - ${currentSlides.length} : ${sortedSlides.length}');

    sortedSlides.add(currentSlides.removeAt(bestIndex));

  }
  _appendBestMatchingSlideToTheStartOfSlideshow(){
    Slide slideAtStart = sortedSlides.first;
    
    int bestScore = -1;
    int bestIndex = -1;

    
    for(int i = 0; i < _newIndexToPreventOverFlow; i++){
      
      int currentScore = _calculateInterestScore(currentSlides[i], slideAtStart);
    
      if(currentScore > bestScore){
        bestScore = currentScore;
        bestIndex = i;
      }

      if(currentScore >= 3){
        break;
      }

    }

    print('Best slide score $bestScore @$bestIndex - ${currentSlides.length} : ${sortedSlides.length}');

    sortedSlides.insert(0, currentSlides.removeAt(bestIndex));

  }

  // Slide getBestMatchingSlide(Slide matchingSlide){
  //   currentSlides.firstWhere((slide) {
  //     int maxScore = (matchingSlide.tags.length/2).floor();
  //     return _calculateInterestScore(slide, matchingSlide) == maxScore;
  //   }, orElse: () => currentSlides.first);
  // }

  int get _newIndexToPreventOverFlow => min(currentSlides.length, currentSlides.length);

  int _calculateInterestScore(Slide slideA, Slide slideB) {
    
    int tagsInAnotInB = slideA.tags.where((tag) => !slideB.tags.contains(tag)).length;
    int tagsInCommon = slideA.tags.length - tagsInAnotInB;
    int tagsInBnotInA = slideB.tags.where((tag) => !slideA.tags.contains(tag)).length;
  
    return min(tagsInCommon, min(tagsInAnotInB,tagsInBnotInA));
  }


  //Done in 15 mins, proved to be a very bad solution lol
  List<Slide> solveRandomly() {
    int bestScore = -1;
    List<Slide> bestSortedSolution = [];
    
    sortedSlides = currentSlides;
    int numberOfAttempts = 1000;
    
    for(int i=0; i<numberOfAttempts; i++){

      sortedSlides.shuffle();
      int currentScore = calculateInterestScoreOfSlideShow(sortedSlides);
      if(currentScore > bestScore){
        bestScore = currentScore;
        print('CURRENT BEST SCORE: $bestScore @$i');
        bestSortedSolution = sortedSlides.map((a)=> a).toList();
      }
    }

    return bestSortedSolution;

  }

  int calculateInterestScoreOfSlideShow(List<Slide> slidesToBeMeasured){
    int totalInterestScore = 0;
    for(int i=0; i<slidesToBeMeasured.length-1;i++){
      totalInterestScore += _calculateInterestScore(slidesToBeMeasured[i], slidesToBeMeasured[i+1]);
    }
    return totalInterestScore;
  }

}
