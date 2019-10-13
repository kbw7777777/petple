class Location {
  //final String street;
  final String city;
  final String state;

  Location(this.city, this.state);

  Location.fromJson(Map<String, dynamic> json)
      //: street = json["street"],
       : city = json["city"],
        state = json["state"];

        
}
