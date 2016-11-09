package firetongue.alphabet.korean;

/**
 * See https://en.wikipedia.org/wiki/Hangul
 * @author larsiusprime
 */
class Jamo
{
	/**
	 * Get all leading consonant jamo characters
	 * @param	conjoining	true: return conjoining jamos only. false: return compatibility jamos only.
	 * @return
	 */
	public static function getLeadConsonants(conjoining:Bool=true):Array<String>
	{
		if (conjoining) 
			return ["ᄀ", "ᄁ", "ᄂ", "ᄃ", "ᄄ", "ᄅ", "ᄆ", "ᄇ", "ᄈ", "ᄉ", "ᄊ", "ᄋ", "ᄌ", "ᄍ", "ᄎ", "ᄏ", "ᄐ", "ᄑ", "ᄒ"];
		else
			return ["ㄱ", "ㄲ", "ㄴ", "ㄷ", "ㄸ", "ㄹ", "ㅁ", "ㅂ", "ㅃ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅉ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"];
	}
	
	/**
	 * Get all tail consonant jamo characters
	 * @param	conjoining	true: return conjoining jamos only. false: return compatibility jamos only.
	 * @return
	 */
	public static function getTailConsonants(conjoining:Bool=true):Array<String>
	{
		if (conjoining)
			return ["ᆨ", "ᆩ", "ᆪ", "ᆫ", "ᆬ", "ᆭ", "ᆮ", "ᆯ", "ᆰ", "ᆱ", "ᆲ", "ᆳ", "ᆴ", "ᆵ", "ᆶ", "ᆷ", "ᆸ", "ᆹ", "ᆺ", "ᆻ", "ᆼ", "ᆽ", "ᆾ", "ᆿ", "ᇀ", "ᇁ", "ᇂ"];
		else
			return ["ㄱ", "ㄲ", "ㄳ", "ㄴ", "ㄵ", "ㄶ", "ㄷ", "ㄹ", "ㄺ", "ㄻ", "ㄼ", "ㄽ", "ㄾ", "ㄿ", "ㅀ", "ㅁ", "ㅂ", "ㅄ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"];
	}
	
	/**
	 * Get all vowel jamo characters
	 * @param	conjoining	true: return conjoining jamos only. false: return compatibility jamos only.
	 * @return
	 */
	public static function getVowels(conjoining:Bool=true):Array<String>
	{
		if (conjoining)
			return ["ᅡ", "ᅢ", "ᅣ", "ᅤ", "ᅥ", "ᅦ", "ᅧ", "ᅨ", "ᅩ", "ᅪ", "ᅫ", "ᅬ", "ᅭ", "ᅮ", "ᅯ", "ᅰ", "ᅱ", "ᅲ", "ᅳ", "ᅴ", "ᅵ"];
		else
			return ["ㅏ", "ㅐ", "ㅑ", "ㅒ", "ㅓ", "ㅔ", "ㅕ", "ㅖ", "ㅗ", "ㅘ", "ㅙ", "ㅚ", "ㅛ", "ㅜ", "ㅝ", "ㅞ", "ㅟ", "ㅠ", "ㅡ", "ㅢ", "ㅣ"];
	}
}