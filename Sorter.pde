import java.io.*;
JSONArray arr;

void sorter() {
  println("here");
  stories = new ArrayList<JSONObject>();
  comments = new ArrayList<JSONObject>();
  reader = createReader("data/entries.txt");
  BufferedReader r = createReader("data/size.txt");
  File f = new File("data/entries.txt");
  File g = new File("size.txt");
  //Scanner s;
  try {
    //s = new Scanner(new File("data/size.txt"));
    //if data size isn't the same then sort, otherwise the old values are fine to use
    if (f.length()==Long.parseLong(r.readLine())) {
      //
      r.close();
      background(150);
      text("currently sorting new data, might take a while!", 50, 50);
      try {
        println("trying to get file");
        FileWriter writer = new FileWriter(g);
        println("got file");
        writer.write((""));
        String st = String.valueOf(f.length());
        writer.write(st);
        writer.close();
        println("done");
      }
      catch(FileNotFoundException e) {
        println(e);
      }
      println("sorting");
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
      //println(stories.size());
      //println(comments.size());
      println("time sort");
      quicksort(stories, 0, stories.size()-1, STORY_TIME);
      arr = new JSONArray();
      for (int i=0; i<stories.size(); i++) {
        arr.append(stories.get(i));
        //println(i);
      }
      saveJSONArray(arr, "data/storyByTime.json"); 
      println("fin");

      quicksort(stories, 0, stories.size()-1, STORY_SCORE);
      arr = new JSONArray();
      for (int i=0; i<stories.size(); i++) {
        arr.append(stories.get(i));
      }
      saveJSONArray(arr, "data/storyByScore.json");

      quicksort(stories, 0, stories.size()-1, STORY_KIDS);
      arr = new JSONArray();
      for (int i=0; i<stories.size(); i++) {
        arr.append(stories.get(i));
      }
      saveJSONArray(arr, "data/storyByKids.json");
      println("comment sort");
      text("Stories sorted, now onto the comments!", 50, 100);
      quicksort(comments, 0, comments.size()-1, COMMENT_TIME);
      arr = new JSONArray();
      for (int i =0; i<comments.size(); i++) {
        arr.append(comments.get(i));
      }
      saveJSONArray(arr, "data/commentsByTime.json");
      println("done sort");
    }
  }
  catch(Exception e) {
    // only here so that s is initialised, should never end up being used
    // is used can't work out why
    println("s bad");
  }
}

void exchJSON(ArrayList<JSONObject> list, int a, int b) {
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
            exchJSON(a, i, j);
          }
        } else if (0<=pivot) {
          i++;
          exchJSON(a, i, j);
        }
      }
      exchJSON(a, i+1, high);
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
            exchJSON(a, i, j);
          }
        } else if (0<=pivot) {
          i++;
          exchJSON(a, i, j);
        }
      }
      exchJSON(a, i+1, high);
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
            exchJSON(a, i, j);
          }
        } else if (0<=pivot) {
          i++;
          exchJSON(a, i, j);
        }
      }
      exchJSON(a, i+1, high);
      return i+1;
    }
  }
  return -1;
}

void loader(ArrayList<Story>Score, ArrayList<Story>Time, ArrayList<Story>Kids, ArrayList<Comment>CTime) {
  println("loader");
  storyArr = loadJSONArray("data/storyByScore.json");

  for (int i =0; i<storyArr.size(); i++) {
    //println(storyArr.getJSONObject(i).toString());
    if (storyArr.getJSONObject(i).isNull("deleted")&&storyArr.getJSONObject(i).isNull("dead")) {
      Story s = new Story(storyArr.getJSONObject(i));
      Score.add(s);
    }
  }

  storyArr = loadJSONArray("data/storyByKids.json");

  for (int i =0; i<storyArr.size(); i++) {
    if (storyArr.getJSONObject(i).isNull("deleted")&&storyArr.getJSONObject(i).isNull("dead")) {
      Story s = new Story(storyArr.getJSONObject(i));
      Kids.add(s);
    }
  }

  storyArr = loadJSONArray("data/storyByTime.json");

  for (int i =0; i<storyArr.size(); i++) {
    if (storyArr.getJSONObject(i).isNull("deleted")&&storyArr.getJSONObject(i).isNull("dead")) {
      Story s = new Story(storyArr.getJSONObject(i));
      Time.add(s);
    }
  }

  commentArr = loadJSONArray("data/commentsByTime.json");

  for (int i =0; i<storyArr.size(); i++) {
    if (commentArr.getJSONObject(i).isNull("deleted")&&commentArr.getJSONObject(i).isNull("dead")) {
      CTime.add(new Comment(commentArr.getJSONObject(i)));
    }
  }
}
