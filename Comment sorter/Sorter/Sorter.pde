import java.io.*;
BufferedReader reader;
String line;
ArrayList<JSONObject>stories, comments;
JSONObject ob;
JSONArray arr;

void setup() {
  comments = new ArrayList<JSONObject>();
  reader = createReader("entries.txt");
  while (true) {
    try {
      line = reader.readLine();
    }
    catch(Exception e) {
      line=null;
    }
    try {
      if (line==null) {
        break;
      } else
        ob = parseJSONObject(line);
      if (ob.getString("type").equals("story")) {
        stories.add(ob);
      } else if (ob.getString("type").equals("comment")) {
        comments.add(ob);
      }
    }
    catch(NullPointerException e) {
    }
  }
  println(comments.size());

  quicksort(comments, 0, comments.size()-1, COMMENT_TIME);
  arr = new JSONArray();
  for (int i =0; i<comments.size(); i++) {
    arr.append(comments.get(i));
    //saveJSONObject(comments.get(i), "data/commentsByTime.json", "compact");
  }
  saveJSONArray(arr, "data/commentsByTime.json");
}

void exch(ArrayList<JSONObject> list, int a, int b) {
  JSONObject t = list.get(a);
  JSONObject s= list.get(b);
  list.remove(a);
  list.add(a, s);
  list.remove(b);
  list.add(b, t);
}

void quicksort(ArrayList<JSONObject>a, int low, int high, String filter) {
  int pi;
  if (low<high) {
    pi = partition(a, low, high, filter);
    if (pi!=-1) {
      quicksort(a, low, pi-1, filter);
      quicksort(a, pi+1, high, filter);
    }
  }
}

int partition(ArrayList<JSONObject>a, int low, int high, String filter) {
  long pivot;
  switch(filter) {
    case(COMMENT_TIME):
    case(STORY_TIME):
    {
      if (!a.get(high).isNull("time")) {
        pivot = a.get(high).getInt("time");
      } else 
      pivot =0;
      int i =low-1;
      for (int j=low; j<=high-1; j++) {
        if (!a.get(j).isNull("time")) {
          if (a.get(j).getInt("time")<=pivot) {
            i++;
            exch(a, i, j);
          }
        } else if (0<=pivot) {
          i++;
          exch(a, i, j);
        }
      }
      exch(a, i+1, high);
      return i+1;
    }

    case(STORY_SCORE):
    {
      if (!a.get(high).isNull("score")) {
        pivot = a.get(high).getInt("score");
      } else 
      pivot =0;
      int i =low-1;
      for (int j=low; j<=high-1; j++) {
        if (!a.get(j).isNull("score")) {
          if (a.get(j).getInt("score")<=pivot) {
            i++;
            exch(a, i, j);
          }
        } else if (0<=pivot) {
          i++;
          exch(a, i, j);
        }
      }
      exch(a, i+1, high);
      return i+1;
    }
    case(STORY_KIDS):
    {
      if (!a.get(high).isNull("kids")) {
        pivot = a.get(high).getJSONArray("kids").size();
      } else 
      pivot =0;
      int i =low-1;
      for (int j=low; j<=high-1; j++) {
        if (!a.get(j).isNull("kids")) {
          if (a.get(j).getJSONArray("kids").size()<=pivot) {
            i++;
            exch(a, i, j);
          }
        } else if (0<=pivot) {
          i++;
          exch(a, i, j);
        }
      }
      exch(a, i+1, high);
      return i+1;
    }
  }
  return -1;
}
