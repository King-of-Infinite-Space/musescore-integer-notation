MuseScore plugin to add integer notation (pitch class / chromatic scale) or numbered notation (Jianpu).

[Download from MuseScore Plugin](https://musescore.org/en/project/add-integer-notation-or-numbered-notation)

---


Normal version: Add notation above or below staves, for entire score or selection.

Inside version: Add notation on noteheads and hide noteheads, for entire score.

The notation can be 0~11 (pitch class) or 1~7 (Jianpu).

_Experimental, may have issues._ Developed on MuseScore v4, may also work on v3.

#### Remark

Normal version adds texts as "staff text" with subtype "User-12" and extra styles. Inside version adds texts as "fingering" with subtype "User-11" and extra styles. The subtype allows easy selection of all added texts (Right click on text > Select > More > Same subtype). Users can also change the subtype to override it.

To achieve a clean look on Inside Version, I recommend setting Lines = 1, Line distance >= 1.25 sp, turn off Show leger lines (Right click on a measure > Stave/Part properties > Advanced style properties).

Insider version hides noteheads by either (1) setting their colors to background color or (2) setting their visibility to false. Option (1) is recommended because the notes remain selectable, although the noteheads have tiny overlaps with stems. Option (2) doesn't have this overlap but the added texts may overlap. Also the notes are not selectable unless "Show Invisible" is on (Click empty space on the score > Properties panel).

#### Screenshot

(beginning of Nocturne Op.9 No.2 in E♭ Major)

Normal version
<img src="https://cdn.jsdelivr.net/gh/King-of-Infinite-Space/MuseScore-Integer-Notation/screenshot/Example_new1.png" width="400px"/>

Inside version (manually hide stave lines)
<img src="https://cdn.jsdelivr.net/gh/King-of-Infinite-Space/MuseScore-Integer-Notation/screenshot/Example_new2.png" width="400px"/>

<img src="https://count.lnfinite.space/repo/musescore-integer-notation.svg?plus=1" width="0px"/>



#### Credit

[Jianpu Numbered Notation](https://musescore.org/en/project/jianpu-numbered-notation-0)

[Element Analyser](https://musescore.org/en/project/element-analyser)
