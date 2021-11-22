
# ffprobe使用详解

2014年05月31日 22:26:06[北雨南萍](https://me.csdn.net/fireroll)阅读数：3604

 目录
1. 语法
2. 描述
3. 选项
3.1 流指示符
3.2 通用选项
3.3 音视频选项
3.4 主选项
4. 写入器
4.1 默认值
4.2 compact, csv
4.3 flat
4.4 ini
4.5 json
4.6 xml
5. Timecode

1. 语法
  ffprobe [options] [‘input_file’]

2. 描述
ffprobe收集多媒体文件或流的信息，并以人和机器可读的方式输出。
例如，它可以用来检查多媒体流的容器格式，以用每个流的类型和格式；
如果指定的以文件作为输入，ffprobe会打开文件并解析文件内容，如果文件打开失败或文件不是媒体文件，则返回负值。

ffprobe可以作为一个命令行程序独立使用，也可以于一个文本过滤器组合使用，从而实现更复杂的处理，
如统计处理或绘图。
选项用来列出ffprobe支持的格式，指定要显示的信息，和设置如何显示。

ffprobe的输出设计成可以方便地被文本过滤器解析，由一个或多个章节组成，由“print_format"选项指定。
章节是递归的，都有一个唯一的标识名。

容器或流中的Metadata标签识别成"FORMAT","STREAM"或"PROGRAM_STREAM"章节

3. 选项
如果没有特别的声明，所有的数字选项都可带一个表示数字的字符串，如'K','M','G'.

3.1 流指示符
很多选项可应用于每个流，如码率或codec.
流指示符用于明确指示给定的选项属于哪个流。

流指示符是跟在选项名后的字符串，由冒号分隔。
例如:
   -codec:a:1 ac3
它包含了 a:1 这个流指示符，用于匹配第二个音频流，因此，整个意思是选择AC3 codec来处理第二个音频流。

一个流指示符可以匹配多个流，因此选项也可以同时作用于它们。
例如，
   -b:a 128k     匹配所有的音频流；

空流指示符匹配所有流。
例如：
   -codec copy 或 -codec:copy  指示所有的流都不进行再编码；

流指示符的可能形式:
‘stream_index’ 使用索引号来匹配流；
例如：
   -threads:1 4
将设置第二个流的线程数为4；
​
‘stream_type[:stream_index]’
stream_type可以是下列之一:
'v'  为视频;
'a'  为音频；
's'  为子目录；
'd'  为数据；
't'  为附录。
如果指定了stream_index,那么这些类型只能stream_index指定的流有效，否则，对所有的流起作用；

‘p:program_id[:stream_index]’
如果指定了stream_index, 那么它只匹配id号为program_id的由stream_index指定的流，否则，匹配节目中的所有流。

‘#stream_id or i:stream_id’
匹配stream_id指定的流（如， MPEG-TS容器中的PID）

3.2 通用选项
这些选项可用于所有ff* 工具。
-L : Show license.
-h, -?, -help, --help [arg]
       显示帮助.
       arg 的值可以是：

         ‘long’ ， Print advanced tool options in addition to the basic tool options.

         ‘full’ ， Print complete list of options, including shared and private options for encoders,

                     decoders, demuxers, muxers, filters, etc.
decoder=decoder_name
       Print detailed information about the decoder named decoder_name.
       Use the ‘-decoders’ option to get a list of all decoders.
encoder=encoder_name
       Print detailed information about the encoder named encoder_name.
       Use the ‘-encoders’ option to get a list of all encoders.
demuxer=demuxer_name
       Print detailed information about the demuxer named demuxer_name.
       Use the ‘-formats’ option to get a list of all demuxers and muxers.
muxer=muxer_name
       Print detailed information about the muxer named muxer_name.
       Use the ‘-formats’ option to get a list of all muxers and demuxers.
filter=filter_name
       Print detailed information about the filter name filter_name.
       Use the ‘-filters’ option to get a list of all filters.
-version ：Show version.
-formats ：Show available formats.
-codecs  ：Show all codecs known to libavcodec.

       Note that the term ’codec’ is used throughout this documentation as a shortcut

       for what is more correctly called a media bitstream format.
-decoders：Show available decoders.
-encoders：Show all available encoders.
-bsfs    ：显示有效的流过滤器
-protocols：Show available protocols.
-filters ：Show available libavfilter filters.
-pix_fmts：Show available pixel formats.
-sample_fmts：Show available sample formats.
-layouts：显示通道名和标准的通道布局
-colors ：Show recognized color names.
-loglevel [repeat+]loglevel | -v [repeat+]loglevel
       设置库中的日志级别。
       "repeat+"表示不将重复的日志输出都放在第一行，并去掉”Last message repeated n times"行。
       如果“repeat”单独使用并没有更高的loglevel设置，则使用默认的级别；
       如果指定了多个loglevel的参数，使用'repeat'将不会改变loglevel。
       loglevel是一个数字或字符串，可以使用的值如下:
        ‘quiet’  Show nothing at all; be silent.
        ‘panic’  Only show fatal errors which could lead the process to crash,

                   such as and assert failure. This is not currently used for anything.

        ‘fatal’  Only show fatal errors. These are errors after which the process absolutely cannot continue after.

        ‘error’  Show all errors, including ones which can be recovered from.
        ‘warning’Show all warnings and errors.

                   Any message related to possibly incorrect or unexpected events will be shown.

        ‘info’   Show informative messages during processing. This is in addition to warnings and errors.

                   This is the default value.
        ‘verbose’Same as info, except more verbose.
        ‘debug’  Show everything, including debugging information.

默认的程序日志是输出到stderr, 如果终端支持颜色，则error和warning会标识成不同的颜色。

-report ：导出所有命令行和控制台的输出到文件，文件位于当前路径，命名为program-YYYYMMDD-HHMMSS.log.
          这个文件可以用作bug报告，也样也使用-loglevel选项设置。
          设置环境变量FFREPORT成任意值有同样的效果。

Setting the environment variable FFREPORT to any value has the same effect.

If the value is a ’:’-separated key=value sequence, these options will affect the report;

options values must be escaped if they contain special characters or the options delimiter ’:’

(see the “Quoting and escaping” section in the ffmpeg-utils manual). The following option is recognized:

file    ：set the file name to use for the report;
          %p is expanded to the name of the program,
          %t is expanded to a timestamp, %% is expanded to a plain %

          Errors in parsing the environment variable are not fatal, and will not appear in the report.

-hide_banner ：关闭版本声明输出.

          All FFmpeg tools will normally show a copyright notice, build options and library versions.

          This option can be used to suppress printing this information.

-cpuflags flags (global)

          Allows setting and clearing cpu flags. This option is intended for testing.

          Do not use it unless you know what you’re doing.
          ffmpeg -cpuflags -sse+mmx ...
          ffmpeg -cpuflags mmx ...
          ffmpeg -cpuflags 0 ...
          Possible flags for this option are:
          ‘x86’
          ‘mmx’
          ‘mmxext’
          ‘sse’
          ‘sse2’
          ‘sse2slow’
          ‘sse3’
          ‘sse3slow’
          ‘ssse3’
          ‘atom’
          ‘sse4.1’
          ‘sse4.2’
          ‘avx’
          ‘xop’
          ‘fma4’
          ‘3dnow’
          ‘3dnowext’
          ‘cmov’
          ‘ARM’
          ‘armv5te’
          ‘armv6’
          ‘armv6t2’
          ‘vfp’
          ‘vfpv3’
          ‘neon’
          ‘PowerPC’
          ‘altivec’
          ‘Specific Processors’
          ‘pentium2’
          ‘pentium3’
          ‘pentium4’
          ‘k6’
          ‘k62’
          ‘athlon’
          ‘athlonxp’
          ‘k8’
-opencl_bench： 基准测试所有openCL设备并显示结果.

          This option is only available when FFmpeg has been compiled with --enable-opencl.

-opencl_options options (global)：

          Set OpenCL environment options. This option is only available when FFmpeg has been compiled with --enable-opencl.

          options must be a list of key=value option pairs separated by ’:’.

          See the “OpenCL Options” section in the ffmpeg-utils manual for the list of supported options.

3.3 音视频选项
这些选项直接由libavformat, libavdevice和libavcodec库提供，它们可以分成两类:
generic : 这些选项可以用于设置所有容器，codec或设备。
          一般的选项都列在AVFormatContext容器/设备之下，并根据AVCodecContext中选择编解码器。
private : 这些选项用于设置指定的容器，设备和codec. 私有选项都列在它们对应的容器/设备/codec下。

例如：
写一个ID3v2.3头来代替默认的ID3v2.4头到一个MP3文件，使用MP3混合器的"id3v2_version"私有选项:
    ffmpeg -i input.flac -id3v2_version 3 out.mp3

所有AVOption选项可作用于每个流，因此使用流指示符来指示作用于特定流。

Note: the ‘-nooption’ syntax cannot be used for boolean AVOptions, use ‘-option 0’/‘-option 1’.

Note: the old undocumented way of specifying per-stream AVOptions by prepending v/a/s to the options name is now obsolete and will be removed soon.

3.4 主选项
-f format ：Force format to use.
-unit     ：Show the unit of the displayed values.
-prefix   ：Use SI prefixes for the displayed values.

            Unless the "-byte_binary_prefix" option is used all the prefixes are decimal.

-byte_binary_prefix
          ：Force the use of binary prefixes for byte values.
-sexagesimal
          ：Use sexagesimal format HH:MM:SS.MICROSECONDS for time values.
-pretty：Prettify the format of the displayed values,

             it corresponds to the options "-unit -prefix -byte_binary_prefix -sexagesimal".

-of, -print_format writer_name[=writer_options]
          ：设置输出打印格式
            writer_name 指定写入器的名字，
            writer_options指定传输给写入器的选项
           For example for printing the output in JSON format, specify:
            -print_format json

           For more details on the available output printing formats, see the Writers section below.

-sections：Print sections structure and section information, and exit. The output is not meant to be parsed by a machine.

-select_streams stream_specifier：
           选择邮stream_sepcifier指定的流

           This option affects only the options related to streams (e.g. show_streams, show_packets, etc.).

           For example to show only audio streams, you can use the command:
              ffprobe -show_streams -select_streams a INPUT

           To show only video packets belonging to the video stream with index 1:

              ffprobe -show_packets -select_streams v:1 INPUT
-show_data： 显示负载数据， as a hexadecimal and ASCII dump.
             Coupled with ‘-show_packets’, it will dump the packets’ data.
             Coupled with ‘-show_streams’, it will dump the codec extradata.
             The dump is printed as the "data" field. It may contain newlines.
show_error：显示出错信息

            The error information is printed within a section with name "ERROR".

-show_format：显示容器格式信息

            All the container format information is printed within a section with name "FORMAT".

-show_format_entry name

            Like ‘-show_format’, but only prints the specified entry of the container format information,

            rather than all. This option  may be given more than once, then all specified entries will be shown.

            This option is deprecated, use show_entries instead.
-show_entries section_entries：Set list of entries to show.
            Entries are specified according to the following syntax.
            section_entries contains a list of section entries separated by :.

            Each section entry is composed by a section name (or unique name),

            optionally followed by a list of entries local to that section, separated by ,.

If section name is specified but is followed by no =, all entries are printed to output,

together with all the contained sections. Otherwise only the entries specified in the local section entries list are printed. In particular, if = is specified but the list of local entries is empty, then no entries will be shown for that section.

Note that the order of specification of the local section entries is not honored in the output,

and the usual display order will be retained.
The formal syntax is given by:
LOCAL_SECTION_ENTRIES ::= SECTION_ENTRY_NAME[,LOCAL_SECTION_ENTRIES]
SECTION_ENTRY         ::= SECTION_NAME[=[LOCAL_SECTION_ENTRIES]]
SECTION_ENTRIES       ::= SECTION_ENTRY[:SECTION_ENTRIES]

For example, to show only the index and type of each stream, and the PTS time, duration time, and stream index of the packets,

you can specify the argument:
  packet=pts_time,duration_time,stream_index : stream=index,codec_type

To show all the entries in the section "format", but only the codec type in the section "stream", specify the argument:

  format : stream=codec_type
To show all the tags in the stream and format sections:
  format_tags : format_tags
To show only the title tag (if available) in the stream sections:
  stream_tags=title

-show_packets：显示每个包信息

        The information for each single packet is printed within a dedicated section with name "PACKET".

-show_frames ：Show information about each frame and subtitle contained in the input multimedia stream.

        The information for each single frame is printed within a dedicated section with name "FRAME" or "SUBTITLE".

-show_streams：Show information about each media stream contained in the input multimedia stream.

       Each media stream information is printed within a dedicated section with name "STREAM".

-show_programs：

       Show information about programs and their streams contained in the input multimedia stream.

       Each media stream information is printed within a dedicated section with name "PROGRAM_STREAM".

-show_chapters
       Show information about chapters stored in the format.
       Each chapter is printed within a dedicated section with name "CHAPTER".
-count_frames

       Count the number of frames per stream and report it in the corresponding stream section.

-count_packets

       Count the number of packets per stream and report it in the corresponding stream section.

-read_intervals read_intervals
       Read only the specified intervals.

       read_intervals must be a sequence of interval specifications separated by ",".

       ffprobe will seek to the interval starting point, and will continue reading from that.

       Each interval is specified by two optional parts, separated by "%".

The first part specifies the interval start position. It is interpreted as an abolute position,

or as a relative offset from the current position if it is preceded by the "+" character.

If this first part is not specified, no seeking will be performed when reading this interval.

The second part specifies the interval end position. It is interpreted as an absolute position,

or as a relative offset from the current position if it is preceded by the "+" character.

If the offset specification starts with "#", it is interpreted as the number of packets to read

(not including the flushing packets) from the interval start. If no second part is specified,

the program will read until the end of the input.

Note that seeking is not accurate, thus the actual interval start point may be different from the specified position.

Also, when an interval duration is specified, the absolute end time will be computed by adding

the duration to the interval start point found by seeking the file, rather than to the specified start value.

The formal syntax is given by:
INTERVAL  ::= [START|+START_OFFSET][%[END|+END_OFFSET]]
INTERVALS ::= INTERVAL[,INTERVALS]
A few examples follow.
Seek to time 10, read packets until 20 seconds after the found seek point,

then seek to position 01:30 (1 minute and thirty seconds) and read packets until position 01:45.

    10%+20,01:30%01:45
Read only 42 packets after seeking to position 01:23:
    01:23%+#42
Read only the first 20 seconds from the start:
    %+20
Read from the start until position 02:30:
    %02:30

-show_private_data, -private

   Show private data, that is data depending on the format of the particular shown element.

   This option is enabled by default, but you may need to disable it for specific uses,

   for example when creating XSD-compliant XML output.
-show_program_version
   Show information related to program version.
   Version information is printed within a section with name "PROGRAM_VERSION".
-show_library_versions
   Show information related to library versions.

   Version information for each library is printed within a section with name "LIBRARY_VERSION".

-show_versions
   Show information related to program and library versions.

   This is the equivalent of setting both ‘-show_program_version’ and ‘-show_library_versions’ options.

-bitexact

   Force bitexact output, useful to produce output which is not dependent on the specific build.

-i input_file
   读取input_file.

4. 写入器
写入器定义了ffprobe的输出格式，将用于打印所有输出
A writer may accept one or more arguments, which specify the options to adopt.
The options are specified as a list of key=value pairs, separated by ":".
All writers support the following options:
‘string_validation, sv’ Set string validation mode.
The following values are accepted.
‘fail’

   The writer will fail immediately in case an invalid string (UTF-8) sequence or code point is found in the input.

   This is especially useful to validate input metadata.

‘ignore’

   Any validation error will be ignored. This will result in possibly broken output, especially with the json or xml writer.

‘replace’

   The writer will substitute invalid UTF-8 sequences or code points with the string specified with the

‘string_validation_replacement’.
   Default value is ‘replace’.
‘string_validation_replacement, svr’

   Set replacement string to use in case ‘string_validation’ is set to ‘replace’.

In case the option is not specified, the writer will assume the empty string, that is it will remove the

invalid sequences from the input strings.
A description of the currently available writers follows.

4.1 默认值
默认格式
Print each section in the form:
   [SECTION]
   key1=val1
   ...
   keyN=valN
   [/SECTION]

Metadata tags are printed as a line in the corresponding FORMAT, STREAM or PROGRAM_STREAM section,

and are prefixed by the string "TAG:".

A description of the accepted options follows.
‘nokey, nk’
   If set to 1 specify not to print the key of each field. Default value is 0.

‘noprint_wrappers, nw’

   If set to 1 specify not to print the section header and footer. Default value is 0.

4.2 compact, csv
Compact and CSV format.
The csv writer is equivalent to compact, but supports different defaults.

Each section is printed on a single line. If no option is specifid, the output has the form:

   section|key1=val1| ... |keyN=valN
Metadata tags are printed in the corresponding "format" or "stream" section.
A metadata tag key, if printed, is prefixed by the string "tag:".

The description of the accepted options follows.

‘item_sep, s’

Specify the character to use for separating fields in the output line. It must be a single printable character, it is "|" by

default ("," for the csv writer).

‘nokey, nk’

If set to 1 specify not to print the key of each field. Its default value is 0 (1 for the csv writer).

‘escape, e’
Set the escape mode to use, default to "c" ("csv" for the csv writer).

It can assume one of the following values:

‘c’

Perform C-like escaping. Strings containing a newline (’\n’), carriage return (’’), a tab (’\t’), a form feed (’\f’),

the escaping character (’\’) or the item separator character SEP are escaped using C-like fashioned escaping, so that a

newline is converted to the sequence "\n", a carriage return to "", ’\’ to "\\" and the separator SEP is converted to

"\SEP".
‘csv’

Perform CSV-like escaping, as described in RFC4180. Strings containing a newline (’\n’), a carriage return (’’), a double

quote (’"’), or SEP are enclosed in double-quotes.
‘none’
Perform no escaping.
‘print_section, p’

Print the section name at the begin of each line if the value is 1, disable it with value set to 0. Default value is 1.

4.3 flat
Flat format.

A free-form output where each line contains an explicit key=value, such as "streams.stream.3.tags.foo=bar". The output is shell

escaped, so it can be directly embedded in sh scripts as long as the separator character is an alphanumeric character or an

underscore (see sep_char option).
The description of the accepted options follows.
‘sep_char, s’

Separator character used to separate the chapter, the section name, IDs and potential tags in the printed field key.

Default value is ’.’.
‘hierarchical, h’

Specify if the section name specification should be hierarchical. If set to 1, and if there is more than one section in the

current chapter, the section name will be prefixed by the name of the chapter. A value of 0 will disable this behavior.

Default value is 1.

​4.4 ini
INI format output.
Print output in an INI based format.
The following conventions are adopted:
all key and values are UTF-8
’.’ is the subgroup separator
newline, ’\t’, ’\f’, ’\b’ and the following characters are escaped
’\’ is the escape character
’#’ is the comment indicator
’=’ is the key/value separator
’:’ is not used but usually parsed as key/value separator
This writer accepts options as a list of key=value pairs, separated by ":".
The description of the accepted options follows.
‘hierarchical, h’

Specify if the section name specification should be hierarchical. If set to 1, and if there is more than one section in the

current chapter, the section name will be prefixed by the name of the chapter. A value of 0 will disable this behavior.

Default value is 1.

4.5 json
JSON based format.
Each section is printed using JSON notation.
The description of the accepted options follows.
‘compact, c’

If set to 1 enable compact output, that is each section will be printed on a single line. Default value is 0.

For more information about JSON, see http://www.json.org/.
​
4.6 xml
XML based format.

The XML output is described in the XML schema description file ‘ffprobe.xsd’ installed in the FFmpeg datadir.

An updated version of the schema can be retrieved at the url http://www.ffmpeg.org/schema/ffprobe.xsd, which redirects to the

latest schema committed into the FFmpeg development source code tree.

Note that the output issued will be compliant to the ‘ffprobe.xsd’ schema only when no special global output options (‘unit

’, ‘prefix’, ‘byte_binary_prefix’, ‘sexagesimal’ etc.) are specified.
The description of the accepted options follows.
‘fully_qualified, q’

If set to 1 specify if the output should be fully qualified. Default value is 0. This is required for generating an XML file

which can be validated through an XSD file.
‘xsd_compliant, x’

If set to 1 perform more checks for ensuring that the output is XSD compliant. Default value is 0. This option automatically

sets ‘fully_qualified’ to 1.
For more information about the XML format, see http://www.w3.org/XML/.

5. 时间戳
ffprobe supports Timecode extraction:

MPEG1/2 timecode is extracted from the GOP, and is available in the video stream details

(‘-show_streams’, see timecode).MOV timecode is extracted from tmcd track,

so is available in the tmcd stream metadata (‘-show_streams’, see TAG:timecode).

DV, GXF and AVI timecodes are available in format metadata (‘-show_format’, see TAG:timecode).