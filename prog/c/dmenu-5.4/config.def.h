/* See LICENSE file for copyright and license details. */
/* Default settings; can be overriden by command line. */

static int topbar = 1;                        /* -b  option; if 0, dmenu appears at bottom     */
static int centered = 1;                      /* -c option; centers dmenu on screen */
static int min_width = 350;                   /* minimum width when centered */
static int max_width = 800;                   /* maximum width when centered */
static const float menu_height_ratio = 2.0f;  /* This is the ratio used in the original calculation */
/* -fn option overrides fonts[0]; default X11 font or font set */
static const char *fonts[] = {
	"Monaco Nerd Font Mono:size=12"
};
static const char *prompt      = NULL;      /* -p  option; prompt to the left of input field */
static const char *colors[SchemeLast][2] = {
	/*     fg         bg       */
	[SchemeNorm] = { "#bbbbbb", "#222222" },
	[SchemeSel] = { "#eeeeee", "#005577" },
	[SchemeOut] = { "#000000", "#00ffff" },
};
/* -l option; if nonzero, dmenu uses vertical list with given number of lines */
static unsigned int lines      = 8;

/*
 * Characters not considered part of a word while deleting words
 * for example: " /?\"&[]"
*/
static const char worddelimiters[] = " ";

/* Size of the window border */
static unsigned int border_width = 2;
