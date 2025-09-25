//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
	{"  ", "free -h | awk '/^Mem/ { print $3\"/\"$2 }' | sed s/i//g",	2,		0},

	{"", "CPU_ICON=''; \
		F=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq); \
		if [ \"$F\" -le 3000000 ]; then PERF_ICON='󰌪 '; fi; \
		if [ \"$F\" -ge 4550000 ]; then PERF_ICON=''; fi; \
		USAGE=$(top -bn1 | grep 'Cpu(s)' | awk '{print $2+$4\"%\"}'); \
		echo -e \"$CPU_ICON $PERF_ICON $USAGE\"", 2, 0},

	{"", "B=$(cat /sys/class/power_supply/BAT0/capacity); \
		if [ \"$B\" -le 20 ]; then ICON='󰂃'; \
		elif [ \"$B\" -le 30 ]; then ICON='󰁺'; \
		elif [ \"$B\" -le 50 ]; then ICON='󰁼'; \
		elif [ \"$B\" -le 70 ]; then ICON='󰁾'; \
		elif [ \"$B\" -le 90 ]; then ICON='󰂀'; \
		else ICON='󰁹'; fi; \
		echo -e \"$ICON ${B}%\"", 60, 0},


	{"", "date '+%Y/%m/%d %H:%M'",					2,		0},
};

//sets delimiter between status commands. NULL character ('\0') means no delimiter.
static char delim[] = " | ";
static unsigned int delimLen = 5;
