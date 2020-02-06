enum EventCatagory {
  Sports,
  Technical_Fest,
  Music,
  Dance,
  Gaming,
  Dramatics_Speakin_Arts,
  Literary,
  Lifestyle,
  Design_and_Digital,
  Intra_College,
  Miscelleneous,
  Mega_a_thon
}

Map <EventCatagory, EventCatModel> EventCatMap ={
   EventCatagory.Sports : EventCatModel(Name: "Sports", BackgroundUrl: "assets/catagory/cyborg.png")
};


class EventCatModel{
  String Name;
  String BackgroundUrl;

  EventCatModel({this.Name= "", this.BackgroundUrl =""});


}