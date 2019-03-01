import 'io.dart';
import 'solver.dart';
import 'slide.dart';
import 'slideshow.dart';


main() async {
  print('Hello hashcode 2019');
  List<String> filenames = [
    // "a_example",
    // "b_lovely_landscapes",
    // "c_memorable_moments",
    // "d_pet_pictures", 
    "e_shiny_selfies",
  ];

  for(String filename in filenames){
    List<String> data = await IOOperations.importFile("./inputs/$filename.txt");

    print('loading photos...');
    Slideshow slideshow = Slideshow(data);

    print('converting into unordered slides...');
    List<Slide> unorderedSlides = slideshow.covertAllPhotosToUnorderedSlides();

    Solver slideshowSolver = Solver(unorderedSlides);

    print('ordering slides...');
    List<Slide> orderedSlides = slideshowSolver.solve();

    print('SCORE IS ${slideshowSolver.calculateInterestScoreOfSlideShow(orderedSlides)}');

    print('writing to file...$filename');
    IOOperations.writeResultToFile("./outputs/$filename.txt", orderedSlides);
  }
}