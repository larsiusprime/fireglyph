package firetongue.alphabet.japanese;

/**
 * See https://en.wikipedia.org/wiki/Hiragana
 * @author larsiusprime
 */
class Hiragana
{
	/**
	 * Applies a diacritic mark to a base hiragana character if possible
	 * @param	character a base hiragana character
	 * @param	diacritic dakuten ("゛") or handakuten ("゜")
	 * @return	the final marked character, or the original character if the combination is invalid
	 */
	public static function applyDiacritic(character:String, diacritic:String):String
	{
		return switch(diacritic)
		{
			case "゛":
				switch(character)
				{
					case "か": "が";
					case "き": "ぎ";
					case "く": "ぐ";
					case "け": "げ";
					case "こ": "ご";
					case "さ": "ざ";
					case "し": "じ";
					case "す": "ず";
					case "せ": "ぜ";
					case "そ": "ぞ";
					case "た": "だ";
					case "ち": "ぢ";
					case "つ": "づ";
					case "て": "で";
					case "と": "ど";
					case "は": "ば";
					case "ひ": "び";
					case "ふ": "ぶ";
					case "へ": "べ";
					case "ほ": "ぼ";
					case "う": "ゔ";
					default: character;
				}
			case "゜":
				switch(character)
				{
					case "は": "ぱ";
					case "ひ": "ぴ";
					case "ふ": "ぷ";
					case "へ": "ぺ";
					case "ほ": "ぽ";
					default: character;
				}
		}
	}
	
	/**
	 * Strips any diacritic marks from a hiragana character, if possible
	 * @param	character a hiragana character
	 * @return	the unmarked version of the character, or the original character if it had no diacritic
	 */
	public static function removeDiacritic(character:String):String
	{
		return switch(character)
		{
			case "が":"か";
			case "ぎ":"き";
			case "ぐ":"く";
			case "げ":"け";
			case "ご":"こ";
			case "ざ":"さ";
			case "じ":"し";
			case "ず":"す";
			case "ぜ":"せ";
			case "ぞ":"そ";
			case "だ":"た";
			case "ぢ":"ち";
			case "づ":"つ";
			case "で":"て";
			case "ど":"と";
			case "ば":"は";
			case "び":"ひ";
			case "ぶ":"ふ";
			case "べ":"へ";
			case "ぼ":"ほ";
			case "ゔ":"う";
			case "ぱ":"は";
			case "ぴ":"ひ";
			case "ぷ":"ふ";
			case "ぺ":"へ";
			case "ぽ":"ほ";
			default: character;
		}
	}
	
	/**
	 * Returns an array of diacritics that can be applied to hiragana characters
	 * @return
	 */
	public static function getDiacritics():Array<String>
	{
		return ["゛", "゜"];
	}
	
	/**
	 * Returns an array of hiragana functional marks
	 * @return
	 */
	public static function getFunctionalMarks():Array<String>
	{
		return ["っ", "ゝ"];
	}
	
	/**
	 * Returns an array of hiragana characters, without variations marked with diacritics
	 * @return
	 */
	public static function getBaseCharacters():Array<String>
	{
		return [
			"あ", "い", "う", "え", "お",
			"か", "き", "く", "け", "こ",
			"さ", "し", "す", "せ", "そ",
			"た", "ち", "つ", "て", "と",
			"な", "に", "ぬ", "ね", "の",
			"は", "ひ", "ふ", "へ", "ほ",
			"ま", "み", "む", "め", "も",
			"や","ゆ","よ",
			"ら","り","る","れ","ろ",
			"わ","ゐ","ゑ","を",
			"ん"
		];
	}
	
	/**
	 * Returns an array of small-form hiragana characters
	 * @return
	 */
	public static function getSmallCharacters():Array<String>
	{
		return [
			"ぁ", "ぃ", "ぅ", "ぇ", "ぉ", "ゕ", "ゖ", "っ", "ゃ", "ゅ", "ょ", "ゎ"
		];
	}
	
	/**
	 * Returns an array of hiragana characters, including variations marked with diacritics and small forms
	 * @return
	 */
	public static function getAllCharacters():Array<String>
	{
		return [
			"あ", "い", "う", "え", "お",
			"か", "き", "く", "け", "こ",
			"が", "ぎ", "ぐ", "げ", "ご",
			"さ", "し", "す", "せ", "そ",
			"ざ", "じ", "ず", "ぜ", "ぞ",
			"た", "ち", "つ", "て", "と",
			"だ", "ぢ", "づ", "で", "ど",
			"な", "に", "ぬ", "ね", "の",
			"は", "ひ", "ふ", "へ", "ほ",
			"ば", "び", "ぶ", "べ", "ぼ",
			"ぱ", "ぴ", "ぷ", "ぺ", "ぽ",
			"ま", "み", "む", "め", "も",
			"や","ゆ","よ",
			"ら","り","る","れ","ろ",
			"わ","ゐ","ゑ","を",
			"ん", "ゔ",
			"ぁ", "ぃ", "ぅ", "ぇ", "ぉ", "ゕ", "ゖ", "っ", "ゃ", "ゅ", "ょ", "ゎ"
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
			case "ぁ":"あ";
			case "ぃ":"い";
			case "ぅ":"う";
			case "ぇ":"え";
			case "ぉ":"お";
			case "ゕ":"か";
			case "ゖ":"け";
			case "っ":"つ";
			case "ゃ":"や";
			case "ゅ":"ゆ";
			case "ょ":"よ";
			case "ゎ":"わ";
			default: character;
		}
	}
}