class Screen {
  String search;//name
  int sortValue, searchByValue;
  boolean hasMainWidget;
  String author, title, url;//mainAuthor etc,

  Screen(String search, boolean hasMainWidget, String author, String title, String url) {
    this.search=search;
    sortValue = int(querycp5.get("Queries").getValue());
    searchByValue = int(querycp5.get("Search By").getValue());
    this.hasMainWidget=hasMainWidget;
    this.author=author;
    this.title=title;
    this.url=url;

    //ew
    Screen lastScreen;
    if (currentScreen > 0)  lastScreen = screens.get(currentScreen-1);
    else {
      addNewScreen();
      return;
    }
    
    //if same as previous screen
    if (!(search.equals(lastScreen.getSearch()) &&
      sortValue == lastScreen.getSortValue() &&
      searchByValue == lastScreen.getSearchByValue())) {
      addNewScreen();
    }
    
    setWidgets();
  }

  String getTitle() {
    return title;
  }
  String getAuthor() {
    return author;
  }
  String getUrl()
  {
    return url;
  }

  void addNewScreen() {
    
    //remove all screens that can't be accessed anymore
    screens.subList(currentScreen+1, screens.size()).clear();
    
    screens.add(this);
    
    if (screens.size() < MAX_SCREENS) {
      currentScreen++;
    } else {
      screens.remove(0);
    }

    setPageArrowColours();
  }

  void setCurrentScreen() {
    setWidgets();
    getResults();
  }

  void setWidgets() {
    //reset widgets
    querycp5.get(Controller.class, "Queries").setBroadcast(false);
    querycp5.get(Controller.class, "Search By").setBroadcast(false);
    
    
    querycp5.get(DropdownList.class, "Queries").setOpen(false);
    querycp5.get(DropdownList.class, "Search By").setOpen(false);
    cp5.get(DropdownList.class, "Suggestions").setOpen(false);
    slidercp5.get(Slider.class, "slider").setValue(slidercp5.get(Slider.class, "slider").getMax());

    //set ddl values
    querycp5.get("Queries").setValue(sortValue);
    querycp5.get("Search By").setValue(searchByValue);
    
    slidercp5.get(Slider.class, "slider").setBroadcast(true);
    querycp5.get(Controller.class, "Queries").setBroadcast(true);
    querycp5.get(Controller.class, "Search By").setBroadcast(true);
    cp5.get(Controller.class, "Suggestions").setBroadcast(true);
  }

  //name
  void getResults() {
  }

  String getSearch() {
    return search;
  }
  int getSortValue() {
    return sortValue;
  }
  int getSearchByValue() {
    return searchByValue;
  }
}
class StoryScreen extends Screen {
  StoryScreen(String search, boolean hasMainWidget, String author, String title, String url) {
    super(search, hasMainWidget, author, title, url);
  }

  @Override
    void getResults() {
    if (!search.equals("")) {
      ArrayList<String> searchResults = applySearchByQuery(search);
      searchListStory = toStoryList(searchResults, NUM_SEARCH_RESULTS);
    } else {
      searchListStory = applyQueryFromEmpty(NUM_SEARCH_RESULTS);
    }
    searchListStory = applyQueryFromSearch(searchListStory);
    int y = hasMainWidget ? RESULTS_MARGIN+MAIN_MARGIN+MAIN_AUTHOR_FONT_H : MAIN_MARGIN;
    toWidgetStories(searchListStory, y);
    if (hasMainWidget) addMainAuthorWidget(search);

    setSliderRange(TOTAL_RESULTS_H*searchListStory.size()+MAIN_MARGIN+MAIN_AUTHOR_FONT_H);
    querycp5.get(DropdownList.class, "Queries").setItems(DDL_SORT_BY_STORY);
  }
}

class CommentScreen extends Screen {
  CommentScreen(String search, boolean hasMainWidget, String author, String title, String url) {
    super (search, hasMainWidget, author, title, url);
  }

  @Override
    void getResults() {
    titleEvent(search);
  }
}

/*
class Screen0 {
 //note that screen is always of size SCREEN_W and SCREEN_H (might be some case where we don't want this?)
 
 //list of names of each widget, which can be accessed with cp5.get(name)
 ArrayList<String> widgetList;
 color backgroundColour;
 
 
 
 
 //contruct a screen with a background color
 Screen0(color backgroundColour) {
 this.backgroundColour = backgroundColour;
 widgetList = new ArrayList<String>();
 }
 
 //adds widget to screen's widgetList
 //note: need to either add to screen before initial current screen is set, or redo 'setCurrentScreen'
 //as using screen.addWidget also hides that widget
 void add(String newWidget) {
 widgetList.add(newWidget);
 cp5.get(newWidget).hide();
 }
 void add(Controller newWidget) {
 widgetList.add(newWidget.getName());
 newWidget.hide();
 }
 void add(ControllerGroup newWidget) {
 widgetList.add(newWidget.getName());
 newWidget.hide();
 }
 
 void add(int index, String newWidget) {//~
 widgetList.add(index, newWidget);
 cp5.get(newWidget).hide();
 }
 
 //returns widgetList
 ArrayList<String> getList() {
 return widgetList;
 }
 
 //returns true if this screen has a given widget
 boolean contains(String widget) {
 return widgetList.contains(widget);
 }
 boolean contains(Controller widget) {
 return widgetList.contains(widget.getName());
 }
 boolean contains(ControllerGroup widget) {
 return widgetList.contains(widget.getName());
 }
 
 //returns backgroundColour
 color getBackgroundColour() {
 return backgroundColour;
 }
 
 //sets this screens background colour
 void setBackgroundColour(color backgroundColour) {
 this.backgroundColour = backgroundColour;
 //if (currentScreen == this) currentBackgroundColour = this.backgroundColour;
 }
 
 
 //~implement
 void remove(String widget) {
 }
 
 void remove(Controller widget) {
 //get widget from list and remove
 }
 
 void remove(ControllerGroup widget) {
 }
 
 void removeAll() {
 for (int i = 0; i < widgetList.size(); i++) {
 cp5.remove(widgetList.get(i));
 }
 }
 
 void clear() {//~
 widgetList = new ArrayList<String>();
 //for (int i = 0; i < widgetList.size(); i++) {//might be a nicer way
 //  widgetList.set(i, "");
 //}
 }
 }
 
 //note: maybe should just be in GUI
 
 
 //sets nextScreen to be the current screen
 public void setCurrentScreen(Screen nextScreen) {
 
 //hide any widgets from current screen
 if (currentScreen != null) {
 for (int i = 0; i< currentScreen.widgetList.size(); i++) {
 cp5.get(currentScreen.widgetList.get(i)).hide();
 }
 }
 
 //set to next screen
 currentScreen = nextScreen;
 
 //show current screen
 for (int i = 0; i< currentScreen.widgetList.size(); i++) {
 cp5.get(currentScreen.widgetList.get(i)).show();
 }
 
 //set currentBackgroundColour
 currentBackgroundColour = nextScreen.getBackgroundColour();
 }
 
 
 //sets nextScreen to be the current set of screens
 public void setCurrentScreen(Screen[] nextScreens) {//~changed
 
 //hide any widgets from current screen
 if (currentScreen != null) {
 for (int i = 0; i< currentScreen.widgetList.size(); i++) {
 cp5.get(currentScreen.widgetList.get(i)).hide();
 }
 }
 
 
 //set and show current screens
 for (int screen = 0; screen < nextScreens.length; screen++) {
 for (int i = 0; i < nextScreens[screen].widgetList.size(); i++) {
 currentScreen.add(nextScreens[screen].widgetList.get(i));
 cp5.get(nextScreens[screen].widgetList.get(i)).show();
 }
 }
 
 //set currentBackgroundColour
 currentBackgroundColour = nextScreens[0].getBackgroundColour();//~
 }*/
