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
		if (Unifill.uIndexOf(s, substr) == -1) return s;
		if (failsafe > 1000)
		{
			trace("FAILSAFE TRIGGERED x" + failsafe + "(" + s + "," + substr + "," + by + "," + recursive+")");
			return s;
		}
		failsafe++;
		
		var result:Array<CodePoint> = [];
		var strArr:Array<CodePoint> = strToCodePoints(s);			//turn the main string into an array of code points
		var substrArr:Array<CodePoint> = strToCodePoints(substr);	//turn the substr into an array of code points
		var byArr:Array<CodePoint> = strToCodePoints(by);			//turn the by str into an array of code points
		
		var matchI:Int = 0;
		var onMatch = false;
		var fullMatch = false;
		
		var tempMatchArr:Array<CodePoint> = [];
		
		for (i in 0...strArr.length)
		{
			//iterate through the main string code point by code point
			var cp:CodePoint = strArr[i];
			
			if (matchI < substrArr.length && cp == substrArr[matchI])
			{
				//detected the substr -- advance but don't write to the buffer
				onMatch = true;
				matchI++;
				tempMatchArr.push(cp);
				if (tempMatchArr.length == substrArr.length)
				{
					//write the replacement str to the result
					for (i in 0...byArr.length)
					{
						result.push(byArr[i]);
					}
					matchI = 0;
					onMatch = false;
					tempMatchArr = [];
				}
			}
			else
			{
				if (onMatch)
				{
					//stop ignoring the partially matched str by dumping it to the result
					for (i in 0...tempMatchArr.length)
					{
						result.push(tempMatchArr[i]);
					}
					matchI = 0;
					onMatch = false;
					tempMatchArr = [];
				}
				//write the character to the result
				result.push(cp);
			}
		}
		
		if (tempMatchArr.length > 0)
		{
			if (tempMatchArr.length == substrArr.length)
			{
				for (i in 0...byArr.length)
				{
					result.push(byArr[i]);
				}
			}
			else
			{
				for (i in 0...tempMatchArr.length)
				{
					result.push(tempMatchArr[i]);
				}
			}
		}
		
		if (recursive)
		{
			return uReplace(Unifill.uToString(result), substr, by, true, failsafe+1);
		}
		
		//return the final string
		return Unifill.uToString(result);
	}
	
	public static function strToCodePoints(s:String):Array<CodePoint>
	{
		var strArr:Array<CodePoint> = [];
		//turn the main string into an array of code points
		var iter = Unifill.uIterator(s);
		while (iter.hasNext())
		{
			strArr.push(iter.next());
		}
		return strArr;
	}
}