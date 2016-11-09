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
	 * Returns an array of hiragana characters, including variations marked with diacritics
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
			"ん","ゔ"
		];
	}
}