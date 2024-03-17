MuseScore plugin to add integer notation (pitch class / chromatic scale) or numbered notation (Jianpu).

[Download from MuseScore Plugin](https://musescore.org/en/project/add-integer-notation-or-numbered-notation)

---


**Normal version**: Add notation above or below staves, for entire score or selection.
普通版：将数字谱号添加在谱表上方或下方。应用于整张谱或选中的部分。

**Inside version**: Add notation on noteheads and hide noteheads, for entire score or selection.
内部版：将数字谱号添加在符头位置，并隐藏符头。应用于整张谱或选中的部分。

The notation format can be 0-11 (pitch class) or 1-7 (Jianpu, with # or b), with customizable reference note (the note corresponding to 0 or 1).
数字谱号可选格式：音高集合0-11或简谱1-7（带升降号）。可自定义参考音（0或1对应的音符）。

_Only supports MuseScore v4._  
_Experimental, may not work perfectly._  
_Please backup your sheets!_  
仅支持MuseScore v4。  
试验用途，效果不尽完美。  
请备份乐谱！  

#### Screenshot | 截图

Nocturne Op.9 No.2 in Eb Major by Chopin  
0 = Eb4

Normal version | 普通版  
<img src="https://cdn.jsdelivr.net/gh/King-of-Infinite-Space/MuseScore-Integer-Notation/screenshot/Example_new1.png" width="400px"/>

Inside version (without vertical re-positioning and octave dots, stave lines hidden manually) | 内部版（无纵向重排和八度点号，手动隐藏了谱线）  
<img src="https://cdn.jsdelivr.net/gh/King-of-Infinite-Space/MuseScore-Integer-Notation/screenshot/Example_new2.png" width="400px"/>

Inside version (with vertical re-positioning, stave lines hidden manually) | 内部版（纵向重排，手动隐藏了谱线）  
<img src="https://cdn.jsdelivr.net/gh/King-of-Infinite-Space/MuseScore-Integer-Notation/screenshot/Example_new3.png" width="400px"/>


<img src="https://count.lnfinite.space/repo/musescore-integer-notation.svg?plus=1" width="0px"/>

#### Why use pitch class | 为什么使用音高集合

Why not? "Pitch class" represents twelve notes in an octave by numbers 0~11. This notation is intuitive and straighforward because people already know how to do arithmetic and how to read the clock face. Intervals are simply differences between numbers. For example, if the tonic is 0, then the major scale is 0, 2, 4, 5, 7, 9, 11.   
为什么不？“音高集合”用数字0~11表示八度里的12个音。这种形式简单直观，因为人们本来已经会做算术以及读钟表。数字之差就是音程。例如，如果主音是0，那么大调音阶就是0、2、4、5、7、9、11。

#### Remark | 说明

On Insider version, to distinguish between quarter notes and half notes after noteheads are hidden, numbers on half notes are _italicized_.   
内部版中，为区分隐藏符头后的四分音符和二分音符，二分音符上的数字用斜体显示。

To achieve a clean look on Inside Version, some manually settings are recommended 为了让内部版更美观，推荐以下手动设置
-   If re-position notes, turn on "Invisible staff lines" (Right click on a measure > Stave/Part properties). 如果纵向重排，打开“隐藏谱线”（右击小节 > 谱表/分谱属性）。
-   If not re-position notes,set Lines = 1, Line distance >= 1.25 sp, turn off Show leger lines (Right click on a measure > Stave/Part properties > Advanced style properties). 如果不纵向重排，设置“谱线”=1、“谱线间距”至少1.25、打开“取消显示加线”（右击小节 > 谱表/分谱属性 > 高级样式属性）。
-   Reducing the width of stems to around 0.06 (Right click on stem > Select > Similar > Properties (main panel) > Show more). 将符干粗细减小到0.06左右（右击符干 > 选择 > 相似内容 > 属性(主面板) > 显示更多）。

#### Additional remark | 额外说明

Insider version hides noteheads by either (1) setting their colors to background color or (2) setting their visibility to false. Option 1 is recommended because the notes remain selectable, but the noteheads have tiny overlaps with stems. Option 2 doesn't have this overlap but the numbers on adjacent line and space overlap. Also the notes are not selectable unless "Show Invisible" is on (Click empty space on the score > Properties main panel).   
内部版有两种方式隐藏符头：(1) 将颜色改为背景颜色 (2) 设为不可见。更推荐选项(1)，因为音符仍可选中，但符头和符干有微小重叠。选项2不会出现这种重叠，但是相邻线和间上的数字会重叠。而且音符不可选中，除非打开了“不可见元素”（点击乐谱空白 > 属性主面板）。

Normal version adds texts as "staff text" with subtype "User-12" and extra styles. Inside version adds texts as "fingering" with subtype "User-11" and extra styles. The subtype allows easy selection of all added texts (Right click on text > Select > More > Same subtype). Users can also change the subtype to customize styles.   
普通版添加的文本为“谱表文本”，子类型为“用户-12”，并应用了额外的样式。内部版添加的文本为“指法”，子类型为“用户-11”，并应用了额外的样式。子类型可用来方便地选择所有添加的文本（右击文本 > 选择 > 更多 > 同一子类型）。用户也可以通过改变子类型来自定义样式。


#### Acknowledgement | 致谢

[Notation Must Die: The Battle For How We Read Music - YouTube](https://www.youtube.com/watch?v=Eq3bUFgEcb4&t=4012)   
[Jianpu Numbered Notation - MuseScore Plugin](https://musescore.org/en/project/jianpu-numbered-notation-0)   
[Element Analyser - MuseScore Plugin](https://musescore.org/en/project/element-analyser)