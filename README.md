MuseScore plugin to add integer notation (pitch class / chromatic scale) or numbered notation (Jianpu).

[Download from MuseScore Plugin](https://musescore.org/en/project/add-integer-notation-or-numbered-notation)

---


**Normal version**: Add notation above or below staves, for entire score or selection.
普通版：将数字谱号添加在谱表上方或下方。应用于整张谱或选中的部分。

**Inside version**: Add notation on noteheads and hide noteheads, for entire score or selection.
内部版：将数字谱号添加在符头位置，并隐藏符头。应用于整张谱或选中的部分。

The notation format can be 0~11 (pitch class) or 1~7 (Jianpu, with # and b). The reference note (the note corresponding to 0 or 1) is customizable.
数字谱号可选格式：音高集合0~11或简谱1~7（带升降号）。参考音（0或1对应的音符）可自定义。

_Experimental, may have issues._ Developed on MuseScore v4, may also work on v3.
试验用途，可能存在问题。开发版本为MuseScore v4，可能也适用于v3。

#### Screenshot | 截图

Normal version | 普通版
<img src="https://cdn.jsdelivr.net/gh/King-of-Infinite-Space/MuseScore-Integer-Notation/screenshot/Example_new1.png" width="400px"/>

Inside version (stave lines hidden manually) | 内部版（手动隐藏了谱线）
<img src="https://cdn.jsdelivr.net/gh/King-of-Infinite-Space/MuseScore-Integer-Notation/screenshot/Example_new2.png" width="400px"/>

<img src="https://count.lnfinite.space/repo/musescore-integer-notation.svg?plus=1" width="0px"/>



#### Additional remark | 额外说明

On Insider version, to distinguish between quarter notes and half notes after noteheads are hidden, numbers on half notes are italicized.
内部版中，为区分隐藏符头后的四分音符和二分音符，二分音符上的数字用斜体显示。

To achieve a clean look on Inside Version, I recommend manually setting Lines = 1, Line distance >= 1.25 sp, turn off Show leger lines (Right click on a measure > Stave/Part properties > Advanced style properties). Additionally, reducing the width of stems to around 0.06 may help (Right click on stem > Select > Similar > Properties (main panel) > Show more).
为了让内部版更美观，推荐以下手动设置：谱线=1、谱线间距至少1.25、取消显示加线（右击小节 > 谱表/分谱属性 > 高级样式属性）。另外，将符干粗细减小到0.06左右可能也有帮助（右击符干 > 选择 > 相似内容 > 属性(主面板) > 显示更多）。

Normal version adds texts as "staff text" with subtype "User-12" and extra styles. Inside version adds texts as "fingering" with subtype "User-11" and extra styles. The subtype allows easy selection of all added texts (Right click on text > Select > More > Same subtype). Users can also change the subtype to customize styles.
普通版添加的文本为“谱表文本”，子类型为“用户-12”，并应用了额外的样式。内部版添加的文本为“指法”，子类型为“用户-11”，并应用了额外的样式。子类型可用来方便地选择所有添加的文本（右击文本 > 选择 > 更多 > 同一子类型）。用户也可以通过改变子类型来自定义样式。

Insider version hides noteheads by either (1) setting their colors to background color or (2) setting their visibility to false. Option 1 is recommended because the notes remain selectable, but the noteheads have tiny overlaps with stems. Option 2 doesn't have this overlap but the numbers on adjacent line and space overlap. Also the notes are not selectable unless "Show Invisible" is on (Click empty space on the score > Properties main panel).
内部版有两种方式隐藏符头：(1) 将颜色改为背景颜色 (2) 设为不可见。更推荐选项(1)，因为音符仍可选中，但符头和符干有微小重叠。选项2不会出现这种重叠，但是相邻线和间上的数字会重叠。而且音符不可选中，除非打开了“不可见元素”（点击乐谱空白 > 属性主面板）。



#### Credit | 致谢

[Notation Must Die: The Battle For How We Read Music - YouTube](https://www.youtube.com/watch?v=Eq3bUFgEcb4&t=4012)

[Jianpu Numbered Notation - MuseScore Plugin](https://musescore.org/en/project/jianpu-numbered-notation-0)

[Element Analyser - MuseScore Plugin](https://musescore.org/en/project/element-analyser)
