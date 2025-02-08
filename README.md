MuseScore plugin to add integer notation (pitch class / chromatic scale) or numbered notation (Jianpu).

[Download from MuseScore Plugin](https://musescore.org/en/project/add-integer-notation-or-numbered-notation)

---

#### Screenshot | 截图

Nocturne Op.9 No.2 in Eb Major by Chopin  
0 = Eb4

Outside version | 外部版  
<img src="https://cdn.jsdelivr.net/gh/King-of-Infinite-Space/MuseScore-Integer-Notation/screenshot/Example_new1.png" width="400px"/>

Inside version (without vertical re-positioning and octave dots, stave lines hidden manually) | 内部版（无纵向重排和八度点号，手动隐藏了谱线）  
<img src="https://cdn.jsdelivr.net/gh/King-of-Infinite-Space/MuseScore-Integer-Notation/screenshot/Example_new2.png" width="400px"/>

Inside version (with vertical re-positioning, stave lines hidden manually) | 内部版（纵向重排，手动隐藏了谱线）  
<img src="https://cdn.jsdelivr.net/gh/King-of-Infinite-Space/MuseScore-Integer-Notation/screenshot/Example_new3.png" width="400px"/>


#### Instructions | 使用说明

Download the qml file and put it under Plugin folder. 下载qml文件并放置于插件目录。
- Windows: C:\Users\USERNAME\Documents\MuseScore4\Plugins\
- Linux & macOS: ~/Documents/MuseScore4/Plugins/

Enable the plugin using top menu bar > Plugins > Manage plugins. Then start the plugin from the Plugins menu. 先启用插件（顶部菜单栏 > 插件 > 管理插件），再通过插件菜单打开插件。

By default the plugin applies to the entire score. If certain measures are selected, then it only applies to the selection. 插件默认应用于整张谱。若有小节被选中，则仅应用于选中部分。

The notation format can be 0-11 (pitch class) or 1-7 (Jianpu, with # or b), with customizable reference note (the note corresponding to 0 or 1).
数字谱号可选格式：音高集合0-11或简谱1-7（带升降号）。可自定义参考音（0或1对应的音符）。

_Only supports MuseScore v4._  
_Experimental, may not work perfectly._  
_Please backup your sheets before trying!_  
仅支持MuseScore v4。  
试验用途，效果不尽完美。  
使用前请备份乐谱！  

#### Additional instructions | 额外说明

To achieve a clean look on Inside Version, some manually settings are recommended 为了让内部版更美观，推荐以下手动设置
-   If re-position notes, turn on "Invisible staff lines" and increase Line distance to around 1.2sp  (Right click on a measure > Stave/Part properties). If the lines are still visible, make sure "Show" > "Invisible" is off in the "Properties" panel on the left. 如果纵向重排，打开“隐藏谱线”并将“谱线间距”增加到1.2sp左右（右击任一小节 > 谱表/分谱属性）。如果谱线仍可见，确保左侧“属性”面板中“显示” > “不可见元素”处于关闭状态。
-   If not re-position notes,set Lines = 1, Line distance >= 1.25 sp, turn off Show leger lines (Right click on a measure > Stave/Part properties > Advanced style properties). 如果不纵向重排，设置“谱线”=1、“谱线间距”至少1.25、打开“取消显示加线”（右击小节 > 谱表/分谱属性 > 高级样式属性）。
-  (Optional) Reducing the width of stems (Right click on a stem > Select > Similar > Properties (main panel) > Show more). （可选）将符干粗细减小到0.06左右（右击符干 > 选择 > 相似内容 > 属性(主面板) > 显示更多）。

On Insider version, to distinguish between quarter notes and half notes after noteheads are hidden, numbers on half notes are _italicized_.   
内部版中，为区分隐藏符头后的四分音符和二分音符，二分音符上的数字用斜体显示。

#### Why use pitch class | 为什么使用音高集合

"Pitch class" represents twelve notes in an octave by numbers 0-11. This notation is intuitive and straightforward because people already know how to do arithmetic and how to read the clock face. Intervals are simply differences between numbers. For example, if the tonic is 0, then the major scale is 0, 2, 4, 5, 7, 9, 11.   
“音高集合”用数字0-11表示八度里的12个音。这种形式简单直观，因为人们本来已经会做算术以及读钟表。数字之差就是音程。例如，如果主音是0，那么大调音阶就是0、2、4、5、7、9、11。


#### Implementation details | 实现细节

Insider version hides noteheads by either (1) setting their colors to background color or (2) setting their visibility to false. Option 1 is recommended because the notes remain selectable (by clicking to the side of numbers). Option 2 causes overlap of numbers on adjacent line and space, and notes are not selectable (Unless "Show Invisible" is on. Click empty space on the score > Properties main panel).   
内部版有两种方式隐藏符头：(1) 将颜色改为背景颜色 (2) 设为不可见。更推荐选项(1)，因为音符仍可选中（点击数字外侧）。选项2使得相邻线和间上的数字重叠，且音符不可选中（除非打开了“不可见元素”：点击乐谱空白 > 属性主面板）。

Outside version adds texts as "staff text" with subtype "User-12" and extra styles. Inside version adds texts as "fingering" with subtype "User-12" and extra styles. The subtype allows easy selection of all added texts (Right click on text > Select > More > Same subtype). Users can also change the subtype to customize styles.   
外部版添加的文本为“谱表文本”，子类型为“用户-12”，并应用了额外的样式。内部版添加的文本为“指法”，子类型为“用户-12”，并应用了额外的样式。子类型可用来方便地选择所有添加的文本（右击文本 > 选择 > 更多 > 同一子类型）。用户也可以通过改变子类型来自定义样式。


#### Acknowledgement | 致谢

[Notation Must Die: The Battle For How We Read Music - YouTube](https://www.youtube.com/watch?v=Eq3bUFgEcb4&t=4012)   
[Jianpu Numbered Notation - MuseScore Plugin](https://musescore.org/en/project/jianpu-numbered-notation-0)   
[Element Analyser - MuseScore Plugin](https://musescore.org/en/project/element-analyser)

<img src="https://count.lnfinite.space/repo/musescore-integer-notation.svg?plus=1" width="0px"/>