package fireglyph.korean;
import unifill.Unifill;

/**
 * Revised Romanization Of Korea rules for converting between Hangul and Roman characters
 * Ported from this TypeScript implementation: https://github.com/Tyriar/hangul-romanization
 * @author larsiusprime
 */
class RROK
{
	private static var inited:Bool = false;
	private static var vowels:Array<String>;
	private static var consonantsInitial:Array<String>;
	private static var consonantsFinal:Array<String>;
	
	private static var hangul:Hangul;
	
	private static inline var UNICODE_OFFSET:Int = 44032;
	private static inline var UNICODE_MAX:Int = 55215;
	
	public static function containsHangul(str:String):Bool
	{
		var ulen = Unifill.uLength(str);
		for (i in 0...ulen)
		{
			if (isHangulCharacter(str, i))
			{
				return true;
			}
		}
		return false;
	}
	
	public static function convertCharacter(char:String, compose:Bool=false)
	{
		init();
		var result = "";
		
		var lead:String = "";
		var vowel:String = "";
		var tail:String = "";
		
		var charCode:Int = Unifill.uCharCodeAt(char, 0);
		var isHangul = charCode >= UNICODE_OFFSET && charCode < UNICODE_MAX;
		
		if (isHangul)
		{
			var unicodeOffset:Int = charCode - UNICODE_OFFSET;
			var tailOffset:Int = unicodeOffset % consonantsFinal.length;
			unicodeOffset -= tailOffset;
			unicodeOffset = Std.int(unicodeOffset / consonantsFinal.length);
			
			var vowelOffset:Int = unicodeOffset % vowels.length;
			unicodeOffset -= vowelOffset;
			unicodeOffset = Std.int(unicodeOffset / vowels.length);
			
			var leadOffset:Int = unicodeOffset;
			
			lead = consonantsInitial[leadOffset];
			vowel = vowels[vowelOffset];
			tail = consonantsFinal[tailOffset];
		}
		else
		{
			return char;
		}
		
		if (compose)
		{
			if (hangul == null)
			{
				hangul = new Hangul();
			}
			result = hangul.compose(lead, vowel, tail);
		}
		else
		{
			result = lead + vowel + tail;
		}
		
		return result;
	}
	
	public static function fromHangul(str:String):String
	{
		var result = "";
		var ulen = Unifill.uLength(str);
		for (i in 0...ulen)
		{
			result += convertCharacter(Unifill.uCharAt(str, i));
		}
		return result;
	}
	
	/****PRIVATE****/
	
	private static function buildVowels()
	{
		vowels = [
			'a',   // ㅏ
			'ae',  // ㅐ
			'ya',  // ㅑ
			'yee', // ㅒ
			'eo',  // ㅓ
			'e',   // ㅔ
			'yeo', // ㅕ
			'ye',  // ㅖ
			'o',   // ㅗ
			'wa',  // ㅘ
			'wae', // ㅙ
			'oe',  // ㅚ
			'yo',  // ㅛ
			'u',   // ㅜ
			'wo',  // ㅝ
			'we',  // ㅞ
			'wi',  // ㅟ
			'yu',  // ㅠ
			'eu',  // ㅡ
			'ui',  // ㅢ
			'i'    // ㅣ
		];
	}
	
	private static function buildConsonants()
	{
		consonantsInitial = [
			'g',  // ㄱ
			'kk', // ㄲ
			'n',  // ㄴ
			'd',  // ㄷ
			'tt', // ㄸ
			'r',  // ㄹ
			'm',  // ㅁ
			'b',  // ㅂ
			'pp', // ㅃ
			's',  // ㅅ
			'ss', // ㅆ
			'',   // ㅇ
			'j',  // ㅈ
			'jj', // ㅉ
			'ch', // ㅊ
			'k',  // ㅋ
			't',  // ㅌ
			'p',  // ㅍ
			'h'   // ㅎ
		];
		
		consonantsFinal = [
			'',
			'k',  // ㄱ
			'k',  // ㄲ
			'kt', // ㄳ
			'n',  // ㄴ
			'nt', // ㄵ
			'nh', // ㄶ
			't',  // ㄷ
			'l',  // ㄹ
			'lk', // ㄺ
			'lm', // ㄻ
			'lp', // ㄼ
			'lt', // ㄽ
			'lt', // ㄾ
			'lp', // ㄿ
			'lh', // ㅀ
			'm',  // ㅁ
			'p',  // ㅂ
			'pt', // ㅄ
			't',  // ㅅ
			'tt', // ㅆ
			'ng', // ㅇ
			't',  // ㅈ
			't',  // ㅊ
			'k',  // ㅋ
			't',  // ㅌ
			'p',  // ㅍ
			'h'   // ㅎ
		];
	}
	
	private static function init() 
	{
		if (inited) return;
		buildVowels();
		buildConsonants();
		inited = true;
	}
	
	private static function isHangulCharacter(str:String, i:Int=0):Bool
	{
		var charCode:Int = Unifill.uCharCodeAt(str, i);
		var isHangul = charCode >= UNICODE_OFFSET && charCode < UNICODE_MAX;
		return isHangul;
	}
}