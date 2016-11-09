# fireglyph
A simple localization utility library for alphabets, glyphs, and other writing systems.

Note: Fireglyph is *not* a full-fledged CJK Input Method Editor, nor does it aspire to be. It's just a simple library that embodies the basic rules about how certain writing systems work.

## Korean:

Composing [hangul](https://en.wikipedia.org/wiki/Hangul) characters from [jamo](https://en.wikipedia.org/wiki/Hangul_consonant_and_vowel_tables) components:

```haxe
var hangul = new Hangul();
var nog = hangul.compose("ㄴ", "ㅗ", "ㄱ");
trace("nog"); //prints "녹";
```

You must create an instance of Hangul in order to compose characters. This is because it must construct an internal lookup table to do the work. I'm not sure if I should try making that static or not, we'll see.

A complete list of jamos can be retrieved by calling `Hangul.getLeadConsonants()`, `Hangul.getTailConsonants()`, and `Hangul.getVowels()`. 

###Conjoining vs. Compatibility Jamos

Korean composes hangul characters like 녹 from component characters called jamos, like ㄴ, ㅗ, and ㄱ. For complex reasons I won't get into here, jamos can be found in two different forms, *conjoining* and *compatibility*. Long story short, they represent the exact same written character, but have unique unicode values and will fail naive character equivalency tests; I think *compatibility* jamos exist for being displayed as isolated characters on websites. When calling any of the above three functions to retrieve a list of jamos, you may pass in a boolean that will switch whether it returns conjoining or compatibility jamos.

The `compose()` function will automatically convert from compatibility jamos to conjoining jamos, so you don't have to worry about what kind you're passing in.

## Japanese:

###Katakana
Applying diacritics to [katakana](https://en.wikipedia.org/wiki/Katakana) characters:
```haxe
var character = Katakana.applyDiacritic("゛","カ");
trace(character); //prints "ガ";
```

You can retrieve an array of diacritics with `Katakana.getDiacritics()` and a list of base characters with `Katakana.getBaseCharacters()`. Calling `Katakana.getAllCharacters()` will return all katakana characters, including character variations with diacritics applied. You can also call `Katakana.getFunctionalMarks()` and `Katakana.getHalfWidthCharacters()` to get those.


###Hiragana
Applying diacritics to [hiragana](https://en.wikipedia.org/wiki/Hiragana) characters:
```haxe
var character = Hiragana.applyDiacritic("゛","か");
trace(character); //prints "が";
```

You can retrieve an array of diacritics with `Hiragana.getDiacritics()` and a list of base characters with `Hiragana.getBaseCharacters()`. Calling `Hiragana.getAllCharacters()` will return all hiragana characters, including character variations with diacritics applied. You can also call `Hiragana.getFunctionalMarks()`.

###Kanji
Fireglyph does not currently deal with Kanji at all.
