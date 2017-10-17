package fireglyph.util;
import unifill.CodePoint;
import unifill.Unifill;

/**
 * ...
 * @author 
 */
class Util 
{

	/**
	 * Unicode-aware replacement function
	 * @param	string what you want to modify
	 * @param	substr what you want to match
	 * @param	by what you want to replace with
	 * @param	recursive keep doing it until you can't find any more matches (vs. doing only 1 pass)
	 * @return
	 */
	public static function uReplace(s:String, substr:String, by:String, recursive:Bool=true, failsafe:Int=0):String
	{
		var arr = Unifill.uSplit(s, substr);
		
		var sub = new StringBuf();
		for (i in 0...arr.length)
		{
			sub.add(arr[i]);
			if (i != arr.length - 1)
			{
				sub.add(by);
			}
		}
		return sub.toString();
	}
	
	public static function strToCodePoints(s:String):Array<CodePoint>
	{
		if (s == null || s == "") return [];
		
		var strArr:Array<CodePoint> = [];
		//turn the main string into an array of code points
		var iter = Unifill.uIterator(s);
		
		var fail = false;
		while (iter.hasNext())
		{
			try
			{
				var cp = iter.next();
				strArr.push(cp);
			}
			catch (msg:Dynamic)
			{
				fail = true;
				break;
			}
		}
		
		if (fail)
		{
			//alright, do it the hard way:
			strArr = [];
			var len = Unifill.uLength(s);
			for (i in 0...len)
			{
				strArr.push(Unifill.uCodePointAt(s, i));
			}
		}
		
		return strArr;
	}
}