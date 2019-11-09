//screen
final int SCREEN_W = 1400;
final int SCREEN_H = 780;

final color BACKGROUND_COL = 250;//color(246,246,240);//255

//main bottom screen
final color MAIN_TEXT_BACKGROUND_COLOUR = color(100);
final int MAX_SCREENS = 10;

//widgets

//top screen
final int TOP_SCREEN_H = 100;//120
final color TOP_SCREEN_COL = color(208,128,101);//color(255, 102, 0);//230;color(208,128,121)
//logo
final int LOGO_X = 5;
final int LOGO_Y = 20;
final int LOGO_H = 40;//TOP_SCREEN_H-2*LOGO_GAP_Y
final int LOGO_W = LOGO_H*5;
//page arrows
final int PAGE_ARROW_SIZE = 25;
final int PAGE_ARROW_GAP = 10;
final int PREVIOUS_PAGE_X = LOGO_X+LOGO_W/2-PAGE_ARROW_SIZE-PAGE_ARROW_GAP;
final int NEXT_PAGE_X = PREVIOUS_PAGE_X+PAGE_ARROW_SIZE+PAGE_ARROW_GAP;
final int PAGE_ARROW_Y = TOP_SCREEN_H-PAGE_ARROW_SIZE-PAGE_ARROW_GAP;
//submit
final int SUBMIT_W = 30;
//search bar
final int SEARCH_H = 30;
final int SEARCH_MARGIN_R = LOGO_X+SEARCH_H/2+LOGO_X+LOGO_W;
final int SEARCH_MARGIN_L = 35;
final int SEARCH_X = SEARCH_MARGIN_R;
final int SEARCH_Y = 20;
final int SEARCH_W = SCREEN_W-SEARCH_MARGIN_R-SEARCH_MARGIN_L-SUBMIT_W;
final color SEARCH_BAR_COL = 255;
final color SEARCH_BAR_TEXT_COL = 0;
//submit again
final int SUBMIT_X = SEARCH_X+SEARCH_W;
final int SUBMIT_Y = SEARCH_Y;
final int SUBMIT_H = SEARCH_H;
//suggestions ddl
final int SUGGESTIONS_W = SEARCH_W;
final int SUGGESTIONS_ITEM_H = 30;
final int SUGGESTIONS_BAR_H = 10;
final int SUGGESTIONS_H = 300;
final int SUGGESTIONS_Y = SEARCH_Y + SEARCH_H - SUGGESTIONS_BAR_H;
final color SUGGESTIONS_BORDER_COL = 44;//TOP_SCREEN_COL;  //same as queries
//slider button
final int SLIDER_CURSOR_H = 60;
//slider
final int SLIDER_GAP_X = 2;
final int SLIDER_GAP_Y = 2;
final int SLIDER_W = 10;
final int SLIDER_H = SCREEN_H-SLIDER_W-2*SLIDER_GAP_Y;
final int SLIDER_X = SCREEN_W-SLIDER_W-SLIDER_GAP_X;
final int SLIDER_Y = SLIDER_W/2+SLIDER_GAP_Y;
final float SLIDER_SENSITIVITY = 0.02;
//final int PAGE_H = SCREEN_H*2;
final color SLIDER_CURSOR_COL = 200;
//queries
final int QUERIES_W = 150;
final int QUERIES_H = 300;
final int QUERIES_BAR_H = 30;
final int QUERIES_ITEM_H = 30;
final int QUERIES_GAP = 5;
final int QUERIES_Y = TOP_SCREEN_H-QUERIES_BAR_H-QUERIES_GAP;
final int QUERIES_X = SLIDER_X-QUERIES_W-QUERIES_BAR_H*2;
final color QUERIES_COL = 44;//100;  //same as arrow full
final color QUERIES_TEXT_COL = 200;//255;  //same as arrow empty
//search results widgets
//final int RESULT_X = SEARCH_MARGIN;
final int RESULT_X = 5;
final int RESULT_H = 20;
final int RESULTS_GAP = 80;//gap between top of each story
final int COMMENTS_GAP = 10;//gap between bottom of last comment to top of next comment
final int MAIN_MARGIN = 10;//gap between top screen and first widget
final int RESULTS_MARGIN = 20;//margin from main widgets (title/author/url)
final int RESULTS_MARGIN_X = 5;
final int COMMENT_INDENT_W = 10;
final int RESULT_W = SCREEN_W-2*RESULTS_MARGIN_X-SLIDER_W-SCREEN_W/100;
final int TOTAL_RESULTS_H = RESULT_H*3 + RESULTS_MARGIN;  //(19 is standard widget height; might change)
final color MAIN_TITLE_COL = 0;
final color URL_COL = color(73,140,211);
final color TITLE_TEXT_COL = 0;
final color COMMENT_TEXT_COL = 0;
final color AUTHOR_TEXT_COL = 50;
final color SEARCH_RESULTS_TEXT_COL = 150;
//fonts
final int TITLE_FONT_W = 8;
final int TITLE_FONT_H = 10;
final int AUTHOR_FONT_W = 6;
final int AUTHOR_BUTTON_H = 20;
final int DATE_FONT_W = 6;
final int COMMENT_FONT_W = 6;
final int COMMENT_FONT_H = 15;
final int MAIN_TITLE_FONT_H = 25;
final int MAIN_AUTHOR_FONT_H = 25;
final int URL_FONT_W = 4;
final int URL_FONT_H = 8;
final int SUGGESTIONS_FONT_W = 4;

//add most relevant (closest to search)
//final String[] DDL_SORT_BY_STORY = new String[]{"Sort by: Most relevant", "Sort by: Highest score", "Sort by: Lowest score","Sort by: Most Commented","Sort by: Least Commented", "Sort by: Newest", "Sort by: Oldest"};
//final String[] DDL_SEARCH_BY = new String[]{"Search by: All", "Search by: Author", "Search by: Title"};
final String[] DDL_SORT_BY_STORY = new String[]{"Most relevant", "Highest score", "Lowest score","Most Commented","Least Commented", "Newest", "Oldest"};
List<String> DDL_SORT_BY_STORY2 = new ArrayList<String>();
final String[] DDL_SORT_BY_COMMENT = new String[]{"Most Kids", "Least Kids", "Newest", "Oldest"};
final String[] DDL_SEARCH_BY = new String[]{"All", "Author", "Title"};
