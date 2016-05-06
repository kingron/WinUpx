目录

授权
程序简介和安装
程序更新记录、特性及功能
使用手册
附录

============================

授权
----------------------------
作者Kingron授予您对本程序[指Upx Shell For Windows]的最终用户使用许可权。你可以免费使用此程序，也可以免费分发此程序，同时保证分发此程序包的完整的文件。但未经作者书面许可，您不可将本程序用于任何商业性质目的，如捆绑，销售，集成等。你不能修改此程序包带的任何一个文件，您不得对本程序进行任何软件反向工程，如跟踪破解、反汇编、反编译等，不得修改本程序的任何标志，数据等。所有的文件列表包含在安装部分的说明中。作者不对使用本程序造成的任何损失承担任何责任。如果你使用本程序，即认为你同意本授权协议。


程序简介和安装
----------------------------

本程序是Upx的Windows外壳程序，Upx是用来压缩可执行文件的一个工具，版权属于其作者所有。本程序安装很简单，属于绿色软件，不留任何垃圾，可以任意拷贝和复制，只要保证所有文件的完整即可。作者对程序本身担保不包含任何恶意代码，但是本人不对使用本程序造成的任何硬件或者软件方面的损失担当任何责任。

系统需求

程序需要Windows95/98/Me,Windows NT/2000环境，最小需要2.6M空闲内存，800*600分辨率，16位以上色彩，300KB磁盘空间。基本上只要能够运行Windows就可以运行本程序。

本程序的文件列表：
readme.txt         本文件
WinUpx.exe         主程序
CN_GB.ini          界面语言文件--简体中文(至少要一个语言文件！)
English.ini        界面语言文件--英文(默认)
Config.ini         配置文件，可以删除。

程序更新记录、特性及功能
----------------------------
[2001-12-21]
修改了语言界面的核心代码

[2001-7-29]
修正了改变窗体大小的时候一个Label的显示问题。正式发布！

[2001-7-24]
添加了历史记录菜单的调整功能。
美化了菜单显示，使用文件的图标，这样简单直接！
添加了清除历史记录的功能
可以自定义历史记录的最多的个数。
历史记录菜单上面添加了一个附加的功能：按住Shift点击则运行这个文件。
整理了源代码，添加了注释，不过删除了原来的ImageList的部分的图像，这是为了减少Exe文件的体积。因为TImageList和TSpeedButton不能共享图形数据，Delphi会把相同的数据保存两次！

[2001-7-23]
支持文件拖放，支持批量文件的压缩。
增加了历史记录功能。

[2001-7-22]
拥有UpxWin的所有功能。
增加了文件信息的检测，可以检测是否用Aspack压缩或者用upx、PKLite For Dos压缩过，需要说明的是，因为不知道aspack的标识保存在什么地方，因此如果用aspack压缩的文件的段名不是.aspack时，将无法准确检测。
增加了界面语言选择。
上载到www.pchome.net的软件下载区。

[2001-7-21]
自己下载了UpxWin，但是不能在NT/2000里面运行，于是萌发了自己写一个Shell的念头，立即动手，写了最初的版本。程序可以在Win9x/Me/NT/2000里面运行。


使用手册
----------------------------
程序运行之后，默认的时[操作]页面，这个时候可以使用[打开]按钮打开一个文件，之后可以[压缩]/[解压]按钮来进行操作，如果操作成功完成，[测试]按钮将可以使用，如果选择了备份选项，[恢复]按钮也可以使用！你可以进行相关的操作！
选项页面，采用默认的即可，一般不要改动！如果你要保存这些选项，必须点击[保存默认值]按钮！

技巧：

1:压缩一个目录下的所有的可执行文件
用文件搜索功能搜索这个目录下面的所有的*.Exe;*.Dll;*.OCX;*.Scr.....等等需要压缩的文件，然后用鼠标拖放到程序的窗口即可！更简单的，把这个目录下面的所有的文件拖放到这个窗口即可，不过会浪费大量的时间来检测文件是否能够压缩。如果文件个数不多或者全部是可执行文件，可以采用这个策略。

2:随时随地弹出历史记录菜单
按下鼠标左键不放，右击可以弹出历史菜单，或者用Shift+右击也可以。

3:随时使用相关功能
绝大部分的功能都可以随时调用，只要右击窗体即可！

4:历史记录菜单的隐藏功能
单击历史记录的菜单项时，按住Shift可以调用相应的程序打开这个文件！

界面(略)

编  码：Kingron
E_Mail：Kingron@163.net
日  期：2001.7.21
最后更新日期：2001.7.24

_________________________________________________

版权所有，Kingron，2001
_________________________________________________

=================================================
附录：

Upx的软件授权协议

                     Ultimate Packer for eXecutables
            Copyright (C) 1996, 1997, 1998, 1999, 2000, 2001
UPX 1.08w        Markus F.X.J. Oberhumer & Laszlo Molnar        Apr 30th 2001

   This program may be used freely, and you are welcome to
   redistribute it under certain conditions.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   UPX License Agreement for more details.

   You should have received a copy of the UPX License Agreement
   along with this program; see the file LICENSE.
   If not, visit one of the following pages:

        http://upx.sourceforge.net
        http://www.oberhumer.com/upx/
        http://wildsau.idv.uni-linz.ac.at/mfx/upx.html

   Markus F.X.J. Oberhumer                   Laszlo Molnar
   markus@oberhumer.com                      ml1050@cdata.tvnet.hu