package firetongue.alphabet.japanese;

/**
 * See https://en.wikipedia.org/wiki/Katakana
 * @author larsiusprime
 */
class Katakana
{
	/**
	 * Applies a diacritic mark to a base katakana character if possible
	 * @param	character a base katakana character
	 * @param	diacritic dakuten ("゛") or handakuten ("゜")
	 * @return	the final marked character, or the original character if the combination is invalid
	 */
	public static function applyDiacritic(character:String, diacritic:String):Array<String>
	{
		return switch(diacritic)
		{
			case "゛":
				switch(character)
				{
					case "カ": "ガ";
					case "キ": "ギ";
					case "ク": "グ";
					case "ケ": "ゲ";
					case "コ": "ゴ";
					case "サ": "ザ";
					case "シ": "ジ";
					case "ス": "ズ";
					case "セ": "ゼ";
					case "ソ": "ゾ";
					case "タ": "ダ";
					case "チ": "ヂ";
					case "ツ": "ヅ";
					case "テ": "デ";
					case "ト": "ド";
					case "ハ": "バ";
					case "ヒ": "ビ";
					case "フ": "ブ";
					case "ヘ": "ベ";
					case "ホ": "ボ";
					default: character;
				}
			case "゜":
				switch(character)
				{
					case "ハ": "パ";
					case "ヒ": "ピ";
					case "フ": "プ";
					case "ヘ": "ペ";
					case "ホ": "ポ";
					default: character;
				}
			default: character;
		}
	}
	
	/**
	 * Strips any diacritic marks from a katakana character, if possible
	 * @param	character a katakana character
	 * @return	the unmarked version of the character, or the original character if it had no diacritic
	 */
	public static function removeDiacritic(character:String):Array<String>
	{
		return switch(character)
		{
			case "ガ":"カ";
			case "ギ":"キ";
			case "グ":"ク";
			case "ゲ":"ケ";
			case "ゴ":"コ";
			case "ザ":"サ";
			case "ジ":"シ";
			case "ズ":"ス";
			case "ゼ":"セ";
			case "ゾ":"ソ";
			case "ダ":"タ";
			case "ヂ":"チ";
			case "ヅ":"ツ";
			case "デ":"テ";
			case "ド":"ト";
			case "バ":"ハ";
			case "ビ":"ヒ";
			case "ブ":"フ";
			case "ベ":"ヘ";
			case "ボ":"ホ": 
			case "パ":"ハ";
			case "ピ":"ヒ";
			case "プ":"フ";
			case "ペ":"ヘ";
			case "ポ":"ホ": 
			default: character;
		}
	}
	
	/**
	 * Returns an array of diacritics that can be applied to katakana characters
	 * @return
	 */
	public static function getDiacritics():Array<String>
	{
		return ["゛", "゜"];
	}
	
	/**
	 * Returns an array of katakana functional marks
	 * @return
	 */
	public static function getFunctionalMarks():Array<String>
	{
		return ["ッ", "ー", "ヽ"];
	}
	
	/**
	 * Returns an array of katakana characters, without variations marked with diacritics
	 * @return
	 */
	public static function getBaseCharacters():Array<String>
	{
		return [
			"ア","イ","ウ","エ","オ",
			"カ","キ","ク","ケ","コ",
			"サ","シ","ス","セ","ソ",
			"タ","チ","ツ","テ","ト",
			"ナ","ニ","ヌ","ネ","ノ",
			"ハ","ヒ","フ","ヘ","ホ",
			"マ","ミ","ム","メ","モ",
			"ヤ",    "ユ",    "ヨ",
			"ラ","リ","ル","レ","ロ",
			"ワ","ヰ",    "ヱ","ヲ",
			         "ン"
		];
	}
	
	/**
	 * Returns an array of the small-form katakana characters
	 * @return
	 */
	public static function getSmallCharacters():Array<String>
	{
		return [
			"ァ","ィ","ゥ","ェ","ォ","ヵ","ヶ","ッ","ャ","ュ","ョ","ヮ"
		];
	}
	
	/**
	 * Returns an array of katakana characters, including variations marked with diacritics and small forms
	 * @return
	 */
	public static function getAllCharacters():Array<String>
	{
		return [
			"ア","イ","ウ","エ","オ",
			"カ","キ","ク","ケ","コ",
			"ガ","ギ","グ","ゲ","ゴ",
			"サ","シ","ス","セ","ソ",
			"ザ","ジ","ズ","ゼ","ゾ",
			"タ","チ","ツ","テ","ト",
			"ダ","ヂ","ヅ","デ","ド",
			"ナ","ニ","ヌ","ネ","ノ",
			"ハ","ヒ","フ","ヘ","ホ",
			"バ","ビ","ブ","ベ","ボ",
			"パ","ピ","プ","ペ","ポ",
			"マ","ミ","ム","メ","モ",
			"ヤ",    "ユ",    "ヨ",
			"ラ","リ","ル","レ","ロ",
			"ワ","ヰ",    "ヱ","ヲ",
			        "ン",
			"ァ","ィ","ゥ","ェ","ォ","ヵ","ヶ","ッ","ャ","ュ","ョ","ヮ"
		];
	}
	
	/**
	 * Returns an array of half-width katakana characters
	 * @return
	 */
	public static function getHalfWidthCharacters():Array<String>
	{
		return [
			"｡","｢","｣","､","･","ｦ","ｧ","ｨ","ｩ","ｪ","ｫ","ｬ","ｭ","ｮ","ｯ",
			"ｰ","ｱ","ｲ","ｳ","ｴ","ｵ","ｶ","ｷ","ｸ","ｹ","ｺ","ｻ","ｼ","ｽ","ｾ","ｿ",
			"ﾀ","ﾁ","ﾂ","ﾃ","ﾄ","ﾅ","ﾆ","ﾇ","ﾈ","ﾉ","ﾊ","ﾋ","ﾌ","ﾍ","ﾎ","ﾏ",
			"ﾐ","ﾑ","ﾒ","ﾓ","ﾔ","ﾕ","ﾖ","ﾗ","ﾘ","ﾙ","ﾚ","ﾛ","ﾜ","ﾝ","ﾞ","ﾟ"
		];
	}
	
	/**
	 * Converts a normal katakana character to it's corresponding small-form, if possible
	 * @param	character
	 * @return	the small-form version of the character, if it exists; otherwise the original character
	 */
	public static function bigToSmall(character:String):String
	{
		return switch(character)
		{
			case "ア":"ァ";
			case "イ":"ィ";
			case "ウ":"ゥ";
			case "エ":"ェ";
			case "オ":"ォ";
			case "カ":"ヵ";
			case "ケ":"ヶ";
			case "ツ":"ッ";
			case "ヤ":"ャ";
			case "ユ":"ュ";
			case "ヨ":"ョ";
			case "ワ":"ヮ":
			default: character;
		}
	}
	
	/**
	 * Converts a small-form katakana character to it's corresponding large-form, if possible
	 * @param	character
	 * @return	the large form version of the character, if it exists; otherwise the original character
	 */
	public static function smallToBig(character:String):String
	{
		return switch(character)
		{
			case "ァ":"ア";
			case "ィ":"イ";
			case "ゥ":"ウ";
			case "ェ":"エ";
			case "ォ":"オ";
			case "ヵ":"カ";
			case "ヶ":"ケ";
			case "ッ":"ツ";
			case "ャ":"ヤ";
			case "ュ":"ユ";
			case "ョ":"ヨ";
			case "ヮ":"ワ";
			default: character;
		}
	}
}