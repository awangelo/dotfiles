/* See LICENSE file for copyright and license details. */
/* Default settings; can be overriden by command line. */

static int topbar    = 1;                     /* -b  option; if 0, dmenu appears at bottom     */
static int centered  = 1;                     /* -c option; centers dmenu on screen */
static int min_width = 350;                   /* minimum width when centered */
static int max_width = 500;                   /* maximum width when centered */
static const float menu_height_ratio = 2.0f;  /* This is the ratio used in the original calculation */
/* -fn option overrides fonts[0]; default X11 font or font set */
static char font[] = "Go Mono:size=12";
static const char *fonts[] = {
    font,
    "monospace:size=10",
};
static char *prompt       = NULL;      /* -p  option; prompt to the left of input field */
static char normfgcolor[] = "#bbbbbb";
static char normbgcolor[] = "#0b0605";
static char selfgcolor[]  = "#eeeeee";
static char selbgcolor[]  = "#770b00";
static char *colors[SchemeLast][2] = {
	/*     fg         bg       */
	[SchemeNorm] = { normfgcolor, normbgcolor },
	[SchemeSel] = { selfgcolor, selbgcolor },
	[SchemeOut] = { "#000000", "#ff0000" },
};
/* -l and -g options; controls number of lines and columns in grid if > 0 */
static unsigned int lines      = 8;
static unsigned int columns    = 1;

/*
 * Characters not considered part of a word while deleting words
 * for example: " /?\"&[]"
 */
static const char worddelimiters[] = " ";

/* Size of the window border */
static unsigned int border_width = 2;

/*
 * Xresources preferences to load at startup
 */
ResourcePref resources[] = {
	{ "font",        STRING, &font },
	{ "normfgcolor", STRING, &normfgcolor },
	{ "normbgcolor", STRING, &normbgcolor },
	{ "selfgcolor",  STRING, &selfgcolor },
	{ "selbgcolor",  STRING, &selbgcolor },
	{ "prompt",      STRING, &prompt },
};
