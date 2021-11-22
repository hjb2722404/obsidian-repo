# FFprobe使用指南

2015年03月22日 11:20:11[小徐xfg](https://me.csdn.net/xfg0218)阅读数：893

-

#### 1. ffprobe 是什么 ？

简单的说，ffprobe 是一个多媒体流分析工具。它从多媒体流中收集信息，并且以人类和机器可读的形式打印出来。
它可以用来检测多媒体流的容器类型，以及每一个多媒体流的格式和类型。它可以作为一个独立的应用来使用，也可以结合文本过滤器执行更复杂的处理。

#### 2. ffprobe 的使用方式

命令行： ffprobe [选项] [‘输入文件’]

#### 3. ffprobe 可使用的选项

##### 3.1 流指示符

流指示符用来精确的指定一个给定的选项是属于哪个(些)流。

一个流指示符通常是一个字符串附加到一个选项名的后面，并且以“:”进行分割。例如：-codec:a:1 ac3 包含流指示符 a:1 ，它将匹配第二个音频流。因此，它将为第二个音频流指定 ac3 codec。

一个流指示符可以匹配多个流，这样，给定的选项会被应用到所有的匹配流上。例如：-b:a 128k 中的流指示符将匹配所有的音频流。
一个空流指示符将匹配所有的流。例如：-codec copy 或 -codec: copy 将拷贝所有的流，而不会对它们重新编码。
可能的流指示符的形式:

[view source](http://www.it165.net/os/html/201404/7862.html#viewSource)[print](http://www.it165.net/os/html/201404/7862.html#printSource)[?](http://www.it165.net/os/html/201404/7862.html#about)

`01.``‘stream_index’ 匹配具有该索引值的流。例如：-threads:``1``4`  `将为第二个流设置线程数为``4`	。

`02.`	‘stream_type[:stream_index]’

`03.`

		stream_type 是下面的其中之一：’v’ 视频, ’a’ 音频, ’s’ 字幕, ’d’ 数据,

`04.`

		’t’ 附件。如果给定 stream_index ，它将匹配该类型下的索引号为

`05.`

		stream_index 的流，否则，它将匹配该类型的所有流。

`06.`	‘p:program_id[:stream_index]’

`07.`

		如果给定 stream_index ，它将匹配 id 为 program_id 的 program 下的索

`08.`

		引号为 stream_index 的流，否则，它将匹配该 program 下的所有流。

`09.``‘#stream_id or i:stream_id’ 使用流 id 进行匹配(例如：MPEG-TS 容器中的 PID )`

##### 3.2 通用选项

ff* 工具的通用选项是共享的。(FFplay)

[view source](http://www.it165.net/os/html/201404/7862.html#viewSource)[print](http://www.it165.net/os/html/201404/7862.html#printSource)[?](http://www.it165.net/os/html/201404/7862.html#about)

`01.`	‘-L’ 显示 license

`02.`	‘-h, -?, -help, --help [arg]’ 打印帮助信息；可以指定一个参数 arg ，如果不指定，只打印基本选项

`03.`

		可选的 arg 选项：

`04.`

	`‘``long`	’ 除基本选项外，还将打印高级选项

`05.`

		‘full’ 打印一个完整的选项列表，包含 encoders, decoders, demuxers, muxers, filters 等的

`06.`

		共享以及私有选项

`07.`

		‘decoder=decoder_name’ 打印名称为 “decoder_name” 的解码器的详细信息

`08.`

		‘encoder=encoder_name’ 打印名称为 “encoder_name” 的编码器的详细信息

`09.`

		‘demuxer=demuxer_name’ 打印名称为 “demuxer_name” 的 demuxer 的详细信息

`10.`

		‘muxer=muxer_name’ 打印名称为 “muxer_name” 的 muxer 的详细信息

`11.`

		‘filter=filter_name’ 打印名称为 “filter_name” 的过滤器的详细信息

`12.`

`13.`	‘-version’ 显示版本信息

`14.`	‘-formats’ 显示有效的格式

`15.`	‘-codecs’ 显示 libavcodec 已知的所有编解码器

`16.`	‘-decoders’ 显示有效的解码器

`17.`	‘-encoders’ 显示有效的编码器

`18.`	‘-bsfs’ 显示有效的比特流过滤器

`19.`	‘-protocols’ 显示有效的协议

`20.`	‘-filters’ 显示 libavfilter 有效的过滤器

`21.`	‘-pix_fmts’ 显示有效的像素格式

`22.`	‘-sample_fmts’ 显示有效的采样格式

`23.`	‘-layouts’ 显示通道名称以及标准通道布局

`24.`	‘-colors’ 显示认可的颜色名称

`25.``‘-hide_banner’ 禁止打印欢迎语；也就是禁止默认会显示的版权信息、编译选项以及库版本信息等`

##### 3.3 一些主要选项

[view source](http://www.it165.net/os/html/201404/7862.html#viewSource)[print](http://www.it165.net/os/html/201404/7862.html#printSource)[?](http://www.it165.net/os/html/201404/7862.html#about)

`01.`	‘-f format’ 强制使用的格式

`02.`	‘-unit’ 显示值的单位

`03.`	‘-prefix’ 显示的值使用标准国际单位制词头

`04.`	‘-byte_binary_prefix’ 对字节值强制使用二进制前缀

`05.`	‘-sexagesimal’ 时间值使用六十进位的格式 HH:MM:SS.MICROSECONDS

`06.`	‘-pretty’ 美化显示值的格式。它相当于

	`"-unit -prefix -byte_binary_prefix -sexagesimal"`

`07.`	‘-of, -print_format writer_name[=writer_options]’

`08.`

		设置输出打印格式。writer_name 指定打印程序 (writer) 的名称，writer_options

`09.`

		指定传递给 writer 的选项。例如：将输出打印为 JSON 格式：-print_format json

`10.`	‘-select_streams stream_specifier’

`11.`

		只选择 stream_specifier 指定的流。该选项只影响那些与流相关的选项

`12.`

		(例如：show_streams, show_packets, 等)。

`13.`

		举例：只显示音频流，使用命令：

`14.`

		ffprobe -show_streams -select_streams a INPUT

`15.`	‘-show_data’ 显示有效载荷数据，以十六进制和ASCII转储。与 ‘-show_packets’ 结合使用，它将

`16.`

		dump 包数据；与 ‘-show_streams’ 结合使用，它将 dump codec 附加数据。

`17.`	‘-show_error’ 显示探测输入文件时的错误信息

`18.`	‘-show_format’ 显示输入多媒体流的容器格式信息

`19.`	‘-show_packets’ 显示输入多媒体流中每一个包的信息

`20.`	‘-show_frames’ 显示输入多媒体流中的每一帧以及字幕的信息

`21.`	‘-show_streams’ 显示输入多媒体流中每一个流的信息

`22.`	‘-show_programs’ 显示输入多媒体流中程序以及它们的流的信息

`23.`	‘-show_chapters’ 显示格式中存储的章节信息

`24.`	‘-count_frames’ 计算每一个流中的帧数，在相应的段中进行显示

`25.`	‘-count_packets’ 计算每一个流中的包数，在相应的段中进行显示

`26.`	‘-show_program_version’ 显示程序版本及配置相关信息

`27.`	‘-show_library_versions’ 显示库版本相关信息

`28.`	‘-show_versions’ 显示程序和库版本相关信息。相当于同时设置‘-show_program_version’ 和

`29.`

		‘-show_library_versions’

`30.``‘-i input_file’ 指定输入文件`

#### 4. 打印程序(Writers)

一个 writer 定义了 ffprobe 所使用的输出格式。
它可以接受一个或多个参数，这些参数以 key=value 的形式指定，以“:”分隔。所有的 writers 都支持以下选项:

[view source](http://www.it165.net/os/html/201404/7862.html#viewSource)[print](http://www.it165.net/os/html/201404/7862.html#printSource)[?](http://www.it165.net/os/html/201404/7862.html#about)

`1.`	‘string_validation, sv’ 设置字符串验证模式

`2.`

		它可以接受以下值：(默认为 replace)

`3.`

	`‘fail’ 当发现无效字符串(UTF-``8`	)序列或代码点时，立即失败。这个对于验证输入 metadata 非常有用。

`4.`

		‘ignore’ 任何验证错误都将被忽略。

`5.`

	`‘replace’ writer 将使用 ‘string_validation_replacement’ 所指定的字符串替代无效的UTF-``8`	序列或者代码点。

`6.`

`7.``‘string_validation_replacement, svr’ 设置替代字符串，当 ‘string_validation’ 设置为 ‘replace’ 时使用。`

以下为目前可以使用的 writers ：

[view source](http://www.it165.net/os/html/201404/7862.html#viewSource)[print](http://www.it165.net/os/html/201404/7862.html#printSource)[?](http://www.it165.net/os/html/201404/7862.html#about)

`01.``4.1``default`
`02.`

		默认格式。按照以下形式打印每个 section ：

`03.`

		[SECTION]

`04.`

		key1=val1

`05.`

	`... `

`06.`

		keyN=valN

`07.`

		[/SECTION]

`08.`

`09.``4.2``compact, csv `
`10.`

		紧凑与CSV格式。每个 section 打印在一个单独的行。如果不指定其他选项，其输入格式如下：

`11.`

		section|key1=val1| ... |keyN=valN

`12.`

`13.``4.3``Flat `
`14.`

		一种自由格式输出，每一行包含一个明确的 key=value 对。

`15.`

`16.``4.4``ini `
`17.`

		INI 格式输出。

`18.`

`19.``4.5``json `
`20.`

		JSON 格式输出。每一个 section 使用 JSON 符号来打印。

`21.`

`22.``4.6``xml `
`23.`

		XML 格式输出。

`24.`

`25.``各 writer 可接受的选项，请查阅 ffprobe 文档`

#### 5. ffprobe 使用示例

[view source](http://www.it165.net/os/html/201404/7862.html#viewSource)[print](http://www.it165.net/os/html/201404/7862.html#printSource)[?](http://www.it165.net/os/html/201404/7862.html#about)

`01.``1`	) 最简单的使用方式

`02.`

		ffprobe test.mp4

`03.`

`04.``2`	) 不显示欢迎信息

`05.`

		ffprobe -hide_banner test.mp4

`06.`

`07.``3`	) 以 JSON 格式显示每个流的信息

`08.`

		ffprobe -print_format json -show_streams test.mp4

`09.`

`10.``4`	) 显示容器格式相关信息

`11.`

	`ffprobe -show_format test.mp4`

更多 ffprobe 选项，可以使用 ffprobe -h 获取