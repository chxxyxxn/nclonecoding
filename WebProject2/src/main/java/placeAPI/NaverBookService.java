package placeAPI;

import java.io.IOException;
import java.io.InputStreamReader;
import java.io.StringReader;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List; 

//import org.xmlpull.v1.XmlPullParser;
//import org.xmlpull.v1.XmlPullParserException;
//import org.xmlpull.v1.XmlPullParserFactory; 
import placeAPI.Book;

public class NaverBookService {
	private static String clientID = "UGXqMR4gWAjQYT3vo0g1";
	private static String clientSecret = "7I77V3N1hF";
	
	public List<Book> searchBook(String keyword, int display, int start) {
		URL url;        
		List<Book> list = null;
		
		url = new URL("https://openapi.naver.com/v1/search/book.xml?query=" + URLEncoder.encode(keyword, "UTF-8")
		+ (display != 0 ? "&display=" + display : "") + (start != 0 ? "&start=" + start : ""));
		URLConnection urlConn;
	}
}
