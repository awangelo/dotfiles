//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
	{"", "free -h | awk '/^Mem/ { print $3\"/\"$2 }' | sed s/i//g",	2,		0},

	{"", "top -bn1 | grep 'Cpu(s)' | awk '{ print $2 + $4 \"%\"}'",	2,		0},

	{"", "B=$(cat /sys/class/power_supply/BAT0/capacity); \
	  if [ \"$B\" -le 25 ]; then C='!! '; \
	  elif [ \"$B\" -le 35 ]; then C='! '; \
	  else C=''; fi; echo -e \"${C}${B}%\"",		60,		0},

	{"", "date '+%Y/%m/%d %H:%M'",					2,		0},
};

//sets delimiter between status commands. NULL character ('\0') means no delimiter.
static char delim[] = " | ";
static unsigned int delimLen = 5;
