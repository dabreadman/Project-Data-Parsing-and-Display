public class TrieNode {
  char c;
  TrieNode parent;
  HashMap<Character, TrieNode> children = new HashMap<Character, TrieNode>();
  boolean isLeaf;

  public TrieNode() {
  }

  public TrieNode(char c, TrieNode parent) {
    this.c = c;
    this.parent = parent;
  }
}

public class Trie {

  private TrieNode root;

  public Trie() {
    root = new TrieNode();
  }

  //adds a word to the trie.
  public void add(String word) {
    HashMap<Character, TrieNode> children = root.children;
    TrieNode parent = root;

    for (int i = 0; i < word.length(); i++) {
      char c = word.charAt(i);

      TrieNode t;
      if (children.containsKey(c)) {
        t = children.get(c);//go down that branch
      } else if (c > 0x41 && c < 0x5A && children.containsKey((char)(c+0x20))) {//uppercase
        t = children.get((char)(c+0x20));
      } else if (c > 0x61 && c < 0x7A && children.containsKey((char)(c-0x20))) {//lowercase
        t = children.get((char)(c-0x20));
      } else {
        t = new TrieNode(c, parent);
        children.put(c, t);//add a new branch
      }

      children = t.children;//go down to next level of branch (if there is one)
      parent = t;//set new parent

      //set leaf node
      if (i == word.length()-1)
        t.isLeaf = true;
    }
  }

  //returns if the word is in the trie.
  public boolean search(String word) {
    TrieNode t = searchNode(word);
    return t != null && t.isLeaf;
  }

  //returns if there is any word that starts with the given prefix.
  public boolean startsWith(String prefix) {
    return searchNode(prefix) != null;
  }

  //returns the node for a given string, or null if that node doesn't exist
  public TrieNode searchNode(String str) {
    Map<Character, TrieNode> children = root.children;
    TrieNode t = null;
    for (int i = 0; i < str.length(); i++) {
      char c = str.charAt(i);
      if (children.containsKey(c)) {
        t = children.get(c);
        children = t.children;
      } else if (c > 0x41 && c < 0x5A && children.containsKey((char)(c+0x20))) {//if uppercase
        t = children.get((char)(c+0x20));
        children = t.children;
      } else if (c > 0x61 && c < 0x7A && children.containsKey((char)(c-0x20))) {//if lowercase
        t = children.get((char)(c-0x20));
        children = t.children;
      } else {
        return null;
      }
    }
    return t;
  }

  //gets all leaf nodes branching from a given root
  //(incomplete) would be nice if ArrayList wasnt param
  //weird with inputs with spaces?
  public ArrayList<String> getLeafNodes(TrieNode root, ArrayList<String> leafNodes, String input) {
    if (root.isLeaf) {
      leafNodes.add(input);
      return leafNodes;
    }

    //for each node's children's char
    HashMap<Character, TrieNode> children = root.children;
    for (Map.Entry<Character, TrieNode> pair : children.entrySet()) {
      String str = input + pair.getKey();//replace input with root's string
      getLeafNodes(pair.getValue(), leafNodes, str);
    }

    return leafNodes;
  }

  //gets numResults leaf nodes branching from a given root
  //note leafNodes is an array, not an ArrayList as it requires a finite, known length (numResults)
  public String[] getLeafNodes(TrieNode root, String[] leafNodes, int numResults, String input) {
    if (root.isLeaf) {
      //leafNodes.add(root)
      for (int i = 0; i < leafNodes.length; i++) {
        if (leafNodes[i] == null) {
          leafNodes[i] = input;
          break;
        }
      }
      numResults--;
      return leafNodes;
    }


    //for each node's children's char
    HashMap<Character, TrieNode> children = root.children;//only returning roots for one case
    for (Map.Entry<Character, TrieNode> pair : children.entrySet()) {
      //if numResults have been found, return
      if (leafNodes[leafNodes.length-1] != null) return leafNodes;
      //str += pair.getKey();
      String str = input + pair.getKey();
      getLeafNodes(pair.getValue(), leafNodes, numResults, str);
    }

    return leafNodes;
  }

  //returns all search results for a given input
  //(incomplete) add functionality: if input already = an author, go straight to their page
  ArrayList<String> getSearchResults(String input) {

    //get leafNodes
    TrieNode root = searchNode(input);
    if (root != null) {
      //get initial node's string value
      String str = ""; 
      TrieNode node = root;
      while (node.parent != null) {
        str = node.c + str;
        node = node.parent;
      }
      return getLeafNodes(root, new ArrayList<String>(), str);
    } else return new ArrayList<String>();
  }

  //returns numResults search results for a given input
  //(incomplete) figure out how arr/arraylist stuff should work
  ArrayList<String> getSearchResults(String input, int numResults) {
    //if input already = an author, go straight to their page
    //going through the trie might actually be faster

    //get leafNodes
    String[] leafNodes = new String[numResults];
    TrieNode root = searchNode(input);
    if (root != null) {
      //get initial node's string value
      String str = ""; 
      TrieNode node = root;
      while (node.parent != null) {
        str = node.c + str;
        node = node.parent;
      }
      leafNodes = getLeafNodes(root, leafNodes, numResults, str);
    }

    //create ArrayList<String> of words from leafNodes
    //(temp)
    ArrayList<String> s = new ArrayList();
    for (int i = 0; i < leafNodes.length; i++) {
      if (leafNodes[i] != null)
        s.add(leafNodes[i]);
    }
    return s;
  }
}
