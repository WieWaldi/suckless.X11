/* See LICENSE file for copyright and license details. */

/* include */
#include <X11/XF86keysym.h>
#include "fibonacci.c"
#include "movestack.c"

/* appearance */
static float mfact                          = 0.55;                 /* factor of master area size [0.05..0.95] */
static const char *fonts[]                  = { "FiraMono Nerd Font:size=11" };
static const char dmenufont[]               = "FiraMono Nerd Font:size=12";
static unsigned int borderpx                = 0;                    /* border pixel of windows */
static unsigned int gappx                   = 15;                   /* gaps between windows */
static unsigned int snap                    = 0;                    /* snap pixel */
static int resizehints                      = 1;                    /* 1 means respect size hints in tiled resizals */
static int nmaster                          = 1;                    /* number of clients in master area */
static int showbar                          = 1;                    /* 0 means no bar */
static int topbar                           = 1;                    /* 0 means bottom bar */
static int vertpad                          = 10;                   /* vertical padding of bar */
static int sidepad                          = 10;                   /* horizontal padding of bar */
static char normfgcolor[]                   = "#bbbbbb";
static char normbgcolor[]                   = "#222222";
static char normbordercolor[]               = "#444444";
static char selfgcolor[]                    = "#eeeeee";
static char selbgcolor[]                    = "#005577";
static char selbordercolor[]                = "#005577";
static char statusfgcolor[]                 = "#eeeeee";
static char statusbgcolor[]                 = "#5f005f";
static char tagselfgcolor[]                 = "#eeeeee";
static char tagselbgcolor[]                 = "#5f005f";
static char tagnormfgcolor[]                = "#af87d7";
static char tagnormbgcolor[]                = "#5f005f";
static char infoselfgcolor[]                = "#eeeeee";
static char infoselbgcolor[]                = "#5f005f";
static char infonormfgcolor[]               = "#eeeeee";
static char infonormbgcolor[]               = "#5f005f";

static char *colors[][3] = {
		/*                                      fg                  bg                  border   */
		[SchemeNorm]                        = { normfgcolor,        normbgcolor,        normbordercolor },
		[SchemeSel]                         = { selfgcolor,         selbgcolor,         selbordercolor  },
		[SchemeStatus]                      = { statusfgcolor,      statusbgcolor,      "#000000"  }, // Statusbar right {text,background,not used but cannot be empty}
		[SchemeTagsSel]                     = { tagselfgcolor,      tagselbgcolor,      "#000000"  }, // Tagbar left selected {text,background,not used but cannot be empty}
		[SchemeTagsNorm]                    = { tagnormfgcolor,     tagnormbgcolor,     "#000000"  }, // Tagbar left unselected {text,background,not used but cannot be empty}
		[SchemeInfoSel]                     = { infoselfgcolor,     infoselbgcolor,     "#000000"  }, // infobar middle  selected {text,background,not used but cannot be empty}
		[SchemeInfoNorm]                    = { infonormfgcolor,    infonormbgcolor,    "#000000"  }, // infobar middle  unselected {text,background,not used but cannot be empty}
};
/* Xresources preferences to load at startup */
ResourcePref resources[] = {
		{ "mfact",              FLOAT,   &mfact },
		{ "borderpx",           INTEGER, &borderpx },
		{ "gappx",              INTEGER, &gappx },
		{ "snap",               INTEGER, &snap },
		{ "resizehints",        INTEGER, &resizehints },
		{ "nmaster",            INTEGER, &nmaster },
		{ "showbar",            INTEGER, &showbar },
		{ "topbar",             INTEGER, &topbar },
		{ "vertpad",            INTEGER, &vertpad },
		{ "sidepad",            INTEGER, &sidepad },
		{ "normfgcolor",        STRING,  &normfgcolor },
		{ "normbgcolor",        STRING,  &normbgcolor },
		{ "normbordercolor",    STRING,  &normbordercolor },
		{ "selfgcolor",         STRING,  &selfgcolor },
		{ "selbgcolor",         STRING,  &selbgcolor },
		{ "selbordercolor",     STRING,  &selbordercolor },
		{ "statusfgcolor",      STRING,  &statusfgcolor },
		{ "statusbgcolor",      STRING,  &statusbgcolor },
		{ "tagselfgcolor",      STRING,  &tagselfgcolor },
		{ "tagselbgcolor",      STRING,  &tagselbgcolor },
		{ "tagnormfgcolor",     STRING,  &tagnormfgcolor },
		{ "tagnormbgcolor",     STRING,  &tagnormbgcolor },
		{ "infoselfgcolor",     STRING,  &infoselfgcolor },
		{ "infoselbgcolor",     STRING,  &infoselbgcolor },
		{ "infonormfgcolor",    STRING,  &infonormfgcolor },
		{ "infonormbgcolor",    STRING,  &infonormbgcolor },
};
/* tagging */
/* static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" }; */
/* static const char *tags[] = { "➊", "➋", "➌", "➍", "➎", "➏", "➐", "➑", "➒" }; */
/* static const char *tags[] = { "☹", "♨", "♺", "♿", "⚒", "⚓", "⚕", "⚗", "i⚛ }; */
/* static const char *tags[] = { "", "Finder", "File", "Edit", "View", "Settings", "Go", "Window", "Help"}; */
static const char *tags[] = { "", "", "", "", "", "", "", "", "" };


static const Rule rules[] = {
	/* class                instance                                title                           tags mask     iscentered    isfloating   monitor */
	{ "Citrix",             "citrix",                               "Citrix Workspace",             1 << 1,       1,            1,          -1 },
	{ "cool-retro-term",    "cool-retro-term",                      "Settings",                     0,            1,            1,          -1 },
	{ "cool-retro-term",    "cool-retro-term",                      "cool-retro-term",              0,            1,            1,          -1 },
	{ "cool-retro-term",    "cool-retro-term",                      "CMatrix",                      0,            1,            1,           2 },
	{ "Deadbeef",           "deadbeef",                             "DeaDBeeF-1.8.4",               0,            1,            1,          -1 },
	{ "dragonplayer",       "dragon",                               NULL,                           0,            1,            1,          -1 },
	{ "Firefox",            "Navigator",                            NULL,                           1 << 8,       0,            0,          -1 },
	{ "Firefox",            "Browser",                              "Firefox Preferences",          1 << 8,       0,            1,          -1 },
	{ "Gimp",               NULL,                                   NULL,                           0,            0,            1,          -1 },
	{ "Gnome-calculator",   "gnome-calculator",                     "Calculator",                   0,            1,            1,          -1 },
	{ "gnuplot_qt",         NULL,                                   NULL,                           0,            1,            1,          -1 },
	{ "Krasses Radio",      NULL,                                   NULL,                           1 << 1,       1,            1,          -1 },
	{ "mpv",                NULL,                                   NULL,                           0,            1,            1,          -1 },
	{ "Pavucontrol",        "pavucontrol",                          NULL,                           0,            1,            1,          -1 },
	{ "Surf",               NULL,                                   NULL,                           0,            1,            1,          -1 },
	{ "Teams",              NULL,                                   NULL,                           1 << 6,       0,            0,          -1 },
	{ "Thunderbird",        NULL,                                   NULL,                           1 << 7,       0,            0,          -1 },
	{ "Thunderbird",        "Calendar",                             NULL,                           1 << 7,       1,            1,          -1 },
	{ "Thunderbird",        "CardBook",                             NULL,                           1 << 7,       1,            1,          -1 },
	{ "Thunderbird",        "Mail",                                 "About Mozilla Thunderbird",    1 << 7,       1,            1,          -1 },
	{ "Thunderbird",        "Navigator",                            NULL,                           1 << 7,       1,            1,          -1 },
	{ "Thunderbird",        "Msgcompose",                           NULL,                           1 << 7,       1,            1,          -1 },
	{ "VirtualBox Machine", "VirtualBox Machine",                   NULL,                           1 << 5,       1,            1,          -1 },
	{ "VirtualBox Manager", "VirtualBox Manager",                   NULL,                           0,            1,            1,          -1 },
	{ "Wfica",              NULL,                                   NULL,                           1 << 5,       1,            1,          -1 },
	{ "Vmrc",               "vmrc",                                 NULL,                           0,            1,            1,          -1 },
	{ "XClock",             "xclock",                               "xclock",                       0,            0,            1,          -1 },
	{ "XEyes",              "xeyes",                                "xeyes",                        0,            0,            1,          -1 },
	{ "Xfce4-terminal",     NULL,                                   NULL,                           0,            0,            0,          -1 },
	{ "xfreerdp",           NULL,                                   NULL,                           1 << 4,       1,            1,          -1 },
	{ "Xmessage",           "xmessage",                             "xmessage",                     0,            1,            1,          -1 },
	{ "Xsensors",           "xsensors",                             NULL,                           0,            1,            1,          -1 },
	{ "XTerm",              "xterm",                                "xterm",                        0,            1,            1,          -1 },
	{ "XTerm",              "xterm",                                "cava",                         0,            1,            1,          -1 },
	{ "XTerm",              "xterm",                                "alsamixer",                    0,            1,            1,          -1 },
	{ NULL,                 "outlook.office365.com",                NULL,                           0,            1,            1,           1 },
	{ NULL,                 "google-chrome",                        NULL,                           1 << 8,       0,            0,          -1 },
};

/* layout(s) */
static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "   ",      tile },
	{ "   ",      NULL },
	{ "   ",      monocle },
	{ "   ",      spiral },
	{ "   ",      dwindle },
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
static const char *dmenucmd[]           = { "dmenu_run", "-m", dmenumon, "-i", "-c", "-l", "15", "-bw", "2", "-p", "Яцп ТЋїѕ Ѕћїт:", NULL };
static const char *dmenusystem[]        = { "dwm-system", "-i", "-c", "-l", "15", "-bw", "2", "-p", "ЩЋдт тѳ dѳ", NULL };
static const char *dmenumedia[]         = { "dwm-media", "-i", "-c", "-l", "15", "-bw", "2", "-p", "Play Radio", NULL };
static const char *termcmd[]            = { "st", NULL };
static const char *volumeup[]           = { "dwm-volumectrl", "up", NULL };
static const char *volumedown[]         = { "dwm-volumectrl", "down", NULL };
static const char *volumemute[]         = { "dwm-volumectrl", "mute", NULL };
static const char *xmenu[]              = { "xmenu.sh", NULL };

static Key keys[] = {
		/* modifier                     key        function        argument */
		{ MODKEY,                       XK_w,      spawn,          {.v = xmenu } },
		{ MODKEY,                       XK_p,      spawn,          {.v = dmenucmd } },
		{ MODKEY,                       XK_Return, spawn,          {.v = termcmd } },
		{ MODKEY,                       XK_s,      spawn,          {.v = dmenusystem } },
		{ MODKEY,                       XK_r,      spawn,          {.v = dmenumedia } },
		{ MODKEY,                       XK_b,      togglebar,      {0} },
		{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
		{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
		{ MODKEY|ShiftMask,             XK_i,      incnmaster,     {.i = +1 } },
		{ MODKEY|ShiftMask,             XK_d,      incnmaster,     {.i = -1 } },
		{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
		{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
		{ MODKEY|ShiftMask,             XK_j,      movestack,      {.i = +1 } },
		{ MODKEY|ShiftMask,             XK_k,      movestack,      {.i = -1 } },
		{ MODKEY|ShiftMask,             XK_h,      setcfact,       {.f = +0.25} },
		{ MODKEY|ShiftMask,             XK_l,      setcfact,       {.f = -0.25} },
		{ MODKEY|ShiftMask,             XK_o,      setcfact,       {.f =  0.00} },
		{ MODKEY|ShiftMask,             XK_Return, zoom,           {0} },
		{ MODKEY,                       XK_Tab,    view,           {0} },
		{ MODKEY,                       XK_q,      killclient,     {0} },
		{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
		{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
		{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
		{ MODKEY,                       XK_i,      setlayout,      {.v = &layouts[3]} },
		{ MODKEY,                       XK_o,      setlayout,      {.v = &layouts[4]} },
		{ MODKEY,                       XK_space,  setlayout,      {0} },
		{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
		{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
		{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
		{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
		{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
		{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
		{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
		{ MODKEY,                       XK_minus,  setgaps,        {.i = -1 } },
		{ MODKEY,                       XK_equal,  setgaps,        {.i = +1 } },
		{ MODKEY|ShiftMask,             XK_equal,  setgaps,        {.i = 0  } },
		{ 0,            XF86XK_AudioLowerVolume,   spawn,          {.v = volumedown } },
		{ 0,            XF86XK_AudioRaiseVolume,   spawn,          {.v = volumeup } },
		{ 0,            XF86XK_AudioMute,          spawn,          {.v = volumemute } },
		TAGKEYS(                        XK_1,                      0)
		TAGKEYS(                        XK_2,                      1)
		TAGKEYS(                        XK_3,                      2)
		TAGKEYS(                        XK_4,                      3)
		TAGKEYS(                        XK_5,                      4)
		TAGKEYS(                        XK_6,                      5)
		TAGKEYS(                        XK_7,                      6)
		TAGKEYS(                        XK_8,                      7)
		TAGKEYS(                        XK_9,                      8)
		{ MODKEY|ShiftMask,             XK_q,      quit,           {0} },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkStatusText,        0,              Button3,        spawn,          {.v = xmenu } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

