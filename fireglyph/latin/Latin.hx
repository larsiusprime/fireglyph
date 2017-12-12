package fireglyph.latin;
import haxe.Utf8;
import unifill.Unifill;

/**
 * ...
 * @author 
 */
class Latin
{
	private static var _basic:Array<String>;
	private static var _basicInt:Array<Int>;
	private static var _extended:Array<String>;
	private static var _extendedInt:Array<Int>;
	private static var _init:Bool = false;
	
	public static function containsBasicLatin(str:String):Bool
	{
		init();
		for (char in _basic)
		{
			if (Unifill.uIndexOf(str, char) != -1)
			{
				return true;
			}
		}
		return false;
	}
	
	public static function containsExtendedLatin(str:String):Bool
	{
		init();
		for (char in _extended)
		{
			if (Unifill.uIndexOf(str, char) != -1)
			{
				return true;
			}
		}
		return false;
	}
	
	public static function containsOnlyBasicLatin(str:String):Bool
	{
		init();
		var result = true;
		var fail = 0;
		var i = 0;
		var test = Unifill.uSplit(str, "");
		for (char in test){
			if (char == "" || char == "\r" || char == "\n") continue;
			if (_basic.indexOf(char) == -1){
				result = false;
				fail = Unifill.uCharCodeAt(char, 0);
				break;
			}
		}
		var sb = new StringBuf();
		sb.addChar(fail);
		var failChar = sb.toString();
		return result;
	}
	
	public static function containsOnlyExtendedLatin(str:String):Bool
	{
		init();
		var result = true;
		var fail = 0;
		var i = 0;
		var test = Unifill.uSplit(str, "");
		for (char in test){
			if (char == "" || char == "\r" || char == "\n") continue;
			if (_extended.indexOf(char) == -1){
				result = false;
				fail = Unifill.uCharCodeAt(char, 0);
				break;
			}
		}
		var sb = new StringBuf();
		sb.addChar(fail);
		var failChar = sb.toString();
		return result;
	}
	
	private static function init()
	{
		if (_init) return;
		buildBasic();
		buildExtended();
		_init = true;
	}
	
	private static function buildBasic()
	{
		_basic = 
		[
			" ", "!", '"', "#", "$", "%", "&", "'", "(", ")", "*",
			"+", ",", "-", ".", "/", "0", "1", "2", "3", "4", "5",
			"6", "7", "8", "9", ":", ";", "<", "=", ">", "?", "@",
			"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K",
			"L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V",
			"W", "X", "Y", "Z", "[", "\\","]", "^", "_", "`", "a",
			"b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l",
			"m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w",
			"x", "y", "z", "{", "|", "}", "~",  "",
		];
		_basicInt = [];
		for (char in _basic)
		{
			_basicInt.push(Unifill.uCharCodeAt(char, 0));
		}
	}
	
	private static function buildExtended()
	{
		_extended = 
		[
			" ", "!", '"', "#", "$", "%", "&", "'", "(", ")", "*",
			"+", ",", "-", ".", "/", "0", "1", "2", "3", "4", "5",
			"6", "7", "8", "9", ":", ";", "<", "=", ">", "?", "@",  "",
			"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K",
			"L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V",
			"W", "X", "Y", "Z", "[", "\\","]", "^", "_", "`", "a",
			"b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l",
			"m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w",
			"x", "y", "z", "{", "|", "}", "~", " ", "¡", "¢", "£",
			"¤", "¥", "¦", "§", "¨", "©", "ª", "«", "¬", "­", "®",
			"¯", "°", "±", "²", "³", "´", "µ", "¶", "·", "¸", "¹",
			"º", "»", "¼", "½", "¾", "¿", "À", "Á", "Â", "Ã", "Ä",
			"Å", "Æ", "Ç", "È", "É", "Ê", "Ë", "Ì", "Í", "Î", "Ï",
			"Ð", "Ñ", "Ò", "Ó", "Ô", "Õ", "Ö", "×", "Ø", "Ù", "Ú",
			"Û", "Ü", "Ý", "Þ", "ß", "à", "á", "â", "ã", "ä", "å",
			"æ", "ç", "è", "é", "ê", "ë", "ì", "í", "î", "ï", "ð",
			"ñ", "ò", "ó", "ô", "õ", "ö", "÷", "ø", "ù", "ú", "û",
			"ü", "ý", "þ", "ÿ", "Ā", "ā", "Ă", "ă", "Ą", "ą", "Ć",
			"ć", "Ĉ", "ĉ", "Ċ", "ċ", "Č", "č", "Ď", "ď", "Đ", "đ",
			"Ē", "ē", "Ĕ", "ĕ", "Ė", "ė", "Ę", "ę", "Ě", "ě", "Ĝ",
			"ĝ", "Ğ", "ğ", "Ġ", "ġ", "Ģ", "ģ", "Ĥ", "ĥ", "Ħ", "ħ",
			"Ĩ", "ĩ", "Ī", "ī", "Ĭ", "ĭ", "Į", "į", "İ", "ı", "Ĳ",
			"ĳ", "Ĵ", "ĵ", "Ķ", "ķ", "ĸ", "Ĺ", "ĺ", "Ļ", "ļ", "Ľ",
			"ľ", "Ŀ", "ŀ", "Ł", "ł", "Ń", "ń", "Ņ", "ņ", "Ň", "ň",
			"ŉ", "Ŋ", "ŋ", "Ō", "ō", "Ŏ", "ŏ", "Ő", "ő", "Œ", "œ",
			"Ŕ", "ŕ", "Ŗ", "ŗ", "Ř", "ř", "Ś", "ś", "Ŝ", "ŝ", "Ş",
			"ş", "Š", "š", "Ţ", "ţ", "Ť", "ť", "Ŧ", "ŧ", "Ũ", "ũ",
			"Ū", "ū", "Ŭ", "ŭ", "Ů", "ů", "Ű", "ű", "Ų", "ų", "Ŵ",
			"ŵ", "Ŷ", "ŷ", "Ÿ", "Ź", "ź", "Ż", "ż", "Ž", "ž", "ſ",
			"Ə", "ƒ", "Ơ", "ơ", "Ư", "ư", "Ǻ", "ǻ", "Ǽ", "ǽ", "Ǿ",
			"ǿ", "Ș", "ș", "Ț", "ț", "ȷ", "Ẁ", "ẁ", "Ẃ", "ẃ", "Ẅ",
			"ẅ", "ẞ", "‒", "–", "—", "―", "‗", "‘", "’", "‚", "‛",
			"“", "”", "„", "‟", "†", "‡", "•", "…", " ", "‰", "′",
			"″", "‴", "‹", "›", "‼", "‾", "⁄", "Ɑ", "ⱱ", "Ⱳ", "ⱳ",
			"ꞈ", "꞉", "꞊", "Ꞌ", "ꞌ"
		];
		_extendedInt = [];
		for (char in _extended)
		{
			_extendedInt.push(Unifill.uCharCodeAt(char, 0));
		}
	}
}