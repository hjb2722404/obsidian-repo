MySQL 事件EVENT - rorshach - 博客园

#  MySQL 事件EVENT

**一.用途**
用于某一时间执行一个事件或周期性执行一个事件.
**二.语法**
CREATE
[DEFINER = { user | CURRENT_USER }]
EVENT
[IF NOT EXISTS]
event_name
ON SCHEDULE schedule
[ON COMPLETION [NOT] PRESERVE]
[ENABLE | DISABLE | DISABLE ON SLAVE]
[COMMENT 'comment']
DO event_body;
基本点:
schedule:
AT timestamp [+ INTERVAL interval] ...

| EVERY interval

[STARTS timestamp [+ INTERVAL interval] ...]
[ENDS timestamp [+ INTERVAL interval] ...]
interval:

quantity {YEAR | QUARTER | MONTH | DAY | HOUR | MINUTE |WEEK | SECOND | YEAR_MONTH | DAY_HOUR | DAY_MINUTE |DAY_SECOND | HOUR_MINUTE | HOUR_SECOND | MINUTE_SECOND}

a.event_name表示事件的名称

b.schedule表示触发点，【AT timestamp】一般用于只执行一次，一般使用时可以使用当前时间加上延后的一段时间，例如：AT CURRENT_TIMESTAMP + INTERVAL 1 HOUR。也可以定义一个时间常量，例如：AT '2006-02-10 23:59:00'；【EVERY interval】一般用于周期性执行，可以设定开始时间和结束时间。

c.ON COMPLETION [NOT] PRESERVE，默认是事件到期后会自动删除。如果想保留该事件使用ON COMPLETION PRESERVE；如果不想保留也可以设置ON COMPLETION [NOT] PRESERVE。

d.ENABLE | DISABLE表示设置启用或者禁止这个事件。
e.COMMENT 表示增加注释。
**三.EVENT开启**
msyql默认关闭了event.
show global variables like '%event%';
显示:
event_scheduler	OFF
开启:
set global event_scheduler=ON(或1);
查看进程:
show PROCESSLIST;
会看到一个用户为event_scheduler,执行状态为Waiting on empty queue的进程
**四.示例**
1.每秒向test2插入一条数据
DELIMITER //
CREATE EVENT test2_insert ON SCHEDULE EVERY 1 SECOND
DO
BEGIN
INSERT test2(uid) VALUES(10);
END;
//
2.每今日0点开始,每5分钟向test2插入一条数据
DELIMITER //
CREATE EVENT test2_insert_5_minute ON SCHEDULE EVERY 5 MINUTE STARTS CURDATE()
DO
BEGIN
INSERT test2(`time`) VALUES(NOW());
END;
//

对于手动更改日期,比如将当前事件18:08:05改为19:09:55,实际插入的记录会被延迟,本来应该在19:10:00插入的记录,可能会延后到19:10:50

**五.查看和删除事件**
show events;
show create EVENT test2_insert_5_minute;
drop event test2_insert_5_minute;
Measure
Measure