//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
	{"", "sh $HOME/.config/scripts/mem",	 	5,		0,},
	{"", "sh $HOME/.config/scripts/volume", 	1,		0,},
	{"", "sh $HOME/.config/scripts/battery",	5,		0,},
	{"", "sh $HOME/.config/scripts/timedate", 	1,		0,},
};

//sets delimiter between status commands. NULL character ('\0') means no delimiter.
static char delim[] = " | ";
static unsigned int delimLen = 5;
