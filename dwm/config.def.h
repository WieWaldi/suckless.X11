/* See LICENSE file for copyright and license details. */

/* include */
#include <X11/XF86keysym.h>
#include "fibonacci.c"
#include "movestack.c"

/* appearance */
static char font[]                          = "monospace:size=10";
static const char *fonts[]                  = { font };
static const char dmenufont[]               = "monospace:size=10";
static float mfact                          = 0.55;                 /* factor of master area size [0.05..0.95] */
static unsigned int borderpx                = 0;                    /* border pixel of windows */
static unsigned int gappx                   = 15;                   /* gaps between windows */
static unsigned int snap                    = 0;                    /* snap pixel */
static int resizehints                      = 1;                    /* 1 means respect size hints in tiled resizals */
static int nmaster                          = 1;                    /* number of clients in master area */
static int showbar                          = 1;                    /* 0 means no bar */
static int topbar                           = 1;                    /* 0 means bottom bar */
static int horizpadbar                      = 2;                    /* horizontal padding for statusbar */
static int vertpadbar                       = 0;                    /* vertical padding for statusbar */
static int vertpad                          = 10;                   /* vertical padding of bar */
static int sidepad                          = 10;                   /* horizontal padding of bar */
static int lockfullscreen                   = 0;                    /* 1 will force focus on the fullscreen window */
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
static char termcol0[]                      = "#000000";
static char termcol1[]                      = "#ff0000";
static char termcol2[]                      = "#33ff00";
static char termcol3[]                      = "#ff0099";
static char termcol4[]                      = "#0066ff";
static char termcol5[]                      = "#cc00ff";
static char termcol6[]                      = "#00ffff";
static char termcol7[]                      = "#d0d0d0";
static char termcol8[]                      = "#808080";
static char termcol9[]                      = "#ff0000";
static char termcol10[]                     = "#33ff00";
static char termcol11[]                     = "#ff0099";
static char termcol12[]                     = "#0066ff";
static char termcol13[]                     = "#cc00ff";
static char termcol14[]                     = "#00ffff";
static char termcol15[]                     = "#ffffff";

static char *termcolor[] = {
		termcol0,
		termcol1,
		termcol2,
		termcol3,
		termcol4,
		termcol5,
		termcol6,
		termcol7,
		termcol8,
		termcol9,
		termcol10,
		termcol11,
		termcol12,
		termcol13,
		termcol14,
		termcol15,
};

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
		{ "font",               STRING,  &font },
		{ "mfact",              FLOAT,   &mfact },
		{ "borderpx",           INTEGER, &borderpx },
		{ "gappx",              INTEGER, &gappx },
		{ "snap",               INTEGER, &snap },
		{ "resizehints",        INTEGER, &resizehints },
		{ "nmaster",            INTEGER, &nmaster },
		{ "showbar",            INTEGER, &showbar },
		{ "topbar",             INTEGER, &topbar },
		{ "horizpadbar",        INTEGER, &horizpadbar },
		{ "vertpadbar",         INTEGER, &vertpadbar },
		{ "vertpad",            INTEGER, &vertpad },
		{ "sidepad",            INTEGER, &sidepad },
		{ "lockfullscreen",     INTEGER, &lockfullscreen },
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
		{ "color0",             STRING,  &termcol0 },
		{ "color1",             STRING,  &termcol1 },
		{ "color2",             STRING,  &termcol2 },
		{ "color3",             STRING,  &termcol3 },
		{ "color4",             STRING,  &termcol4 },
		{ "color5",             STRING,  &termcol5 },
		{ "color6",             STRING,  &termcol6 },
		{ "color7",             STRING,  &termcol7 },
		{ "color8",             STRING,  &termcol8 },
		{ "color9",             STRING,  &termcol9 },
		{ "color10",            STRING,  &termcol10 },
		{ "color11",            STRING,  &termcol11 },
		{ "color12",            STRING,  &termcol12 },
		{ "color13",            STRING,  &termcol13 },
		{ "color14",            STRING,  &termcol14 },
		{ "color15",            STRING,  &termcol15 },
};
/* tagging */
/* static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" }; */
/* static const char *tags[] = { "➊", "➋", "➌", "➍", "➎", "➏", "➐", "➑", "➒" }; */
/* static const char *tags[] = { "☹", "♨", "♺", "♿", "⚒", "⚓", "⚕", "⚗", "i⚛ }; */
/* static const char *tags[] = { "", "Finder", "File", "Edit", "View", "Settings", "Go", "Window", "Help"}; */
static const char *tags[] = { "", "", "", "", "", "", "", "", "" };

static const Rule rules[] = {
	/* class                instance                                title                           tags mask   iscentered    isfloating    monitor     scratch key */
	{ "Blueman-manager",    "blueman-manager",                      NULL,                           0,          1,            1,            -1,         0   },
	{ "Citrix",             "citrix",                               "Citrix Workspace",             1 << 1,     1,            1,            -1,         0   },
	{ "cool-retro-term",    "cool-retro-term",                      "Settings",                     0,          1,            1,            -1,         0   },
	{ "cool-retro-term",    "cool-retro-term",                      "cool-retro-term",              0,          1,            1,            -1,         0   },
	{ "cool-retro-term",    "cool-retro-term",                      "CMatrix",                      0,          1,            1,            -1,         0   },
	{ "Deadbeef",           "deadbeef",                             "DeaDBeeF-1.8.4",               0,          1,            1,            -1,         0   },
	{ "dragonplayer",       "dragon",                               NULL,                           0,          1,            1,            -1,         0   },
	{ "Firefox",            "Navigator",                            NULL,                           1 << 8,     0,            0,            -1,         0   },
	{ "Firefox",            "Browser",                              "Firefox Preferences",          1 << 8,     0,            1,            -1,         0   },
	{ "Gcolor3",            "gcolor3",                              NULL,                           0,          1,            1,            -1,         0   },
	{ "Gimp",               NULL,                                   NULL,                           0,          0,            1,            -1,         0   },
	{ "Gnome-calculator",   "gnome-calculator",                     "Calculator",                   0,          1,            1,            -1,         0   },
	{ "gnuplot_qt",         NULL,                                   NULL,                           0,          1,            1,            -1,         0   },
	{ "Gpick",              "gpick",                                NULL,                           0,          1,            1,            -1,         0   },
	{ "Gxmessage",          "gxmessage",                            "PopUp",                        0,          1,            1,            -1,         0   },
	{ "Krasses Radio",      NULL,                                   NULL,                           1 << 1,     1,            1,            -1,         0   },
	{ "mpv",                NULL,                                   NULL,                           0,          1,            1,            -1,         0   },
	{ "Pavucontrol",        "pavucontrol",                          NULL,                           0,          1,            1,            -1,         0   },
	{ "Surf",               NULL,                                   NULL,                           0,          1,            1,            -1,         0   },
	{ "Teams",              NULL,                                   NULL,                           0,          1,            1,            -1,         0   },
	{ "Thunderbird",        NULL,                                   NULL,                           1 << 7,     0,            0,            -1,         0   },
	{ "Thunderbird",        "Calendar",                             NULL,                           1 << 7,     1,            1,            -1,         0   },
	{ "Thunderbird",        "CardBook",                             NULL,                           1 << 7,     1,            1,            -1,         0   },
	{ "Thunderbird",        "Mail",                                 "About Mozilla Thunderbird",    1 << 7,     1,            1,            -1,         0   },
	{ "Thunderbird",        "Navigator",                            NULL,                           1 << 7,     1,            1,            -1,         0   },
	{ "Thunderbird",        "Msgcompose",                           NULL,                           1 << 7,     1,            1,            -1,         0   },
	{ "VirtualBox Machine", "VirtualBox Machine",                   NULL,                           1 << 5,     1,            1,            -1,         0   },
	{ "VirtualBox Manager", "VirtualBox Manager",                   NULL,                           0,          1,            1,            -1,         0   },
	{ "Wfica",              NULL,                                   NULL,                           1 << 5,     1,            1,            -1,         0   },
	{ "Vmrc",               "vmrc",                                 NULL,                           0,          1,            1,            -1,         0   },
	{ "XClock",             "xclock",                               "xclock",                       0,          0,            1,            -1,         0   },
	{ "XEyes",              "xeyes",                                "xeyes",                        0,          0,            1,            -1,         0   },
	{ "Xfce4-terminal",     NULL,                                   NULL,                           0,          0,            0,            -1,         0   },
	{ "xfreerdp",           NULL,                                   NULL,                           1 << 4,     1,            1,            -1,         0   },
	{ "Xmessage",           "xmessage",                             "xmessage",                     0,          1,            1,            -1,         0   },
	{ "Xsensors",           "xsensors",                             NULL,                           0,          1,            1,            -1,         0   },
	{ "XTerm",              "xterm",                                "cava",                         0,          1,            1,            -1,         0   },
	{ "XTerm",              "xterm",                                "alsamixer",                    0,          1,            1,            -1,         0   },
	{ NULL,                 "outlook.office365.com",                NULL,                           0,          1,            1,            -1,         0   },
	{ NULL,                 "google-chrome",                        NULL,                           1 << 8,     0,            0,            -1,         0   },
	{ NULL,                 NULL,                                   "ScratchPad1",                  0,          1,            1,            -1,         '1' },
	{ NULL,                 NULL,                                   "ScratchPad2",                  0,          1,            1,            -1,         '2' },
	{ NULL,                 NULL,                                   "NoteTaking",                   0,          1,            1,            -1,         '3' },
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
static const char *tmuxcmd[]            = { "st", "-e", "tmux-start.sh", "Login", NULL };
static const char *volumeup[]           = { "dwm-volumectrl", "up", NULL };
static const char *volumedown[]         = { "dwm-volumectrl", "down", NULL };
static const char *volumemute[]         = { "dwm-volumectrl", "mute", NULL };
static const char *brightnessup[]       = { "dwm-brightness", "up", NULL };
static const char *brightnessdown[]     = { "dwm-brightness", "down", NULL };
static const char *xmenu[]              = { "xmenu.sh", NULL };
static const char *scratchpad1[]        = { "1", "st", "-t", "ScratchPad1", "-g", "200x40", "-e", "tmux-start.sh", "ScratchPad1", NULL}; 
static const char *scratchpad2[]        = { "2", "xterm", "-class", "XTermScratchPad", "-title", "ScratchPad2", "-e", "tmux-start.sh", "ScratchPad2", NULL}; 
static const char *NoteTaking[]         = { "3", "xterm", "-class", "XTermNoteTaking", "-title", "NoteTaking", "-e", "dwm-notetaking", NULL}; 

static const Key keys[] = {
	/* modifier         key                         function        argument */
	{ MODKEY,           XK_w,                       spawn,          {.v = xmenu } },
	{ MODKEY,           XK_p,                       spawn,          {.v = dmenucmd } },
	{ MODKEY,           XK_Return,                  spawn,          {.v = termcmd } },
	{ MODKEY,           XK_s,                       spawn,          {.v = dmenusystem } },
	{ MODKEY,           XK_r,                       spawn,          {.v = dmenumedia } },
	{ MODKEY,           XK_backslash,               spawn,          {.v = tmuxcmd } },
	{ MODKEY,           XK_bracketleft,             togglescratch,  {.v = scratchpad1 } },
	{ MODKEY,           XK_bracketright,            togglescratch,  {.v = scratchpad2 } },
	{ MODKEY,           XK_semicolon,               togglescratch,  {.v = NoteTaking } },
	{ MODKEY,           XK_b,                       togglebar,      {0} },
	{ MODKEY,           XK_j,                       focusstack,     {.i = +1 } },
	{ MODKEY,           XK_k,                       focusstack,     {.i = -1 } },
	{ MODKEY|ShiftMask, XK_i,                       incnmaster,     {.i = +1 } },
	{ MODKEY|ShiftMask, XK_d,                       incnmaster,     {.i = -1 } },
	{ MODKEY,           XK_h,                       setmfact,       {.f = -0.05} },
	{ MODKEY,           XK_l,                       setmfact,       {.f = +0.05} },
	{ MODKEY|ShiftMask, XK_j,                       movestack,      {.i = +1 } },
	{ MODKEY|ShiftMask, XK_k,                       movestack,      {.i = -1 } },
	{ MODKEY|ShiftMask, XK_h,                       setcfact,       {.f = +0.25} },
	{ MODKEY|ShiftMask, XK_l,                       setcfact,       {.f = -0.25} },
	{ MODKEY|ShiftMask, XK_o,                       setcfact,       {.f =  0.00} },
	{ MODKEY|ShiftMask, XK_Return,                  zoom,           {0} },
	{ MODKEY,           XK_Tab,                     view,           {0} },
	{ MODKEY,           XK_q,                       killclient,     {0} },
	{ MODKEY,           XK_t,                       setlayout,      {.v = &layouts[0]} },
	{ MODKEY,           XK_f,                       setlayout,      {.v = &layouts[1]} },
	{ MODKEY,           XK_m,                       setlayout,      {.v = &layouts[2]} },
	{ MODKEY,           XK_i,                       setlayout,      {.v = &layouts[3]} },
	{ MODKEY,           XK_o,                       setlayout,      {.v = &layouts[4]} },
	{ MODKEY,           XK_space,                   setlayout,      {0} },
	{ MODKEY|ShiftMask, XK_space,                   togglefloating, {0} },
	{ MODKEY,           XK_0,                       view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask, XK_0,                       tag,            {.ui = ~0 } },
	{ MODKEY,           XK_comma,                   focusmon,       {.i = -1 } },
	{ MODKEY,           XK_period,                  focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask, XK_comma,                   tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask, XK_period,                  tagmon,         {.i = +1 } },
	{ MODKEY,           XK_minus,                   setgaps,        {.i = -1 } },
	{ MODKEY,           XK_equal,                   setgaps,        {.i = +1 } },
	{ MODKEY|ShiftMask, XK_equal,                   setgaps,        {.i = 0  } },
	{ 0,                XF86XK_AudioLowerVolume,    spawn,          {.v = volumedown } },
	{ 0,                XF86XK_AudioRaiseVolume,    spawn,          {.v = volumeup } },
	{ 0,                XF86XK_AudioMute,           spawn,          {.v = volumemute } },
	{ 0,                XF86XK_MonBrightnessUp,     spawn,          {.v = brightnessup } },
	{ 0,                XF86XK_MonBrightnessDown,   spawn,          {.v = brightnessdown } },
	TAGKEYS(            XK_1,                       0)
	TAGKEYS(            XK_2,                       1)
	TAGKEYS(            XK_3,                       2)
	TAGKEYS(            XK_4,                       3)
	TAGKEYS(            XK_5,                       4)
	TAGKEYS(            XK_6,                       5)
	TAGKEYS(            XK_7,                       6)
	TAGKEYS(            XK_8,                       7)
	TAGKEYS(            XK_9,                       8)
	{ MODKEY|ShiftMask, XK_q,                       quit,            {0} },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
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

