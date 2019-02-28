class Photo {
  int id;
  bool isHorizontal;
  List<String> tags;
  

  Photo(String data, this.id){
    List<String> separatedData = data.split(' ').toList();
    this.isHorizontal = separatedData.removeAt(0) == 'H';
    separatedData.removeAt(0);
    tags = separatedData;
  }

  @override
  String toString() => "PHOTO: ${isHorizontal ? 'H' : 'V'} $id $tags";
}