/* See LICENSE file for copyright and license details. */

/* include */
#include <X11/XF86keysym.h>
#include "fibonacci.c"
#include "movestack.c"

/* appearance */
static const unsigned int borderpx          = 2;        /* border pixel of windows */
static const unsigned int gappx             = 5;        /* gaps between windows */
static const unsigned int snap              = 32;       /* snap pixel */
static const int showbar                    = 1;        /* 0 means no bar */
static const int topbar                     = 1;        /* 0 means bottom bar */
static const char *fonts[]                  = { "FiraMono Nerd Font:size=11" };
static const char dmenufont[]               = "FiraMono Nerd Font:size=12";
static const char col_gray1[]               = "#222222";
static const char col_gray2[]               = "#444444";
static const char col_gray3[]               = "#bbbbbb";
static const char col_gray4[]               = "#eeeeee";
static const char col_cyan[]                = "#005577";
static const char col_yellow[]              = "#b58900";
static const char col_DeepPink[]            = "#5f005f";
static const char col_DarkMagenta[]         = "#8700af";
static const char col_MediumPurple[]        = "#af87d7";
static const char col_AppleBG[]             = "#c0cae4";
static const char col_AppleFG[]             = "#101531";
static const char *colors[][3]      = {
	/*               fg         bg         border   */
	/* My Theme */
    [SchemeNorm] = { col_gray4, col_gray1, col_gray2 },
    [SchemeSel]  = { col_gray4, col_cyan,  col_yellow  },
    [SchemeStatus]  = { col_gray4, col_DeepPink,  "#000000"  },             // Statusbar right {text,background,not used but cannot be empty}
    [SchemeTagsSel]  = { col_gray4, col_DeepPink,  "#000000"  },            // Tagbar left selected {text,background,not used but cannot be empty}
    [SchemeTagsNorm]  = { col_MediumPurple, col_DeepPink,  "#000000"  },    // Tagbar left unselected {text,background,not used but cannot be empty}
    [SchemeInfoSel]  = { col_gray4, col_DeepPink,  "#000000"  },            // infobar middle  selected {text,background,not used but cannot be empty}
    [SchemeInfoNorm]  = { col_gray4, col_DeepPink,  "#000000"  },           // infobar middle  unselected {text,background,not used but cannot be empty}

	/* Apple */
    // [SchemeNorm] = { col_AppleFG, col_gray1, col_gray2 },
    // [SchemeSel]  = { col_AppleFG, col_cyan,  col_yellow  },
    // [SchemeStatus]  = { col_AppleFG, col_AppleBG,  "#000000"  },             // Statusbar right {text,background,not used but cannot be empty}
    // [SchemeTagsSel]  = { col_AppleFG, col_AppleBG,  "#000000"  },            // Tagbar left selected {text,background,not used but cannot be empty}
    // [SchemeTagsNorm]  = { col_AppleFG, col_AppleBG,  "#000000"  },    // Tagbar left unselected {text,background,not used but cannot be empty}
    // [SchemeInfoSel]  = { col_AppleFG, col_AppleBG,  "#000000"  },            // infobar middle  selected {text,background,not used but cannot be empty}
    // [SchemeInfoNorm]  = { col_AppleFG, col_AppleBG,  "#000000"  },           // infobar middle  unselected {text,background,not used but cannot be empty}


};

/* tagging */
/* static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" }; */
/* static const char *tags[] = { "➊", "➋", "➌", "➍", "➎", "➏", "➐", "➑", "➒" }; */
/* static const char *tags[] = { "☹", "♨", "♺", "♿", "⚒", "⚓", "⚕", "⚗", "i⚛ }; */
static const char *tags[] = { "", "", "", "", "", "", "", "", "" };
/* static const char *tags[] = { "", "Finder", "File", "Edit", "View", "Settings", "Go", "Window", "Help"}; */

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class                instance        title                   tags mask     isfloating    monitor */
    { "Gimp",               NULL,           NULL,                   0,            True,         -1 },
    { "Xfce4-terminal",     NULL,           NULL,                   0,            False,        -1 },
    { "VirtualBox",         "VirtualBox",   NULL,                   0,            False,        -1 },
    { "Firefox",            "Navigator",    NULL,                   1 << 8,       False,        -1 },
    { "Firefox",            "Browser",      "Firefox Preferences",  1 << 8,       True,         -1 },
    { "Thunderbird",        NULL,           NULL,                   1 << 7,       False,        -1 },
    { "Thunderbird",        "Msgcompose",   NULL,                   1 << 7,       True,         -1 },
    { "Wfica",              NULL,           NULL,                   1 << 6,       True,         -1 },
    { "xfreerdp",           NULL,           NULL,                   1 << 4,       True,         -1 },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */

static const Layout layouts[] = {
	/* symbol     arrange function */
	// { "[]=",      tile },    /* first entry is default */
	// { "><>",      NULL },    /* no layout function means floating behavior */
	// { "[M]",      monocle },
 	// { "[@]",      spiral },
 	// { "[\\]",     dwindle },

    { "",      tile },
    { "",      NULL },
    { "",      monocle },
    { "",      spiral },
    { "",      dwindle },
};

/* key definitions */
#define MODKEY Mod1Mask
#define MONKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[]           = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-p", "Яцп ТЋїѕ Ѕћїт:",  "-nb", col_DeepPink, "-nf", col_gray3, "-sb", col_DarkMagenta, "-sf", col_gray4, NULL };
static const char *dmenusystem[]        = { "dwm_system", "-i", "-fn", dmenufont, "-p", "ЩЋдт тѳ dѳ", "-nb", col_DeepPink, "-nf", col_gray3, "-sb", col_DarkMagenta, "-sf", col_gray4, NULL };
static const char *termcmd[]            = { "st", NULL };
static const char *slock[]              = { "slock_wrapper", NULL };
static const char *volumeup[]           = { "dwm_volumectrl", "up", NULL };
static const char *volumedown[]         = { "dwm_volumectrl", "down", NULL };
static const char *volumemute[]         = { "dwm_volumectrl", "mute", NULL };

// static const char *slock[]    = { "slock -m \"$(/bin/cat ~/.slocktext)\"", NULL };

static Key keys[] = {
	/* modifier                     key        function        argument */
	{ MONKEY,                       XK_s,      spawn,          {.v = dmenusystem } },
	{ MODKEY,                       XK_p,      spawn,          {.v = dmenucmd } },
	{ MODKEY,                       XK_Return, spawn,          {.v = termcmd } },
	{ MODKEY,                       XK_s,      spawn,          {.v = slock } },
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_d,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY|ShiftMask,             XK_j,      movestack,      {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_k,      movestack,      {.i = -1 } },
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
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};
