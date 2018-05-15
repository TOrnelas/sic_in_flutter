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
    return  _doubleDigit(startTime.hour)
        + ":"
        +  _doubleDigit(startTime.minute)
        + "h - "
        +  _doubleDigit(endTime.hour)
        + ":"
        +  _doubleDigit(endTime.minute) + "h";
  }

  String getStartWithFormat() {

    return  _doubleDigit(startTime.hour)
        + ":"
        +  _doubleDigit(startTime.minute) + "h";
  }

  _doubleDigit(int time) {

    return time < 10 ? "0" + time.toString() : time.toString();
  }

  isPlayingNow() {

    var endTime = startTime.add(new Duration(milliseconds: duration));
    return startTime.isBefore(new DateTime.now()) && endTime.isAfter(new DateTime.now());
  }

  isFromThePast() {

    var endTime = startTime.add(new Duration(milliseconds: duration));
    return startTime.isBefore(new DateTime.now())
        && endTime.isBefore(new DateTime.now());
  }

  String getStartsAtTime() {

    var endTime = startTime.add(new Duration(milliseconds: duration));
    var now = new DateTime.now();
    return isPlayingNow() ?
    "ends in " + (endTime.subtract(new Duration(milliseconds: now.millisecondsSinceEpoch)).minute.toString()) + " min" :
    "starts at " + getStartWithFormat();
  }
}