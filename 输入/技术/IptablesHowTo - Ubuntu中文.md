IptablesHowTo - Ubuntu中文

# IptablesHowTo

**Basic Iptables How to for Ubuntu Server Edition**
**Ubuntu 服务器版 Iptables 基本设置指南**

* * *

原文出处：https://wiki.ubuntu.com/IptablesHowTo
原文作者：UbuntuWiki

授权许可：[创作共用协议](http://creativecommons.org/licenses/by-sa/2.0/)  [GNU FDL](http://www.gnu.org/copyleft/fdl.html)

翻译人员：denven lxr1234
校对人员：5451vs5451
贡献者：
适用版本：
文章状态：翻译完成

* * *

THIS IS NOT COMPLETE AND SHOULD BE COMPLETED BY SOMEONE WHO KNOWS MORE THAN ME! THANKS！

**本文尚未完成，希望比我更懂Iptables的同行能加以补充完毕，谢谢！**

* * *

Iptables is a firewall, installed by default on the Ubuntu Server. On regullar ubuntu install, iptables is installed but allows all traffic (thus firewall is ineffective / inactive)

There is a wealth of information available about iptables, but much of it is fairly complex, and if you want to do a few basic things, this How To is for you.

iptables是一款防火墙软件。它在Ubuntu系统中是默认安装的。通常情况下，iptables随系统一起被安装，但没有对通信作任何限制，因此防火墙并没有真正建立起来。

尽管关于iptables的资料非常丰富，但大都比较复杂。如果您只想作些简单的设置，那么本文比较适合您的要求。

## 目录

 [[隐藏](http://wiki.ubuntu.com.cn/IptablesHowTo#)]

- [1  Basic Commands 基本命令](http://wiki.ubuntu.com.cn/IptablesHowTo#Basic_Commands_.E5.9F.BA.E6.9C.AC.E5.91.BD.E4.BB.A4)
- [2  Allowing Established Sessions 允许已建立的连接接收数据](http://wiki.ubuntu.com.cn/IptablesHowTo#Allowing_Established_Sessions_.E5.85.81.E8.AE.B8.E5.B7.B2.E5.BB.BA.E7.AB.8B.E7.9A.84.E8.BF.9E.E6.8E.A5.E6.8E.A5.E6.94.B6.E6.95.B0.E6.8D.AE)
- [3  Allowing Incoming Traffic on Specific Ports 开放指定的端口](http://wiki.ubuntu.com.cn/IptablesHowTo#Allowing_Incoming_Traffic_on_Specific_Ports_.E5.BC.80.E6.94.BE.E6.8C.87.E5.AE.9A.E7.9A.84.E7.AB.AF.E5.8F.A3)
- [4  Blocking Traffic 阻断通信](http://wiki.ubuntu.com.cn/IptablesHowTo#Blocking_Traffic_.E9.98.BB.E6.96.AD.E9.80.9A.E4.BF.A1)
- [5  Editing iptables 编辑iptables](http://wiki.ubuntu.com.cn/IptablesHowTo#Editing_iptables_.E7.BC.96.E8.BE.91iptables)
- [6  Logging 记录](http://wiki.ubuntu.com.cn/IptablesHowTo#Logging_.E8.AE.B0.E5.BD.95)
- [7  Saving iptables 保存设置](http://wiki.ubuntu.com.cn/IptablesHowTo#Saving_iptables_.E4.BF.9D.E5.AD.98.E8.AE.BE.E7.BD.AE)
- [8  Configuration on startup 开机自动加载配置](http://wiki.ubuntu.com.cn/IptablesHowTo#Configuration_on_startup_.E5.BC.80.E6.9C.BA.E8.87.AA.E5.8A.A8.E5.8A.A0.E8.BD.BD.E9.85.8D.E7.BD.AE)
- [9  Tips 技巧](http://wiki.ubuntu.com.cn/IptablesHowTo#Tips_.E6.8A.80.E5.B7.A7)
    - [9.1  If you manually edit iptables on a regular basis 如果你经常手动编辑iptables](http://wiki.ubuntu.com.cn/IptablesHowTo#If_you_manually_edit_iptables_on_a_regular_basis_.E5.A6.82.E6.9E.9C.E4.BD.A0.E7.BB.8F.E5.B8.B8.E6.89.8B.E5.8A.A8.E7.BC.96.E8.BE.91iptables)
    - [9.2  Using iptables-save/restore to test rules 使用iptables-save/restore测试规则](http://wiki.ubuntu.com.cn/IptablesHowTo#Using_iptables-save.2Frestore_to_test_rules_.E4.BD.BF.E7.94.A8iptables-save.2Frestore.E6.B5.8B.E8.AF.95.E8.A7.84.E5.88.99)
    - [9.3  More detailed Logging 关于日志记录的更多细节](http://wiki.ubuntu.com.cn/IptablesHowTo#More_detailed_Logging_.E5.85.B3.E4.BA.8E.E6.97.A5.E5.BF.97.E8.AE.B0.E5.BD.95.E7.9A.84.E6.9B.B4.E5.A4.9A.E7.BB.86.E8.8A.82)
    - [9.4  Disabling the firewall 禁用防火墙](http://wiki.ubuntu.com.cn/IptablesHowTo#Disabling_the_firewall_.E7.A6.81.E7.94.A8.E9.98.B2.E7.81.AB.E5.A2.99)
- [10  Easy configuration via GUI 通过GUI快速配置](http://wiki.ubuntu.com.cn/IptablesHowTo#Easy_configuration_via_GUI_.E9.80.9A.E8.BF.87GUI.E5.BF.AB.E9.80.9F.E9.85.8D.E7.BD.AE)
- [11  Further Information 更多技术细节](http://wiki.ubuntu.com.cn/IptablesHowTo#Further_Information_.E6.9B.B4.E5.A4.9A.E6.8A.80.E6.9C.AF.E7.BB.86.E8.8A.82)
- [12  Credits 贡献者](http://wiki.ubuntu.com.cn/IptablesHowTo#Credits_.E8.B4.A1.E7.8C.AE.E8.80.85)

### Basic Commands 基本命令

进入iptables

# sudo iptables -L

列出目前的ip策略. 如果您刚刚配置好服务器,您是没有设置ip规则的，您要自己设置。
Chain INPUT (policy ACCEPT)
target prot opt source destination
Chain FORWARD (policy ACCEPT)
target prot opt source destination
Chain OUTPUT (policy ACCEPT)
target prot opt source destination
使用命令

# sudo iptables -L

查看现有的iptables防火墙规则。如果您刚架设好服务器，那么规则表应该是空的，您将看到如下内容
Chain INPUT (policy ACCEPT)
target prot opt source destination
Chain FORWARD (policy ACCEPT)
target prot opt source destination
Chain OUTPUT (policy ACCEPT)
target prot opt source destination

### Allowing Established Sessions 允许已建立的连接接收数据

We can allow established sessions to receive traffic:
可以使用下面的命令，允许已建立的连接接收数据：

# iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

lll

### Allowing Incoming Traffic on Specific Ports 开放指定的端口

You could start by blocking traffic, but you might be working over SSH, where you would need to allow SSH before blocking everything else.

To allow incoming traffic on port 22 (traditionally used by SSH), you could tell iptables to allow all TCP traffic on port 22 of your network adapter.

刚开始时您不妨阻断所有通信，但考虑到您将来可能要使用SSH，那么您要让iptables在使用默认规则丢弃报文之前，允许SSH报文通过。
要开放端口22（SSH的默认端口），您要告诉iptables允许接受到的所有目标端口为22的TCP报文通过。

# iptables -A INPUT -p tcp -i eth0 --dport ssh -j ACCEPT

Specifically, this appends (-A) to the table INPUT the rule that any traffic to the interface (-i) eth0 on the destination port for ssh that iptables should jump (-j), or perform the action, ACCEPT.

执行上面的命令，一条规则会被追加到INPUT规则表的末尾（-A表示追加）。根据这条规则，对所有从接口eth0（-i指出对通过哪个接口的报文运用此规则）接收到的目标端口为22的报文，iptables要执行ACCEPT行动（-j指明当报文与规则相匹配时应采取的行动）。

Lets check the rules: (only the first few lines shown, you will see more)
我们来看看规则表中的情况：（这里只列出了开始的几行，您应该会看到更多内容）

# iptables -L

Chain INPUT (policy ACCEPT)
target prot opt source destination
ACCEPT all -- anywhere anywhere state RELATED,ESTABLISHED
ACCEPT tcp -- anywhere anywhere tcp dpt:ssh
Now, let's allow all web traffic
现在我们开放端口80：

# iptables -A INPUT -p tcp -i eth0 --dport 80 -j ACCEPT

Checking our rules, we have
此时的规则表中的内容如下：

# iptables -L

Chain INPUT (policy ACCEPT)
target prot opt source destination
ACCEPT all -- anywhere anywhere state RELATED,ESTABLISHED
ACCEPT tcp -- anywhere anywhere tcp dpt:ssh
ACCEPT tcp -- anywhere anywhere tcp dpt:www

We have specifically allowed tcp traffic to the ssh and web ports, but as we have not blocked anything, all traffic can still come in.

通过上述命令，我们已经代开了SSH和web服务的相应的端口，但由于没有阻断任何通信，因此所有的报文都能通过。

### Blocking Traffic 阻断通信

Once a decision is made about a packet, no more rules affect it. As our rules allowing ssh and web traffic come first, as long as our rule to block all traffic comes after them, we can still accept the traffic we want. All we need to do is put the rule to block all traffic at the end. The -A command tells iptables to append the rule at the end, so we'll use that again.

对每一个报文，iptables依次测试每一条规则，看报文与规则是否相匹配。一旦找到一条匹配的规则，就根据此规则中指定的行动，对报文进行处置，而对后面的规则不再进行测试。因此，如果我们在规则表的末尾添加一条规则，让iptables丢弃所有报文，但由于有了前面几条规则，ssh和web的正常通信不会受到影响。

sudo iptables -A INPUT -j DROP

# iptables -A INPUT -j DROP

# iptables -L

Chain INPUT (policy ACCEPT)
target prot opt source destination
ACCEPT all -- anywhere anywhere state RELATED,ESTABLISHED
ACCEPT tcp -- anywhere anywhere tcp dpt:ssh
ACCEPT tcp -- anywhere anywhere tcp dpt:www
DROP all -- anywhere anywhere

Because we didn't specify an interface or a protocol, any traffic for any port on any interface is blocked, except for web and ssh.

在上面的规则中，没有明确指出针对哪个接口或哪种协议使用此规则，所以从每个接口接收到的除ssh和web之外的所有报文都会被丢弃。

### Editing iptables 编辑iptables

The only problem with our setup so far is that even the loopback port is blocked. We could have written the drop rule for just eth0 by specifying -i eth0, but we could also add a rule for the loopback. If we append this rule, it will come too late - after all the traffic has been dropped. We need to insert this rule onto the fourth line.

进行至此，仍有一个问题，就是环回接口也被阻断了。刚才添加DROP规则的时候其实就可以使用-i eth0来解决这一问题。然而我们也可以为环回接口添加一条新规则来解决这个问题。但是不能将新规则追加到末尾，因为前一条规则已经把所有报文都丢弃了，而应该把它插到DROP规则前面，即规则表中第四行的位置。

# iptables -I INPUT 4 -i lo -j ACCEPT

# iptables -L

Chain INPUT (policy ACCEPT)
target prot opt source destination
ACCEPT all -- anywhere anywhere state RELATED,ESTABLISHED
ACCEPT tcp -- anywhere anywhere tcp dpt:ssh
ACCEPT tcp -- anywhere anywhere tcp dpt:www
ACCEPT all -- anywhere anywhere
DROP all -- anywhere anywhere

The last two lines look nearly the same, so we will list iptables in greater detail.

规则表中的最后两行几乎一样，为了看看它们到底有什么不同，我们可以使用

# iptables -L -v

### Logging 记录

In the above examples none of the traffic will be logged. If you would like to log dropped packets to syslog, this would be the quickest way:

在前面的例子中，没有任何报文会被记录到日志中。如果您希望将被丢弃的报文记录到syslog中，最简单的方法是：

# iptables -I INPUT 5 -m limit --limit 5/min -j LOG --log-prefix "iptables denied: " --log-level 7

See Tips section for more ideas on logging.
更多关于日志记录的信息，请参照Tips(技巧)这一节。

### Saving iptables 保存设置

If you were to reboot your machine right now, your iptables configuration would disapear. Rather than type this each time you reboot, however, you can save the configuration, and have it start up automatically. To save the configuration, you can use `iptables-save` and `iptables-restore`.

机器重启后，iptables中的配置信息会被清空。您可以将这些配置保存下来，让iptables在启动时自动加载，省得每次都得重新输入。`iptables-save`和`iptables-restore `是用来保存和恢复设置的。

### Configuration on startup 开机自动加载配置

Save your firewall rules to a file
先将防火墙规则保存到/etc/iptables.up.rules文件中

# iptables-save > /etc/iptables.up.rules

Then modify the */etc/network/interfaces* script to apply the rules automatically (the bottom line is added)

然后修改脚本/etc/network/interfaces，使系统能自动应用这些规则（最后一行是我们手工添加的）。
auto eth0
iface eth0 inet dhcp
pre-up iptables-restore < /etc/iptables.up.rules
You can also prepare a set of down rules and apply it automatically
当网络接口关闭后，您可以让iptables使用一套不同的规则集。
auto eth0
iface eth0 inet dhcp
pre-up iptables-restore < /etc/iptables.up.rules
post-down iptables-restore < /etc/iptables.down.rules

### Tips 技巧

#### If you manually edit iptables on a regular basis 如果你经常手动编辑iptables

The above steps go over how to setup your firewall rules and presume they will be relatively static (and for most people they should be). But if you do a lot of development work, you may want to have your iptables saved everytime you reboot. You could add a line like this one in `/etc/network/interfaces`:

大多数人并不需要经常改变他们的防火墙规则，因此只要根据前面的介绍，建立起防火墙规则就可以了。但是如果您要经常修改防火墙规则，以使其更加完善，那么您可能希望系统在每次重启前将防火墙的设置保存下来。为此您可以在/etc/network/interfaces文件中添加一行：

pre-up iptables-restore < /etc/iptables.up.rules
post-down iptables-save > /etc/iptables.up.rules

The line "post-down iptables-save > /etc/iptables.up.rules" will save the rules to be used on the next boot.

"post-down iptables-save > /etc/iptables.up.rules"会将设置保存下来，以便下次启动时使用。

#### Using iptables-save/restore to test rules 使用iptables-save/restore测试规则

If you edit your iptables beyond this tutorial, you may want to use the `iptables-save` and `iptables-restore` feature to edit and test your rules. To do this open the rules file in your favorite text editor (in this example gedit).

使用iptables-save和iptables-restore可以很方便地修改和测试防火墙规则。首先运行iptables-save将规则保存到一个文件，然后用编辑器编辑该文件。

# iptables-save > /etc/iptables.test.rules

# gedit /etc/iptables.test.rules

You will have a file that appears similiar to (following the example above):
如果您根据前面的例子建立了防火墙规则，iptables-save将产生一个类似于如下内容的文件：

# Generated by iptables-save v1.3.1 on Sun Apr 23 06:19:53 2006

*filter
:INPUT ACCEPT [368:102354]
:FORWARD ACCEPT [0:0]
:OUTPUT ACCEPT [92952:20764374]
-A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
-A INPUT -i eth0 -p tcp -m tcp --dport 22 -j ACCEPT
-A INPUT -i eth0 -p tcp -m tcp --dport 80 -j ACCEPT
-A INPUT -i lo -j ACCEPT

-A INPUT -m limit --limit 5/min -j LOG --log-prefix "iptables denied: " --log-level 7

-A INPUT -j DROP
COMMIT

# Completed on Sun Apr 23 06:19:53 2006

Notice that these are iptables commands minus the `iptable` command. Feel free to edit this to file and save when complete. Then to test simply:

文件内容其实就是各种iptables命令，只不过把命令名iptables省略了。您可以随意对这个文件进行编辑，然后保存。接着使用以下命令测试修改后的规则：

# iptables-restore < /etc/iptables.test.rules

After testing, if you have not added the `iptables-save` command above to your `/etc/network/interfaces` remember not to lose your changes:

之前您如果没有在`/etc/network/interfaces`文件中添加`iptables-save`命令，那么测试之后，别忘了把您所作的修改保存起来。

# iptables-save > /etc/iptables.up.rules

#### More detailed Logging 关于日志记录的更多细节

For further detail in your syslog you may want create an additional Chain. This will be a very brief example of my /etc/iptables.up.rules showing how I setup my iptables to log to syslog:

您可以创建额外的规则链，以便在syslog中作更加详细的记录。以下是我/etc/iptables.up.rules文件中的一个简单例子：

# Generated by iptables-save v1.3.1 on Sun Apr 23 05:32:09 2006

*filter
:INPUT ACCEPT [273:55355]
:FORWARD ACCEPT [0:0]
:LOGNDROP - [0:0]
:OUTPUT ACCEPT [92376:20668252]
-A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
-A INPUT -i eth0 -p tcp -m tcp --dport 22 -j ACCEPT
-A INPUT -i eth0 -p tcp -m tcp --dport 80 -j ACCEPT
-A INPUT -i lo -j ACCEPT
-A INPUT -j LOGNDROP

-A LOGNDROP -p tcp -m limit --limit 5/min -j LOG --log-prefix "Denied TCP: " --log-level 7

-A LOGNDROP -p udp -m limit --limit 5/min -j LOG --log-prefix "Denied UDP: " --log-level 7

-A LOGNDROP -p icmp -m limit --limit 5/min -j LOG --log-prefix "Denied ICMP: " --log-level 7

-A LOGNDROP -j DROP
COMMIT

# Completed on Sun Apr 23 05:32:09 2006

Note a new CHAIN called `LOGNDROP` at the top of the file. Also, the standard `DROP` at the bottom of the INPUT chain is replaceed with `LOGNDROP` and add protocol descriptions so it makes sense looking at the log. Lastly we drop the traffic at the end of the `LOGNDROP` chain. The following gives some idea of what is happening:

- `--limit` sets the number of times to log the same rule to syslog
- `--log-prefix "Denied..."` adds a prefix to make finding in the syslog easier
- `--log-level 7` sets the syslog level to informational (see man syslog for more detail, but you can probably leave this)

可以看到，文件前面多了一条名为`LOGNDROP`的规则链。此外，INPUT链最后一条规则中的`DROP`被`LONGDROP`替代。并且在后面我添加了一些内容来描述报文所使用的协议，这可以让记录更容易理解。最后，在`LOGNDROP`链的末尾，报文被丢弃。

- `--limit` 对由此规则引发的记录事件的频率进行限制。
- `--log-prefix "Denied..."` 在每条记录前加上一个前缀，以便查找。
- `--log-level 7` 将记录的详细程度设为“informational”等级（详情请见man syslog，您也可以直接使用此处的设置）。

#### Disabling the firewall 禁用防火墙

If you need to disable the firewall temporarily, you can flush all the rules using

可以通过清除所有规则来暂时停止防火墙： (警告：这只适合在没有配置防火墙的环境中，如果已经配置过默认规则为deny的环境，此步骤将使系统的所有网络访问中断)

# sudo iptables -F

### Easy configuration via GUI 通过GUI快速配置

A newbie can use Firestarter (a gui), available in repositories (Synaptic or apt-get) to configure her/his iptable rules, without needing the command line knowledge. Please see the tutorial though... Configuration is easy, but may not be enough for the advanced user. However, it should be enough for the most home users... The (read:my) suggested outbound configuration is "restrictive", with whitelisting each connection type whenever you need it (port 80 for http, 443 for secure http -https-, 1863 for msn chat etc) from the "policy" tab within firestarter. You can also use it to see active connections from and to your computer... The firewall stays up once it is configured using the wizard. Dialup users will have to specify it to start automatically on dial up in the wizard.

Firestarter是一款图形界面的防火墙工具，您可以从软件库中得到它。（用“新立得”或者apt-get安装）使用Firestarter并不需要掌握命令行方式下的配置方法。想了解它的用法，请阅读相应的教程…… Firestarter使用简单，虽然可能无法实现某些较为复杂的功能，但仍可满足大多数家庭使用的要求。对于从您的主机发送到网络的报文，firestarter推荐使用“restrictive”配置方案。这种方案要求您在清单中指明哪些报文是可以通过的，除此之外的所有报文都将被丢弃。您可以在firestarter的“policy”选项卡中改变配置方案。您也可以使用firestarer查看当前有哪些活动连接…… 当配置向导运行结束后，防火墙就建立起来了。拨号用户必须在配置向导中进行设定，以使防火墙在拨号后自动建立起来。

Homepage for firestarter: http://www.fs-security.com/ (again, available in repositories, no compiling required)

Tutorial: http://www.fs-security.com/docs/tutorial.php

Personal note: Unfortunately, it does not have the option to block (or ask the user about) connections of specific applications/programs... Thus, my understanding is that once you enable port 80 (i.e. for web access), any program that uses port 80 can connect to any server and do anything it pleases...

Firestarter主页：http://www.fs-security.com/ （再次声明，firestarter已经收入软件库，不需要您自己编译）
firestarer教程: http://www.fs-security.com/docs/tutorial.php

注意事项：这款软件不会阻止（或者询问用户是否阻止）特定的程序访问网络。因此，根据我的使用经验，一旦您开启端口80（web服务），任何程序都可以使用此端口进行通信。

### Further Information 更多技术细节

- [Iptables Tutorial](http://iptables-tutorial.frozentux.net/iptables-tutorial.html)
- [Iptables How To](http://www.netfilter.org/documentation/HOWTO/packet-filtering-HOWTO.html)
- [Netfilter and Iptables Multilingual Documentation](http://www.netfilter.org/documentation/)
- [Easy Firewall Generator for IPTables](http://easyfwgen.morizot.net/gen/)

### Credits 贡献者

Thanks to Rusty Russell and his How-To, as much of this is based off that.
感谢Rusty Russell和他写的How-To。

[分类](http://wiki.ubuntu.com.cn/%E7%89%B9%E6%AE%8A:%E9%A1%B5%E9%9D%A2%E5%88%86%E7%B1%BB)：

- [系统安全](http://wiki.ubuntu.com.cn/%E5%88%86%E7%B1%BB:%E7%B3%BB%E7%BB%9F%E5%AE%89%E5%85%A8)