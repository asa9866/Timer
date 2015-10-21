# TimerClock 文件夹中的文件说明
1.timeClock.zip是文件夹timeClock压缩后文件，是timeClock模块儿上传文件。<br/>
2.timeClock文件夹中，module.json是模块而配置文件，target中放生成的目标库文件和第三方文件，res_是资源文件，不用管。<br/>
3.TimeClockDevPro是用于创建timeClock>target>libtimeClock.a的工程。<br/>
4.ModulesDevProject是上传apicloud之前的测试工程，里面有timeClock模块的源代码和module.json模块配置文件。直接修改supporting files>widget>index.html即可测试

# TimerClock 模块使用说明

模块名称：timeClock
调用方式<br/>
方法1<br/>
beginClock({ })<br/>
描述：开始定时<br/>
参数：json对象<br/>
delay：秒数 多少秒之后执行（int）（可选）<br/>
path：声音文件路径（string）（必选）<br/>
repeat：是否重复（bool）（可选 默认false）<br/>
方法2<br/>
cancelClock<br/>
描述：取消定时器<br/>
方法3<br/>
stop<br/>
停止播放
