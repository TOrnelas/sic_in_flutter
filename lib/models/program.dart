class Program{

  DateTime startTime;
  num duration;

  String title;
  String description;
  String imageUrl;
  String externalUrl;

  Program(this.startTime, this.duration, this.title, this.description, this.imageUrl, this.externalUrl);

  String getStartEndWithFormat() {

    var endTime = startTime.add(new Duration(milliseconds: duration));

    return startTime.hour.toString() + ":" + startTime.minute.toString() + "h - "
        + endTime.hour.toString() + ":" + endTime.minute.toString() + "h";
  }
}