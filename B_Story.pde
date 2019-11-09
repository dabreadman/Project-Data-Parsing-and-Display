import java.util.Date;
public class Story {
  ArrayList<Integer>kids;
  int descendants, score, id;
  String url, title, by;
  JSONArray kidsArray;
  long time;

  //assign attributes of JSON4
  //defensive coding as some entires lack some attributes
  Story(JSONObject j) {
    kids = new ArrayList<Integer>();
    //adding defensive code to try handle errors
    if (!j.isNull("url")) {
      url = j.getString("url");
    } else {
      url = "";
    }
    if (!j.isNull("title")) {
      title = formatString(j.getString("title"));
    } else {
      title = "";
    }
    if (!j.isNull("by")) {
      by = j.getString("by");
    } else {
      by = "";
    }
    if (!j.isNull("descendants")) {
      descendants = j.getInt("descendants");
    } else {
      descendants = 0;
    }
    if (!j.isNull("score")) {
      score = j.getInt("score");
    } else {
      score = 0;
    }
    if (!j.isNull("time")) {
      time =  j.getInt("time");
    } else {
      time = 0;
    }
    if (!j.isNull("id")) {
      id = (j.getInt("id"));
    } else {
      id = 0;
    }
    //kidsArray =   j.getJSONArray("kids");

    if (!j.isNull("kids")) {
      kidsArray =   j.getJSONArray("kids");
      for (int i = 0; i < kidsArray.size(); i++) {
        kids.add((int)kidsArray.get(i));
      }
    } else {
      kids = null;
    }
  }



  //returns a text interpretation of the object
  String toString() {
    return("url:"+url+" title:"+title+" by:"+by+" score:"+score+" time:"+this.getDate()+" id:"+id);
  }

  //returns a wrapped text interpretation of the object
  String toStringWrap() {
    return("url:"+url+
      "\ntitle:"+title+
      "\nby:"+by+
      "\nscore:"+score+
      "\ntime:"+this.getDate()+
      "\nid:"+id);
  }

  //Display date by converting the UNIX time value to a date
  String getDate() {
    Date date = new Date(time*1000);
    return(date.toString());
  }
  String printTime() {
    return Long.toString(time);
  }
  
  int getId(){
    return id;
  }
  ArrayList<Integer> getKids(){
    return kids;
  }
  JSONArray getKidsJ(){
    return kidsArray;
  }
  
  String getTitleUC(){
  return title.toUpperCase();
  }
  
  String getTitleLC() {
    return title.toLowerCase();
  }
  
  String getTitle() {//should really swap this and getTitle
    return title;
  }
  
  String getAuthorUC(){
    return by.toUpperCase();
  }
  
  String getAuthorLC() {
    return by.toLowerCase();
  }
  
  String getAuthor() {
    return by;
  }
  
  void setTitle(String title) {
    this.title = title;
  }
  
  void setAuthor(String by) {
    this.by = by;
  }
  
  //void setDate(String date) {
  //  this.time = date;
  //}
  
  String getUrl() {
    return url;
  }
}
