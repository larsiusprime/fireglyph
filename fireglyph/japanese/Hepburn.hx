package fireglyph.japanese;
import fireglyph.util.Util;
import unifill.Unifill;

using StringTools;

/**
 * Hepburn romanization rules for converting between Japanese and Roman characters
 * Ported from this JS implementation: https://github.com/lovell/hepburn
 * @author larsiusprime
 */
class Hepburn 
{

	private static var hiraganaMonographs:Map<String,String>;
	private static var katakanaMonographs:Map<String,String>;
	private static var hiraganaDigraphs:Map<String,String>;
	private static var katakanaDigraphs:Map<String,String>;
	private static var katakanaTrigraphs:Map<String,String>;
	private static var nihonShiki:Map<String,String>;
	private static var hiraganaPairs:Array<Array<String>>;
	private static var katakanaPairs:Array<Array<String>>;
	
	//internal map-builders:
	private static var _init:Bool = false;
	private static var _m:Map<String,String>;
	private static function m(a:String,b:String) { _m.set(a,b); }
	
	public static function containsHiragana(str:String):Bool
	{
		init();
		for (key in hiraganaMonographs.keys())
		{
			if (Unifill.uIndexOf(str, key) != -1)
			{
				return true;
			}
		}
		return false;
	}
	
	public static function containsKatakana(str:String):Bool
	{
		init();
		for (key in katakanaMonographs.keys())
		{
			if (Unifill.uIndexOf(str, key) != -1)
			{
				return true;
			}
		}
		return false;
	}
	
	public static function containsKana(str:String):Bool
	{
		return containsHiragana(str) || containsKatakana(str);
	}
	
	public static function fromKana(str:String):String
	{
		init();
		str = bulkReplace(str, hiraganaDigraphs);
		str = bulkReplace(str, katakanaDigraphs);
		str = bulkReplace(str, hiraganaMonographs);
		str = bulkReplace(str, katakanaMonographs);
		
		// Correct use of sokuon
		str = new EReg("っC", "g").replace(str, "TC");
		str = new EReg("っ(.)", "g").replace(str, "$1$1");
		
		str = new EReg("ッC", "g").replace(str, "TC");
		str = new EReg("ッ(.)", "g").replace(str, "$1$1");
		
		//Correct usage of N' (M' is a common mistake)
		str = new EReg("[NM]'([^YAEIOU]|$)", "g").replace(str, "N$1");
		
		//Correct use of choonpu
		str = Util.uReplace(str, "Aー", "Ā");
		str = Util.uReplace(str, "Iー", "Ī");
		str = Util.uReplace(str, "Uー", "Ū");
		str = Util.uReplace(str, "Eー", "Ē");
		str = Util.uReplace(str, "Oー", "Ō");
		
       	return str;
	}
	
	public static function toHiragana(str:String):String
	{
		init();
		// All conversion is done in upper-case
		str = str.toUpperCase();
		
		// Correct use of sokuon
		str = Util.uReplace(str, "TC", "っC");
		str = new EReg("([^AEIOUN])\\1", "g").replace(str, "っ$1");
		
		// Transliteration
		str = bulkReplace(str, null, hiraganaPairs);
		
		// Fix any remaining N/M usage (that isn't a N' usage)
		str = new EReg("N|M", "g").replace(str, "ん");
		
		return str;
	}
	
	public static function toKatakana(str:String):String
	{
        init();
		
        // All conversion is done in upper-case
		str = str.toUpperCase();
		
        // Correct use of sokuon
		str = Util.uReplace(str, "TC", "ッC", true);
		
        str = new EReg("([^AEIOUN])\\1", "g").replace(str, "ッ$1");
		
        // Transliteration
		str = bulkReplace(str, null, katakanaPairs);
		
        // Fix any remaining N/M usage (that isn't a N' usage)
		str = new EReg("N|M", "g").replace(str, "ン");
			
        return str;
	}
	
	/***PRIVATE***/
	
	private static function buildHiraganaPairs()
	{
		hiraganaPairs = [];
		
		var maps = [hiraganaMonographs, hiraganaDigraphs];
		
		for (map in maps)
		{
			for (key in map.keys())
			{
				hiraganaPairs.push([key, map.get(key)]);
			}
		}
		
		hiraganaPairs.sort(function(a:Array<String>, b:Array<String>):Int{
			if (a[1].length > b[1].length) return -1;
			if (a[1].length < b[1].length) return  1;
			return 0;
		});
	}
	
	private static function buildKatakanaPairs()
	{
        katakanaPairs = [];
		
		var maps = [katakanaMonographs, katakanaDigraphs, katakanaTrigraphs];
		
		for (map in maps)
		{
			for (key in map.keys())
			{
                katakanaPairs.push([key, map.get(key)]);
			}
		}
		
		katakanaPairs.sort(function(a:Array<String>, b:Array<String>):Int{
			if (a[1].length > b[1].length) return -1;
			if (a[1].length < b[1].length) return  1;
			return 0;
		});
	}
	
	private static function buildHiraganaDigraphs()
	{
		_m = new Map<String,String>();
		m("きゃ","KYA"); m("きゅ","KYU"); m("きょ","KYO");
		m("しゃ","SHA"); m("しゅ","SHU"); m("しょ","SHO");
		m("ちゃ","CHA"); m("ちゅ","CHU"); m("ちょ","CHO");
		m("にゃ","NYA"); m("にゅ","NYU"); m("にょ","NYO");
		m("ひゃ","HYA"); m("ひゅ","HYU"); m("ひょ","HYO");
		m("みゃ","MYA"); m("みゅ","MYU"); m("みょ","MYO");
		m("りゃ","RYA"); m("りゅ","RYU"); m("りょ","RYO");
		m("ぎゃ","GYA"); m("ぎゅ","GYU"); m("ぎょ","GYO");
		m("じゃ","JA"); m("じゅ","JU"); m("じょ","JO");
		m("びゃ","BYA"); m("びゅ","BYU"); m("びょ","BYO");
		m("ぴゃ", "PYA"); m("ぴゅ", "PYU"); m("ぴょ", "PYO");
		hiraganaDigraphs = _m;
		_m = null;
	}
	
	private static function buildHiraganaMonographs()
	{
		_m = new Map<String,String>();
		m("あ","A");  m("い","I"); m("う","U"); m("え","E");  m("お","O");
		m("か","KA"); m("き","KI"); m("く","KU"); m("け","KE"); m("こ","KO");
		m("さ","SA"); m("し","SHI"); m("す","SU"); m("せ","SE"); m("そ","SO");
		m("た","TA"); m("ち","CHI"); m("つ","TSU"); m("て","TE"); m("と","TO");
		m("な","NA"); m("に","NI"); m("ぬ","NU"); m("ね","NE"); m("の","NO");
		m("は","HA"); m("ひ","HI"); m("ふ","FU"); m("へ","HE"); m("ほ","HO");
		m("ま","MA"); m("み","MI"); m("む","MU"); m("め","ME"); m("も","MO");
		m("や","YA"); m("ゆ","YU"); m("よ","YO");
		m("ら","RA"); m("り","RI"); m("る","RU"); m("れ","RE"); m("ろ","RO");
		m("わ","WA"); m("ゐ","WI"); m("ゑ","WE"); m("を","WO"); m("ん","N'");
		m("が","GA"); m("ぎ","GI"); m("ぐ","GU"); m("げ","GE"); m("ご","GO");
		m("ざ","ZA"); m("じ","JI"); m("ず","ZU"); m("ぜ","ZE"); m("ぞ","ZO");
		m("だ","DA"); m("ぢ","DJI"); m("づ","DZU"); m("で","DE"); m("ど","DO");
		m("ば","BA"); m("び","BI"); m("ぶ","BU"); m("べ","BE"); m("ぼ","BO");
		m("ぱ", "PA"); m("ぴ", "PI"); m("ぷ", "PU"); m("ぺ", "PE"); m("ぽ", "PO");
		hiraganaMonographs = _m;
		_m = null;
	}
	
	private static function buildKatakanaDigraphs()
	{
		_m = new Map<String,String>();
		m("アー","Ā"); m("イー","Ī"); m("ウー","Ū"); m("エー","Ē"); m("オー","Ō");
		m("カー","KĀ"); m("キー","KĪ"); m("クー","KŪ"); m("ケー","KĒ"); m("コー","KŌ");
		m("サー","SĀ"); m("シー","SHĪ"); m("スー","SŪ"); m("セー","SĒ"); m("ソー","SŌ");
		m("ター","TĀ"); m("チー","CHĪ"); m("ツー","TSŪ"); m("テー","TĒ"); m("トー","TŌ");
		m("ナー","NĀ"); m("ニー","NĪ"); m("ヌー","NŪ"); m("ネー","NĒ"); m("ノー","NŌ");
		m("ハー","HĀ"); m("ヒー","HĪ"); m("フー","FŪ"); m("ヘー","HĒ"); m("ホー","HŌ");
		m("マー","MĀ"); m("ミー","MĪ"); m("ムー","MŪ"); m("メー","MĒ"); m("モー","MŌ");
		m("ヤー","YĀ"); m("ユー","YŪ"); m("ヨー","YŌ");
		m("ラー","RĀ"); m("リー","RĪ"); m("ルー","RŪ"); m("レー","RĒ"); m("ロー","RŌ");
		m("ワー","WĀ"); m("ヰー","WĪ"); m("ヱー","WĒ"); m("ヲー","WŌ"); m("ンー","N");
		m("ガー","GĀ"); m("ギー","GĪ"); m("グー","GŪ"); m("ゲー","GĒ"); m("ゴー","GŌ");
		m("ザー","ZĀ"); m("ジー","JĪ"); m("ズー","ZŪ"); m("ゼー","ZĒ"); m("ゾー","ZŌ");
		m("ダー","DĀ"); m("ヂー","DJĪ"); m("ヅー","DZŪ"); m("デー","DĒ"); m("ドー","DŌ");
		m("バー","BĀ"); m("ビー","BĪ"); m("ブー","BŪ"); m("ベー","BĒ"); m("ボー","BŌ");
		m("パー","PĀ"); m("ピー","PĪ"); m("プー","PŪ"); m("ペー","PĒ"); m("ポー","PŌ");
		m("キャ","KYA"); m("キュ","KYU"); m("キョ","KYO");
		m("シャ","SHA"); m("シュ","SHU"); m("ショ","SHO");
		m("チャ","CHA"); m("チュ","CHU"); m("チョ","CHO");
		m("ニャ","NYA"); m("ニュ","NYU"); m("ニョ","NYO");
		m("ヒャ","HYA"); m("ヒュ","HYU"); m("ヒョ","HYO");
		m("ミャ","MYA"); m("ミュ","MYU"); m("ミョ","MYO");
		m("リャ","RYA"); m("リュ","RYU"); m("リョ","RYO");
		m("ギャ","GYA"); m("ギュ","GYU"); m("ギョ","GYO");
		m("ジャ","JA"); m("ジュ","JU"); m("ジョ","JO");
		m("ビャ","BYA"); m("ビュ","BYU"); m("ビョ","BYO");
		m("ピャ", "PYA"); m("ピュ", "PYU"); m("ピョ", "PYO");
		katakanaDigraphs = _m;
		_m = null;
	}
	
	private static function buildKatakanaMonographs()
	{
		_m = new Map<String,String>();
		m("ア","A"); m("イ","I"); m("ウ","U"); m("エ","E"); m("オ","O");
		m("カ","KA"); m("キ","KI"); m("ク","KU"); m("ケ","KE"); m("コ","KO");
		m("サ","SA"); m("シ","SHI"); m("ス","SU"); m("セ","SE"); m("ソ","SO");
		m("タ","TA"); m("チ","CHI"); m("ツ","TSU"); m("テ","TE"); m("ト","TO");
		m("ナ","NA"); m("ニ","NI"); m("ヌ","NU"); m("ネ","NE"); m("ノ","NO");
		m("ハ","HA"); m("ヒ","HI"); m("フ","FU"); m("ヘ","HE"); m("ホ","HO");
		m("マ","MA"); m("ミ","MI"); m("ム","MU"); m("メ","ME"); m("モ","MO");
		m("ヤ","YA"); m("ユ","YU"); m("ヨ","YO");
		m("ラ","RA"); m("リ","RI"); m("ル","RU"); m("レ","RE"); m("ロ","RO");
		m("ワ","WA"); m("ヰ","WI"); m("ヱ","WE"); m("ヲ","WO"); m("ン","N");
		m("ガ","GA"); m("ギ","GI"); m("グ","GU"); m("ゲ","GE"); m("ゴ","GO");
		m("ザ","ZA"); m("ジ","JI"); m("ズ","ZU"); m("ゼ","ZE"); m("ゾ","ZO");
		m("ダ","DA"); m("ヂ","DJI"); m("ヅ","DZU"); m("デ","DE"); m("ド","DO");
		m("バ","BA"); m("ビ","BI"); m("ブ","BU"); m("ベ","BE"); m("ボ","BO");
		m("パ", "PA"); m("ピ", "PI"); m("プ", "PU"); m("ペ", "PE"); m("ポ", "PO");
		katakanaMonographs = _m;
		_m = null;
	}
	
	private static function buildKatakanaTrigraphs()
	{
		_m = new Map<String,String>();
		m("キャー","KYĀ"); m("キュー","KYŪ"); m("キョー","KYŌ");
		m("シャー","SHĀ"); m("シュー","SHŪ"); m("ショー","SHŌ");
		m("チャー","CHĀ"); m("チュー","CHŪ"); m("チョー","CHŌ");
		m("ニャー","NYĀ"); m("ニュー","NYŪ"); m("ニョー","NYŌ");
		m("ヒャー","HYĀ"); m("ヒュー","HYŪ"); m("ヒョー","HYŌ");
		m("ミャー","MYĀ"); m("ミュー","MYŪ"); m("ミョー","MYŌ");
		m("リャー","RYĀ"); m("リュー","RYŪ"); m("リョー","RYŌ");
		m("ギャー","GYĀ"); m("ギュー","GYŪ"); m("ギョー","GYŌ");
		m("ジャー","JĀ"); m("ジュー","JŪ"); m("ジョー","JŌ");
		m("ビャー","BYĀ"); m("ビュー","BYŪ"); m("ビョー","BYŌ");
		m("ピャー", "PYĀ"); m("ピュー", "PYŪ"); m("ピョー", "PYŌ");
		katakanaTrigraphs = _m;
		_m = null;
	}
	
	private static function buildNihonShiki()
	{
		_m = new Map<String,String>();
		m("SI","SHI");
		m("ZI","JI");
		m("TI","CHI");
		m("DI","JI");
		m("TU","TSU");
		m("DU","ZU");
		m("SHU","SHU"); // Prevent HU from accidentally converting
		m("CHU","CHU");
		m("HU","FU");
		m("CYA","CHA");
		m("CYO","CHO");
		m("CYU","CHU");
		m("SYA","SHA");
		m("SYU","SHU");
		m("SYO","SHO");
		m("ZYA","JA");
		m("ZYU","JU");
		m("ZYO","JO");
		m("TYA","CHA");
		m("TYU","CHU");
		m("TYO","CHO");
		m("DYA","JA");
		m("DYU","JU");
		m("DYO", "JO");
		nihonShiki = _m;
		_m = null;
	}
	
	private static function bulkReplace(str:String, map:Map<String,String>, arr:Array<Array<String>>=null)
	{
        var newStr = str;
		if (arr == null && map != null)
		{
            for (key in map.keys())
			{
				var replace = map.get(key);
				newStr = Util.uReplace(newStr, key, replace, false);
			}
		}
		else if(arr != null)
		{
            for (pair in arr)
			{
                var match = pair[1];
				var replace = pair[0];
                newStr = Util.uReplace(newStr, match, replace, false);
			}
		}
		return newStr;
	}
	
	private static function init()
	{
		if (_init) return;
        buildKatakanaMonographs();
		buildHiraganaMonographs();
		buildKatakanaDigraphs();
		buildHiraganaDigraphs();
		buildKatakanaTrigraphs();
		buildNihonShiki();
		buildHiraganaPairs();
		buildKatakanaPairs();
		_init = true;
	}
}

class HepburnTests
{
	//internal map-builders:
	private static var _init:Bool = false;
	private static var _m:Map<String,String>;
	private static function m(a:String,b:String) { _m.set(a,b); }
	
	private static var katakanaTests:Map<String,String>;
	private static var toKatakanaTests:Map<String,String>;
	private static var hiraganaTests:Map<String,String>;
	private static var toHiraganaTests:Map<String,String>;
	
	private static var testsTotal:Int;
	private static var testsFailed:Int;
	
	private static var testMsg:Array<String>;
	
	public static function assertEqual(a:String, b:String, msg:String="")
	{
		if (a != b)
        {
			testsFailed++;
			testMsg.push(msg + "(" + a + " VS " + b + ")");
		}
		testsTotal++;
	}
	
	public static function assert(b:Bool, msg:String="")
	{
		if (!b){
			testsFailed++;
			testMsg.push(msg);
		}
		testsTotal++;
	}
	
	
	public static function run()
	{
		if (!_init)
		{
			buildHiraganaTests();
			buildKatakanaTests();
			buildToHiraganaTests();
			buildToKatakanaTests();
			_init = true;
		}
		
		testsTotal = 0;
		testsFailed = 0;
		testMsg = [];
		
        for (hiragana in hiraganaTests.keys())
		{
			assertEqual(Hepburn.fromKana(hiragana), hiraganaTests.get(hiragana), "Hiragana conversion failed on " + hiragana);
		}
		
		for (katakana in katakanaTests.keys())
		{
			assertEqual(Hepburn.fromKana(katakana), katakanaTests.get(katakana), "Katakana conversion failed on " + katakana);
		}

		for (romaji in toKatakanaTests.keys())
		{
			assertEqual(Hepburn.toKatakana(romaji), toKatakanaTests.get(romaji), "Hepburn conversion to katakana failed on " + romaji);
			assertEqual(Hepburn.fromKana(toKatakanaTests.get(romaji)), romaji, "Hepburn conversion from katakana failed on " + romaji);
		}
		
        for (romaji in toHiraganaTests.keys())
		{
			assertEqual(Hepburn.toHiragana(romaji), toHiraganaTests.get(romaji), "Hepburn conversion to hiragana failed on " + romaji);
			assertEqual(Hepburn.fromKana(toHiraganaTests.get(romaji)), romaji, "Hepburn conversion from hiragana failed on " + romaji);
		}
    	
        for (hiragana in hiraganaTests.keys())
		{
			assert(Hepburn.containsHiragana(hiragana));
			assert(!Hepburn.containsKatakana(hiragana));
			assert(Hepburn.containsKana(hiragana));
		}
		
		for (katakana in katakanaTests.keys())
		{
			assert(!Hepburn.containsHiragana(katakana));
			assert(Hepburn.containsKatakana(katakana));
			assert(Hepburn.containsKana(katakana));
		}
        
        assert(!Hepburn.containsKatakana("the quick red fox jumps over the lazy brown dog"));
		assert(!Hepburn.containsHiragana("the quick red fox jumps over the lazy brown dog"));

		assert(Hepburn.containsKatakana("カthe quick red fox jumps over the lazy brown dog"));
		assert(!Hepburn.containsHiragana("カthe quick red fox jumps over the lazy brown dog"));
		assert(Hepburn.containsKana("カthe quick red fox jumps over the lazy brown dog"));

		assert(!Hepburn.containsKatakana("ひthe quick red fox jumps over the lazy brown dog"));
		assert(Hepburn.containsHiragana("ひthe quick red fox jumps over the lazy brown dog"));
		assert(Hepburn.containsKana("ひthe quick red fox jumps over the lazy brown dog"));

		assert(Hepburn.containsKatakana("カひ"));
		assert(Hepburn.containsHiragana("カひ"));
		assert(Hepburn.containsKana("カひ"));

		trace("Test results : " + (testsTotal - testsFailed) + " / " + testsTotal);
		for(msg in testMsg){
        	trace(msg);    
        }
	}
	
	private static function buildKatakanaTests()
	{
		_m = new Map<String,String>();
		m("カタカナ","KATAKANA");
		m("マッモト", "MAMMOTO");
		katakanaTests = _m;
		_m = null;
	}
	
	private static function buildToKatakanaTests()
	{
		_m = new Map<String,String>();
		m("KATAKANA","カタカナ");
		m("TOKYO","トキョ");
		m("MAKKUDONARUDO","マックドナルド");
		m("MADONNA","マドンナ");
		m("TABAKO","タバコ");
		m("ITCHOO", "イッチョオ");
		toKatakanaTests = _m;
		_m = null;
	}
	
	private static function buildHiraganaTests()
	{
		_m = new Map<String,String>();
		m("ひらがな","HIRAGANA");
		m("あいうえお かきくけこ","AIUEO KAKIKUKEKO");
		m("きゃきゅきょ","KYAKYUKYO");
		m("あんこ","ANKO");
		m("どらえもん","DORAEMON");
		m("かんぽ","KANPO");
		m("ほんま","HONMA");
		m("へっぽこ","HEPPOKO");
		m("べっぷ","BEPPU");
		m("いっしき","ISSHIKI");
		m("えっちゅう","ETCHUU");
		m("はっちょう","HATCHOU");
		m("うさぎ","USAGI");
		m("たろう","TAROU");
		m("おおさま","OOSAMA");
		m("きょうと","KYOUTO");
		m("きょおと","KYOOTO");
		m("とおる","TOORU");
		m("さいとう","SAITOU");
		m("こんにちは","KONNICHIHA");
		m("ちぢむ","CHIDJIMU");
		m("りんぱ", "RINPA");
		hiraganaTests = _m;
		_m = null;
	}
	
	private static function buildToHiraganaTests()
	{
		_m = new Map<String,String>();
		m("AIKA","あいか");
		m("AIKI","あいき");
		m("AISA","あいさ");
		m("AINA","あいな");
		m("AIKO","あいこ");
		m("AIJI","あいじ");
		m("AIYO","あいよ");
		m("AINO","あいの");
		m("AIMI","あいみ");
		m("AIRA","あいら");
		m("AIRI","あいり");
		m("AEKA","あえか");
		m("AEKO","あえこ");
		m("AEMI","あえみ");
		m("AOIKO","あおいこ");
		m("AOBAKO","あおばこ");
		m("AOI","あおい");
		m("AOBA","あおば");
		m("AONA","あおな");
		m("AONO","あおの");
		m("AKANE","あかね");
		m("AKAMI","あかみ");
		m("AKARI","あかり");
		m("AKIRAKO","あきらこ");
		m("AKIE","あきえ");
		m("AKISA","あきさ");
		m("AKINA","あきな");
		m("AKIKO","あきこ");
		m("AKIYO","あきよ");
		m("AKINO","あきの");
		m("AKIHO","あきほ");
		m("AKIRA","あきら");
		m("AKIYOU","あきよう");
		m("AKIBA","あきば");
		m("AKUMI","あくみ");
		m("AGURI","あぐり");
		m("AKEGARASU","あけがらす");
		m("AKEMI","あけみ");
		m("AKEYO","あけよ");
		m("AKENO","あけの");
		m("AKEHO","あけほ");
		m("AGEASHIDORI","あげあしどり");
		m("AGEHA","あげは");
		m("ASAYO","あさよ");
		m("ASAE","あさえ");
		m("ASAKA","あさか");
		m("ASAKICHI","あさきち");
		m("ASAMI","あさみ");
		m("ASAKO","あさこ");
		m("ASANO","あさの");
		m("ASAHO","あさほ");
		m("ASAJI","あさじ");
		m("AZAMI","あざみ");
		m("ASHIKA","あしか");
		m("ASHIE","あしえ");
		m("ASHINO","あしの");
		m("ASUKA","あすか");
		m("ASUMI","あすみ");
		m("ASUKI","あすき");
		m("ASUE","あすえ");
		m("ASUNA","あすな");
		m("ASURU","あする");
		m("AZUMINO","あずみの");
		m("AZUSA","あずさ");
		m("AZUMI","あずみ");
		m("AZUKI","あずき");
		m("ASEMI","あせみ");
		m("ASOMI","あそみ");
		m("ASONO","あその");
		m("ACHIKA","あちか");
		m("AKKO","あっこ");
		m("ATSUYO","あつよ");
		m("ATSUKA","あつか");
		m("ATSUKI","あつき");
		m("ATSUKO","あつこ");
		m("ATSUSA","あつさ");
		m("ATSUMI","あつみ");
		m("ATSUE","あつえ");
		m("ATSUNO","あつの");
		m("ATSUHO","あつほ");
		m("ADZUSA","あづさ");
		m("ADZUMI","あづみ");
		m("ADZUMA","あづま");
		m("ADZUHA","あづは");
		m("ATORI","あとり");
		m("ANAMI","あなみ");
		m("ANIKA","あにか");
		m("AMANE","あまね");
		m("AMANO","あまの");
		m("AMIKA","あみか");
		m("AMIE","あみえ");
		m("AMIKO","あみこ");
		m("AMIYO","あみよ");
		m("AYANE","あやね");
		m("AYAKA","あやか");
		m("AYAME","あやめ");
		m("AYAE","あやえ");
		m("AYASA","あやさ");
		m("AYANA","あやな");
		m("AYAKO","あやこ");
		m("AYAMI","あやみ");
		m("AYANO","あやの");
		m("AYAHA","あやは");
		m("AYUKA","あゆか");
		m("AYUMI","あゆみ");
		m("AYUNA","あゆな");
		m("AYUKO","あゆこ");
		m("AYUSA","あゆさ");
		m("AYUKAWA","あゆかわ");
		m("AYUME","あゆめ");
		m("AYUMU","あゆむ");
		m("AYUHA","あゆは");
		m("AYURI","あゆり");
		m("AYOKO","あよこ");
		m("AYOMI","あよみ");
		m("ARASAGASHI","あらさがし");
		m("ARAI","あらい");
		m("ARAKO","あらこ");
		m("ARISA","ありさ");
		m("ARINA","ありな");
		m("AROHA","あろは");
		m("AWAMI","あわみ");
		m("AWANO","あわの");
		m("ANNE","あんね");
		m("ANNA","あんな");
		m("ANJU","あんじゅ");
		m("ANZU","あんず");
		m("ANTA","あんた");
		m("ANJI","あんじ");
		m("ANRI","あんり");
		m("AKO","あこ");
		m("AYO","あよ");
		m("AYA","あや");
		m("IUKO","いうこ");
		m("IEKO","いえこ");
		m("IOKO","いおこ");
		m("IORI","いおり");
		m("IKIKO","いきこ");
		m("IKIO","いきお");
		m("IKUMI","いくみ");
		m("IKUE","いくえ");
		m("IKUKO","いくこ");
		m("IKUYO","いくよ");
		m("IKUHO","いくほ");
		m("IKUO","いくお");
		m("ISAE","いさえ");
		m("ISAKO","いさこ");
		m("ISANA","いさな");
		m("ISAO","いさお");
		m("ISHIE","いしえ");
		m("ISHIKO","いしこ");
		m("ISHIO","いしお");
		m("IZUMI","いずみ");
		m("ISERIMEGUMI","いせりめぐみ");
		m("ISEJO","いせじょ");
		m("ISOE","いそえ");
		m("ISOKO","いそこ");
		m("ISOMI","いそみ");
		m("ISOMU","いそむ");
		m("ICHIGOHIME","いちごひめ");
		m("ICHIKA","いちか");
		m("ICHIGO","いちご");
		m("ICHIE","いちえ");
		m("ICHIKO","いちこ");
		m("ICHINO","いちの");
		m("ICHIHO","いちほ");
		m("IPPEI","いっぺい");
		m("ITSUKA","いつか");
		m("ITSUE","いつえ");
		m("ITSUKO","いつこ");
		m("ITSUMI","いつみ");
		m("ITSUYO","いつよ");
		m("ITSUHO","いつほ");
		m("ITSUHA","いつは");
		m("ITSUWA","いつわ");
		m("IDZUMIKO","いづみこ");
		m("IDZUKO","いづこ");
		m("IDZUMI","いづみ");
		m("IDZUYO","いづよ");
		m("ITONE","いとね");
		m("ITOE","いとえ");
		m("ITOKO","いとこ");
		m("ITOMI","いとみ");
		m("INAKO","いなこ");
		m("INAHO","いなほ");
		m("INEKO","いねこ");
		m("INOKO","いのこ");
		m("IBUKI","いぶき");
		m("IHOKO","いほこ");
		m("IMAKO","いまこ");
		m("IMAMURA","いまむら");
		m("IMARI","いまり");
		m("IMIKO","いみこ");
		m("IMEKO","いめこ");
		m("IYOKO","いよこ");
		m("IRIKO","いりこ");
		m("IRONE","いろね");
		m("IROHA","いろは");
		m("IWAE","いわえ");
		m("IWAKO","いわこ");
		m("IKU","いく");
		m("IKUNO","いくの");
		m("IE","いえ");
		m("ISHI","いし");
		m("ITO","いと");
		m("INORI","いのり");
		m("UIKO","ういこ");
		m("USAKO","うさこ");
		m("USHIO","うしお");
		m("UTAKO","うたこ");
		m("UTAYO","うたよ");
		m("UTSUGI","うつぎ");
		m("UMIKO","うみこ");
		m("UMEKICHI","うめきち");
		m("UMEKO","うめこ");
		m("UMEJI","うめじ");
		m("UMEHARU","うめはる");
		m("UMEJO","うめじょ");
		m("UMEYO","うめよ");
		m("URAKO","うらこ");
		m("URARA","うらら");
		m("UNPEI","うんぺい");
		m("UTSUHO","うつほ");
		m("EIKO","えいこ");
		m("YOUKO","ようこ");
		m("ESHIKO","えしこ");
		m("ECHIE","えちえ");
		m("ETSUKA","えつか");
		m("ETSUKO","えつこ");
		m("ETSUYO","えつよ");
		m("ENAKO","えなこ");
		m("EBIZOU","えびぞう");
		m("EMINA","えみな");
		m("EMIKO","えみこ");
		m("ERIKA","えりか");
		m("ERIE","えりえ");
		m("ERISA","えりさ");
		m("ERINA","えりな");
		m("ERIKO","えりこ");
		m("ERIO","えりお");
		m("ERIHO","えりほ");
		m("ERIMO","えりも");
		m("ERUSA","えるさ");
		m("ERUKO","えるこ");
		m("ENMA","えんま");
		m("OKINA","おきな");
		m("OGIWARA","おぎわら");
		m("OKUNO","おくの");
		m("OSAKO","おさこ");
		m("OSAME","おさめ");
		m("OTSUYO","おつよ");
		m("OTOHIME","おとひめ");
		m("OMAKO","おまこ");
		m("ORIE","おりえ");
		m("ORIBE","おりべ");
		m("OIWA","おいわ");
		m("OKICHI","おきち");
		m("OTAMA","おたま");
		m("OGIN","おぎん");
		m("OKOU","おこう");
		m("OICHINOKATA","おいちのかた");
		m("OSHIU","おしう");
		m("OSHIZU","おしず");
		m("OSHICHI","おしち");
		m("OSHAKA","おしゃか");
		m("OKATSU","おかつ");
		m("OSOME","おそめ");
		m("OKURA","おくら");
		m("ONAO","おなお");
		m("OTOYO","おとよ");
		m("ONOU","おのう");
		m("OHAMA","おはま");
		m("OYUU","おゆう");
		m("OYOU","およう");
		m("OSATO","おさと");
		m("ORYUU","おりゅう");
		m("KAIKO","かいこ");
		m("KAISHI","かいし");
		m("KOU","こう");
		m("KOUKO","こうこ");
		m("KAEKO","かえこ");
		m("KAORUKO","かおるこ");
		m("KAORI","かおり");
		m("KAORU","かおる");
		m("KAKUKO","かくこ");
		m("KAGUYA","かぐや");
		m("KASANE","かさね");
		m("KAZANE","かざね");
		m("KAZAMI","かざみ");
		m("KASHIKO","かしこ");
		m("KASHIYO","かしよ");
		m("KAJIKO","かじこ");
		m("KASUMI","かすみ");
		m("KAZUE","かずえ");
		m("KAZUKO","かずこ");
		m("KAZUMI","かずみ");
		m("KAZUYO","かずよ");
		m("KAZUO","かずお");
		m("KAZUHO","かずほ");
		m("KAZUHA","かずは");
		m("KAZUYA","かずや");
		m("KACHIKO","かちこ");
		m("KATSUE","かつえ");
		m("KATSUKO","かつこ");
		m("KATSUYO","かつよ");
		m("KATSUMI","かつみ");
		m("KATSUHIKO","かつひこ");
		m("KADZUE","かづえ");
		m("KADZUSA","かづさ");
		m("KADZUKO","かづこ");
		m("KADZUMI","かづみ");
		m("KANAE","かなえ");
		m("KANAME","かなめ");
		m("KANAKO","かなこ");
		m("KANAJO","かなじょ");
		m("KANAMI","かなみ");
		m("KANABUN","かなぶん");
		m("KANEE","かねえ");
		m("KANEKO","かねこ");
		m("KANEMI","かねみ");
		m("KANEYO","かねよ");
		m("KANOKA","かのか");
		m("KANOE","かのえ");
		m("KANOKO","かのこ");
		m("KAINA","かいな");
		m("KAEDE","かえで");
		m("KAHORUKO","かほるこ");
		m("KAHOKO","かほこ");
		m("KAHORI","かほり");
		m("KAMAKO","かまこ");
		m("KAMIE","かみえ");
		m("KAMIKO","かみこ");
		m("KAMEKO","かめこ");
		m("KAMEYO","かめよ");
		m("KAYAKA","かやか");
		m("KAYAKO","かやこ");
		m("KAYANO","かやの");
		m("KAYOI","かよい");
		m("KAYOKO","かよこ");
		m("KAYOMI","かよみ");
		m("KARINSHI","かりんし");
		m("KANKO","かんこ");
		m("KANNA","かんな");
		m("KANPEI","かんぺい");
		m("KAKO","かこ");
		m("KAYO","かよ");
		m("KATSU","かつ");
		m("KANO","かの");
		m("GANTA","がんた");
		m("KIIKO","きいこ");
		m("KIEKO","きえこ");
		m("KIKUI","きくい");
		m("KIKUE","きくえ");
		m("KIKUKO","きくこ");
		m("KIKUMI","きくみ");
		m("KIKUYO","きくよ");
		m("KIKUNA","きくな");
		m("KIKUNO","きくの");
		m("KIKUO","きくお");
		m("KIKUHIME","きくひめ");
		m("KIKUMARO","きくまろ");
		m("KISAE","きさえ");
		m("KISAKO","きさこ");
		m("KISHIKO","きしこ");
		m("KISEKO","きせこ");
		m("KITAKO","きたこ");
		m("KICHIKO","きちこ");
		m("KICHIBEE","きちべえ");
		m("KINAKO","きなこ");
		m("KINUE","きぬえ");
		m("KINUKO","きぬこ");
		m("KINUYO","きぬよ");
		m("KINEKO","きねこ");
		m("KINOE","きのえ");
		m("KINOKO","きのこ");
		m("KINOJI","きのじ");
		m("KIMIE","きみえ");
		m("KIMIKA","きみか");
		m("KIMIKO","きみこ");
		m("KIMIJO","きみじょ");
		m("KIMIYO","きみよ");
		m("KIMIJI","きみじ");
		m("KIMUKO","きむこ");
		m("KYOU","きょう");
		m("KIYAKO","きやこ");
		m("KYOUKO","きょうこ");
		m("KYOUMI","きょうみ");
		m("KIYOIKO","きよいこ");
		m("KIYOKA","きよか");
		m("KIYOE","きよえ");
		m("KIYOKO","きよこ");
		m("KIYOICHI","きよいち");
		m("KIYOSHI","きよし");
		m("KIYOMI","きよみ");
		m("KIYOHIDE","きよひで");
		m("KIYONA","きよな");
		m("KIYONO","きよの");
		m("KIYOHIKO","きよひこ");
		m("KIYOHA","きよは");
		m("KIRINTEI","きりんてい");
		m("KIRIE","きりえ");
		m("KIRIKO","きりこ");
		m("KIWAKO","きわこ");
		m("KINKA","きんか");
		m("KINKO","きんこ");
		m("KINSHI","きんし");
		m("KINTAROU","きんたろう");
		m("KIN'YO","きんよ");
		m("KIN'YA","きんや");
		m("KIE","きえ");
		m("KINO","きの");
		m("GINPEI","ぎんぺい");
		m("KUSUKA","くすか");
		m("KUCHAYO","くちゃよ");
		m("KUNIE","くにえ");
		m("KUNIKO","くにこ");
		m("KUNIYO","くによ");
		m("KUNIMI","くにみ");
		m("KUNOKO","くのこ");
		m("KUMAI","くまい");
		m("KUMAKO","くまこ");
		m("KUMIKO","くみこ");
		m("KUMEKO","くめこ");
		m("KURAKO","くらこ");
		m("KURINA","くりな");
		m("KURIKO","くりこ");
		m("KURUMI","くるみ");
		m("KUREKO","くれこ");
		m("KUREHA","くれは");
		m("GUNJOU","ぐんじょう");
		m("KEIICHI","けいいち");
		m("KEIGO","けいご");
		m("KEIKO","けいこ");
		m("KEISEKI","けいせき");
		m("KEIYA","けいや");
		m("KEEKO","けえこ");
		m("KESAE","けさえ");
		m("KESAKO","けさこ");
		m("KESAYO","けさよ");
		m("KESANO","けさの");
		m("KESAMI","けさみ");
		m("KEMIKO","けみこ");
		m("KEMEKO","けめこ");
		m("KEYOKO","けよこ");
		m("KEN'ICHI","けんいち");
		m("KENGO","けんご");
		m("KENJI","けんじ");
		m("KENSUKE","けんすけ");
		m("GENPEI","げんぺい");
		m("KOUICHI","こういち");
		m("KOUJI","こうじ");
		m("KOUHEI","こうへい");
		m("KOKURIKO","こくりこ");
		m("KOKESHI","こけし");
		m("KOKOROKO","こころこ");
		m("KOKONE","ここね");
		m("KOKOMI","ここみ");
		m("KOKORO","こころ");
		m("KOZUE","こずえ");
		m("KOTSUKO","こつこ");
		m("KODZUE","こづえ");
		m("KOCHOU","こちょう");
		m("KOTOE","ことえ");
		m("KOTOKO","ことこ");
		m("KOTOMI","ことみ");
		m("KOTONO","ことの");
		m("KOTOHA","ことは");
		m("KONAMI","こなみ");
		m("KONOHA","このは");
		m("ITCHOO", "いっちょお");
		toHiraganaTests = _m;
		_m = null;
	}
}