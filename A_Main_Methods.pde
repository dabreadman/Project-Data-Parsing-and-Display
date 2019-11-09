//swaps arraypositions so newest is at index 0, oldest at final index
int nullComments = 0; 
ArrayList<Story> newestStory(ArrayList<Story> base) {
  ArrayList<Story> a = base;
  for (int i = 0; i < base.size(); i++) {
    int min = i;
    for (int j = i + 1; j <= base.size() -1; j++) {
      if (less(a.get(j).time, a.get(min).time)== true) {
        min = j;
        exch(a, j, min);
      }
    }
  }
  ArrayList<Story> b = new ArrayList<Story>();

  for (int i = 0; i < base.size()-1; i++) {
    b.add(i, a.get(base.size() -1 - i));
  }
  return b;
}

//swaps so oldest is at index 0 and newest at final index
ArrayList<Story> oldestStory(ArrayList<Story> base) {
  ArrayList<Story> a = base;
  for (int i = 0; i < base.size(); i++) {
    int min = i;
    for (int j = i + 1; j <= base.size() -1; j++) {
      if (less(a.get(j).time, a.get(min).time)== true) {
        min = j;
        exch(a, j, min);
      }
    }
  }
  return a;
}

ArrayList<Comment> oldestComment(ArrayList<Comment> base) {
  ArrayList<Comment> a = base;
  for (int i = 0; i < base.size(); i++) {
    int min = i;
    for (int j = i + 1; j <= base.size() -1; j++) {
      if (less(a.get(j).time, a.get(min).time)== true) {
        min = j;
        exchComment(a, j, min);
      }
    }
  }
  return a;
}

ArrayList<Comment> newestComment(ArrayList<Comment> base) {
  ArrayList<Comment> a = base;
  for (int i = 0; i < base.size(); i++) {
    int min = i;
    for (int j = i + 1; j <= base.size() -1; j++) {
      if (less(a.get(j).time, a.get(min).time)== true) {
        min = j;
        exchComment(a, j, min);
      }
    }
  }
  ArrayList<Comment> b = new ArrayList<Comment>();
  for (int i = 0; i < base.size()-1; i++) {
    b.add(i, a.get(base.size() -1 - i));
  }
  return b;
}

// if a < b
// return true
boolean less(long a, long b) {
  return a < b;
}

// swaps positions in the array
void exch(ArrayList<Story> list, int a, int b) {
  Story t = list.get(a);
  Story s= list.get(b);
  list.remove(a);
  list.add(a, s);
  list.remove(b);
  list.add(b, t);
}

void exchComment(ArrayList<Comment> list, int a, int b) {
  Comment t = list.get(a);
  Comment s= list.get(b);
  list.remove(a);
  list.add(a, s);
  list.remove(b);
  list.add(b, t);
}


// gets the first amtToTake results from an ArrayList and returns them in another ArrayList
ArrayList<Story> getResultsStory(ArrayList<Story>base, int amtToTake) {
  if (base.size()>amtToTake) {
    ArrayList<Story>a = new ArrayList<Story>();
    for (int i=0; i<amtToTake; i++) {
      a.add(base.get(i));
    }
    return a;
  } else
    return base;
}

ArrayList<Story> getResultsStory(ArrayList<Story>base, int startIndex, int amtToTake) {
  if (base.size()-startIndex<amtToTake) {
    ArrayList<Story>a = new ArrayList<Story>();
    for (int i=startIndex; i<amtToTake; i++) {
      a.add(base.get(i));
    }
    return a;
  } else
    return base;
}


// gets the first amtToTake results from an ArrayList and returns them in another ArrayList
ArrayList<Comment> getResultsComment(ArrayList<Comment>base, int amtToTake) {
  if (base.size()>amtToTake) {
    ArrayList<Comment>a = new ArrayList<Comment>();
    for (int i=0; i<amtToTake; i++) {
      a.add(base.get(i));
    }
    return a;
  } else
    return base;
}

ArrayList<Comment> getResultsComment(ArrayList<Comment>base, int startIndex, int amtToTake) {
  if (base.size()-startIndex>amtToTake) {
    ArrayList<Comment>a = new ArrayList<Comment>();
    for (int i=startIndex; i<amtToTake; i++) {
      a.add(base.get(i));
    }
    return a;
  } else
    return base;
}
// Takes the "id" of a passed story and finds all comments that have the same value in their "parent" location
// returns ArrayList of comments
ArrayList<Comment> getCommentsForStory(Story s) {
  ArrayList<Comment> a = new ArrayList<Comment>();
  if (s != null) {
    for (int i = 0; i < commentList.size(); i++) {
      if (commentList.get(i).parent == s.id) {
        a.add(commentList.get(i));
      }
    }
  }
  return a;
}
// pass author's name and get arraylist of all stories that they've posted
ArrayList<Story> findAuthor(String authorName) {
  ArrayList<Story> a = new ArrayList<Story>();
  for (int i = 0; i < storyList.size(); i++) {
    if (storyList.get(i).by.matches(authorName)) {
      a.add(storyList.get(i));
    }
  }
  //for (int i =0; i < a.size(); i++){
  //  println(a.get(i).toString());
  //}
  return a;
}

// pass author's name and get arraylist of ids of all stories that they've posted
ArrayList<Integer> findIdsBy(String authorName) {
  ArrayList<Integer> a = new ArrayList<Integer>();
  for (int i = 0; i < storyList.size(); i++) {
    if (storyList.get(i).by.matches(authorName)) {
      a.add(storyList.get(i).getId());
    }
  }
  //for (int i =0; i < a.size(); i++){
  //  println(a.get(i).toString());
  //}
  return a;
}

//returns result (len) of story in string form
String getResultString(int len) {
  ArrayList<Story> storyArr = getResultsStory(storyList, len);
  String str = "";
  for (int i=0; i<storyArr.size(); i++) {
    Story story = storyArr.get(i);
    str+=String.format("\n-----------\nNo.%s\n", i+1);
    str+=story.toStringWrap();
  }
  str+="\n-----------";
  str = str.replaceAll("(?m)^[ \t]*\r?\n", "");
  return str;
}

//
void updateTextLabel(String str, Textlabel txtLabel) {
  txtLabel.setText(str);
}

//*findCommentsCount throwing NullPointer
//----------------------------------------------
//find a comment by matching the id
Comment findComment(int id) {
  for (int i =0; i<commentList.size(); i++) {
    if (commentList.get(i).getId()==id)
      return commentList.get(i);
  }
  return null;
}

//find comments that is a kid of the story
ArrayList<Comment>findComment(Story s) {
  ArrayList<Integer>kids = s.getKids();

  ArrayList<Comment> arr = new ArrayList<Comment>();
  for (int i = 0; i < kids.size(); i++) {
    arr.add(findComment(kids.get(i)));
  }
  return arr;
}  

//find total comments that is linked to a comment
int findCommentsCount (Comment comment) {
  int count = 1;
  if (comment!=null) {
    //println("starting fCC(s) Comment:"+comment.getId());

    //println("starting fCC(c)");
    ArrayList<Integer>kids = new ArrayList<Integer>();
    kids = comment.getKids();
    //println("ending fCC(c)");
    //println("in loop"+kids);
    //println("kids(0)"+kids.get(0));
    if (kids.get(0)>=1) {
      count=1;
      for (int i =0; i<kids.size(); i++) {
        count= count + findCommentsCount(findComment(kids.get(i)));
      }
    } else {
    }
  }
  return count;
}

//find total comments linked to a story
int findCommentCount(Story s) {
  //println("starting fCC(s)");
  ArrayList<Comment> arr = findComment(s);
  int count = 0;
  //println("starting fCC(for)");
  for (int i=0; i<arr.size(); i++) {
    //println("starting fCC(L)for: "+arr.get(i));
    count= count + findCommentsCount(arr.get(i));
  }
  return count;
}
//-----------------------------------------------
// returns arrayList of stories with the highest score in index 0
ArrayList<Story> highScore (ArrayList<Story> base) {
  ArrayList<Story> a = base;
  for (int i = 0; i < base.size(); i++) {
    int min = i;
    for (int j = i + 1; j <= base.size() -1; j++) {
      if (less(a.get(j).score, a.get(min).score)== true) {
        min = j;
        exch(a, j, min);
      }
    }
  }
  ArrayList<Story> b = new ArrayList<Story>();

  for (int i = 0; i < base.size()-1; i++) {
    b.add(i, a.get(base.size() -1 - i));
  }
  return b;
}
ArrayList<Story> lowScore (ArrayList<Story> base) {
  ArrayList<Story> a = base;
  for (int i = 0; i < base.size(); i++) {
    int min = i;
    for (int j = i + 1; j <= base.size() -1; j++) {
      if (less(a.get(j).time, a.get(min).time)== true) {
        min = j;
        exch(a, j, min);
      }
    }
  }
  return a;
}
ArrayList<Story> website(ArrayList<Story> base, String url) {
  ArrayList<Integer> a = new ArrayList();
  for (int i = 0; i < base.size(); i++) {
    String str = base.get(i).url;
    char[] b = str.toCharArray();
    int index = 0;
    for (int j = 0; j < b.length; j++) {
      if (b[j] == '.' && b[j+1] == 'c' && b[j+2] == 'o' && b[j+3] == 'm') {
        index = j;
      }
      String newStr = str.substring(0, index);
      newStr = newStr.replace("https//www.", "");
      if (newStr.matches(url)) {
        a.add(i);
      }
    }
  }
  ArrayList<Story> c = new ArrayList<Story>();
  for ( int i = 0; i < a.size(); i++) {
    c.add(base.get(a.get(i)));
  }
  return c;
}


//Creates partition for use in quicksortStory
//Currently sorts for SCORE and TIME, can be added to
int partitionStory(ArrayList<Story>a, int low, int high, String filter) {
  switch(filter) {
    case(SCORE):
    {
      int pivot = a.get(high).score;
      int i =low-1;
      for (int j=low; j<=high-1; j++) {
        if (a.get(j).score<=pivot) {
          i++;
          exch(a, i, j);
        }
      }
      exch(a, i+1, high);
      return i+1;
    }

    case(TIME):
    {
      long pivot = a.get(high).time;
      int i =low-1;
      for (int j=low; j<=high-1; j++) {
        if (a.get(j).time<=pivot) {
          i++;
          exch(a, i, j);
        }
      }
      exch(a, i+1, high);
      return i+1;
    }

    // not sure if kids.size() is the correct integer to use
    // Change to new attribute if implemented
    case(COMMENTS):
    {
      try {
        long pivot = a.get(high).kids.size();
        int i =low-1;
        for (int j=low; j<=high-1; j++) {
          if (a.get(j).kids.size()<=pivot) {
            i++;
            exch(a, i, j);
          }
        }
        exch(a, i+1, high);
        return i+1;
      }
      catch(NullPointerException e) {
        println("error");
      }
    }
  default:
    return -1;
  }
}

//quicksorts Story array, pass through a filter (TIME,SCORE and COMMENTS are currently implemented) as well as the array you want sorted
//Can be extended to accompany more query types by changing partition
ArrayList<Story> quicksortStory(ArrayList<Story>a, int low, int high, String filter) {
  int pi;
  if (low<high && !a.isEmpty()) {
    try {
      pi = partitionStory(a, low, high, filter);

      quicksortStory(a, low, pi-1, filter);
      quicksortStory(a, pi+1, high, filter);
    } 
    catch(StackOverflowError e) {
      println("Stack");
    }
  }
  return a;
}//added return value

//creates partition for comments array in quicksortComment
int partitionComment(ArrayList<Comment>a, int low, int high, String filter) {

  switch(filter) {

    case(TIME):
    {
      long pivot = a.get(high).time;
      int i =low-1;
      for (int j=low; j<=high-1; j++) {
        if (a.get(j).time<=pivot) {
          i++;
          exchComment(a, i, j);
        }
      }
      exchComment(a, i+1, high);
      return i+1;
    }

    // not sure if kids.size() is the correct integer to use
    // Change to new attribute if implemented
    case(COMMENTS):
    {

      long pivot;
      if (a.get(high).kids != null) {
        pivot = a.get(high).kids.size();
      } else {
        pivot = 0;
      }
      int i =low-1;
      try {
        for (int j=low; j<=high-1; j++) {
          if (a.get(j).kids != null) {
            if (a.get(j).kids.size()<=pivot) {
              i++;
              exchComment(a, i, j);
            }
          }
        }
      }      
      catch(NullPointerException e) {
        exchComment(a, low, nullComments++);
      }

      exchComment(a, i+1, high);
      return i+1;
    }


  default:
    return -1;
  }
}


//sorts comments by provided filter, currently only by time and number of kids
//not sure if there's other criteria that comments can be sorted by, but this can be extended if needed
ArrayList<Comment> quicksortComment(ArrayList<Comment>a, int low, int high, String filter) {
  int pi;
  if (low<high && !a.isEmpty()) {
    pi = partitionComment(a, low, high, filter);

    quicksortComment(a, low, pi-1, filter);
    quicksortComment(a, pi+1, high, filter);
  }
  return a;
}

//----------------------------
//case sensitive
Story getStoryByTitle(String title) {
  for (Story story : storyList) {
    if (story.getTitle().equals(title))
      return story;
  }
  return null;
}

//gets story from lower case title
//returns null if story doesnt exist, or is dead
Story getStoryByLCTitle(String title) {
  for (Story story : storyList) {
    if (story.getTitle().toLowerCase().equals(title.toLowerCase()))
      return story;
  }
  return null;//returns null if exists, but is dead
}

ArrayList<Story> getListByAuthor(String title) {
  ArrayList rList = new ArrayList<Story>();
  for (Story story : storyList) {
    if (story.getAuthor().equals(title)) {
      println(story); 
      rList.add(story);
    }
  }
  return rList;
}
String toStringWrap(ArrayList<Story>list) {
  String str = "";
  for (Story story : list) {
    str += "\n"+story.toStringWrap();
  }
  return str;
}

String toTitlesString(ArrayList<Story> stories) {
  String str = "";
  for (Story story : stories) {
    str += "\n"+story.getTitle()+"\n";
  }
  return str;
}



void updateTextArea(String str) {
  cp5.get(Textarea.class, "Text").setText(str);
}

//returns a string representation of an ArrayList<String>
String toString(ArrayList<String> strList) {
  String str = "";
  for (int i = 0; i < strList.size(); i++) {
    str += "\n"+strList.get(i)+"\n";
  }
  return str;
}



//find total comments that is linked to a comment
//void findLinkedComments (Comment comment) {
//  if (comment!=null) {
//    ArrayList<Integer>kids = new ArrayList<Integer>();
//    kids = comment.getKids();

//    if (kids.get(0)>=1) {
//      for (int i =0; i<kids.size(); i++) {
//        if (findComment(kids.get(i))!=null) {
//          resultCommentList.add(findComment(kids.get(i)));
//          findLinkedComments(findComment(kids.get(i)));
//        }
//      }
//    }
//  }
//}

//find total comments linked to a story
//(~~incomplete)
//ArrayList<Comment> findComments(Story s) {
//  ArrayList<Comment> comments = findComment(s);
//  resultCommentList = new ArrayList<Comment>(); 

//  for (int i=0; i<comments.size(); i++) {
//    resultCommentList.add(null);
//    resultCommentList.add(comments.get(i));
//    findLinkedComments(comments.get(i));
//  }
//  return resultCommentList;
//}
