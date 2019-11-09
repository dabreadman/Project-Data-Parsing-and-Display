import java.util.*;

public class Comment {
  ArrayList<Integer>kids;
  int parent, id;
  String text, by;
  JSONArray kidsArray;
  long time;

  // assign attributes of JSON
  Comment(JSONObject j) {
    kids = new ArrayList<Integer>();
    // defensive code
    if (!j.isNull("parent")) {
      parent = j.getInt("parent");
    } else {
      parent = 0;
    }
    if (!j.isNull("text")) {
      text = formatString(j.getString("text"));
    } else {
      text = "";
    }
    if (!j.isNull("by")) {
      by = j.getString("by");
    } else {
      by = "";
    }
    if (!j.isNull("time")) {
      time = j.getInt("time");
    } else {
      time = 0;
    }
    if (!j.isNull("id")) {
      id = j.getInt("id");
    } else {
      id = 0;
    }

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
    return("by: "+by+" parent: "+parent+" time: "+this.getDate()+" id:"+id+" text:"+text);
  }

  //Display date by converting the UNIX time value to a date
  String getDate() {
    Date date = new Date(time*1000);
    return(date.toString());
  }
  String printTime(){
    return Long.toString(time);
  }
  
  ArrayList<Integer> getKids(){
    if (kids==null){
       println("empty"); 
      return new ArrayList<Integer>(Arrays.asList(-1));
    }
    println("not empty");
    return kids;
  }
  
  JSONArray getKidsJ(){
    return kidsArray;
  }
  
  //returns all kids of this comment as an arraylist of comments
  ArrayList<Comment> getKidsAsComments() {
    ArrayList<Comment> kidsC = new ArrayList<Comment>();
    //println(kids==null);
    if (kids != null) {
      for (int id : kids) {
        Comment c = findComment(id);
        if (c != null) kidsC.add(c);
      }
    }
    return kidsC;
  }
  
  int getParent() {
    return parent;
  }
  
  int getId(){
    return id;
  }
  
  String getText(){
    return text;
  }
  
  String getBy(){
    return by;
  }
  
  String getAuthor() {
    return by;
  }
  
}
