class Song{
  late String title;
  late String path;

  Song(this.title, this.path);

  @override
  bool operator ==(Object other) {
    return other is Song && path == other.path;
  }
  
  @override
  // ignore: unnecessary_overrides
  int get hashCode => super.hashCode;
  
  bool isNothingBurger(){
    if(title.isEmpty && path.isEmpty){
      return true;
    }
    else{
      return false;
    }
  }
}