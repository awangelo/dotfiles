/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 3;        /* border pixel of windows */
static const unsigned int gappx     = 15;       /* gaps between windows */
static const unsigned int snap      = 8;        /* snap pixel */
static const unsigned int systraypinning = 0;   /* 0: sloppy systray follows selected monitor, >0: pin systray to monitor X */
static const unsigned int systrayonleft  = 0;   /* 0: systray in the right corner, >0: systray on left of status text */
static const unsigned int systrayspacing = 3;   /* systray spacing */
static const int systraypinningfailfirst = 1;   /* 1: if pinning fails, display systray on the first monitor, False: display systray on the last monitor*/
static const int showsystray        = 1;        /* 0 means no systray */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const int user_bh            = 5;        /* 2 is the default spacing around the bar's font */
static const char *fonts[]          = { "UbuntuMono Nerd Font:size=14" };
static const char dmenufont[]       = "UbuntuMono Nerd Font:size=14";
static const char col_gray1[]       = "#0b0605";
static const char col_gray2[]       = "#444444";
static const char col_gray3[]       = "#bbbbbb";
static const char col_gray4[]       = "#eeeeee";
static const char col_accent[]      = "#770b00";
static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_gray3, col_gray1,  col_gray1  },
	[SchemeSel]  = { col_gray4, col_accent, col_accent },
};

/* tagging */
static const char *tags[] = { "☿", "⚳", "⚸", "⚵", "♃", "♄", "♅", "⚶", "⯓" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class           instance    title       tags mask     isfloating   monitor */
	{ "qutebrowser",   NULL,       NULL,       1 << 1,       0,           -1 },
	{ "brave-browser", NULL,       NULL,       1 << 2,       0,           -1 },
	{ "discord",       NULL,       NULL,       1 << 3,       0,           -1 },
};

/* layout(s) */
static const float mfact        = 0.50; /* factor of master area size [0.05..0.95] */
static const int nmaster        = 1;    /* number of clients in master area */
static const int resizehints    = 1;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */
static const int refreshrate    = 180;  /* refresh rate (per second) for client move/resize */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[]   = { "dmenu_run", "-c", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_accent, "-sf", col_gray4, NULL };
static const char *termcmd[]    = { "alacritty", NULL };
static const char *filescmd[]   = { "nemo", NULL };
static const char *zoomercmd[]  = { "zooc", NULL };
static const char *clipcmd[]    = { "clipmenu", NULL };
static const char *volupcmd[]   = { "wpctl", "set-volume", "@DEFAULT_SINK@", "2%+", NULL };
static const char *voldowncmd[] = { "wpctl", "set-volume", "@DEFAULT_SINK@", "2%-", NULL };
static const char *volmutecmd[] = { "wpctl", "set-mute",   "@DEFAULT_SINK@", "toggle", NULL };
static const char *brmcmd[]     = { "brightnessctl", "set", "5%-", NULL };
static const char *brpcmd[]     = { "brightnessctl", "set", "5%+", NULL };
static const char *dunicode[]   = { "/home/angelo/.config/unicode_dmenu.sh", NULL };

#include "movestack.c"
#include <X11/XF86keysym.h>

static const Key keys[] = {
	/* modifier                     key            function        argument */
	{ MODKEY,                       XK_d,          spawn,          {.v = dmenucmd } },
	{ MODKEY,                       XK_Return,     spawn,          {.v = termcmd } },
	{ MODKEY,                       XK_e,          spawn,          {.v = filescmd } },
	{ MODKEY,                       XK_z,          spawn,          {.v = zoomercmd } },
	{ MODKEY,                       XK_v,          spawn,          {.v = clipcmd } },
	{ MODKEY,                       XK_period,     spawn,          {.v = dunicode } },
	{ MODKEY,                       XK_s,          spawn,          SHCMD("maim | tee ~/Pictures/Screenshots/$(openssl rand -hex 9).png | xclip -selection clipboard -t image/png > /dev/null 2>&1") },
	{ MODKEY|ShiftMask,             XK_s,          spawn,          SHCMD("maim -u -s | tee ~/Pictures/Screenshots/$(openssl rand -hex 9).png | xclip -selection clipboard -t image/png > /dev/null 2>&1") },
	{ MODKEY,                       XK_b,          togglebar,      {0} },
	{ MODKEY,                       XK_j,          focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_k,          focusstack,     {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_j,          movestack,      {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_k,          movestack,      {.i = +1 } },
	{ MODKEY,                       XK_i,          incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_o,          incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,          setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,          setmfact,       {.f = +0.05} },
	{ MODKEY|ShiftMask,             XK_Return,     zoom,           {0} },
	{ MODKEY,                       XK_Tab,        view,           {0} },
	{ MODKEY,                       XK_q,          killclient,     {0} },
	{ MODKEY,                       XK_t,          setlayout,      {.v = &layouts[0]} },
	// { MODKEY,                       XK_f,          setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,          setlayout,      {.v = &layouts[2]} },
	// { MODKEY,                       XK_space,      setlayout,      {0} },
	{ MODKEY,                       XK_w,          togglefloating, {0} },
	{ MODKEY,                       XK_f,          togglefullscr,  {0} },
	{ MODKEY,                       XK_0,          view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,          tag,            {.ui = ~0 } },
	// { MODKEY,                       XK_comma,      focusmon,       {.i = -1 } },
	// { MODKEY,                       XK_period,     focusmon,       {.i = +1 } },
	// { MODKEY|ShiftMask,             XK_comma,      tagmon,         {.i = -1 } },
	// { MODKEY|ShiftMask,             XK_period,     tagmon,         {.i = +1 } },
	{ MODKEY,                       XK_minus,      setgaps,        {.i = -1 } },
	{ MODKEY,                       XK_equal,      setgaps,        {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_equal,      setgaps,        {.i = 0  } },
	TAGKEYS(                        XK_1,                          0)
	TAGKEYS(                        XK_2,                          1)
	TAGKEYS(                        XK_3,                          2)
	TAGKEYS(                        XK_4,                          3)
	TAGKEYS(                        XK_5,                          4)
	TAGKEYS(                        XK_6,                          5)
	TAGKEYS(                        XK_7,                          6)
	TAGKEYS(                        XK_8,                          7)
	TAGKEYS(                        XK_9,                          8)
	{ MODKEY|ShiftMask,             XK_BackSpace,  quit,           {0} },

	{ 0,                 XF86XK_AudioRaiseVolume,  spawn,          {.v = volupcmd} },
	{ 0,                 XF86XK_AudioLowerVolume,  spawn,          {.v = voldowncmd} },
	{ 0,                 XF86XK_AudioMute,         spawn,          {.v = volmutecmd} },
	{ 0,                 XF86XK_MonBrightnessDown, spawn,          {.v = brmcmd } },
	{ 0,                 XF86XK_MonBrightnessUp,   spawn,          {.v = brpcmd } },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};
