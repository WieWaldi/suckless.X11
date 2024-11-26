/* See LICENSE file for copyright and license details. */

/* appearance */
static char font[200]                          = "monospace:size=10";                                              // font used at topbar
static const char *fonts[]                  = { font };                                                         // get fonts from font.-)
static float mfact                          = 0.55;                                                             // factor of master area size [0.05..0.95]
static int nmaster                          = 1;                                                                // number of clients in master area
static int resizehints                      = 1;                                                                // 1 means respect size hints in tiled resizals
static int lockfullscreen                   = 0;                                                                // 1 will force focus on the fullscreen window
static unsigned int gappih                  = 20;                                                               // horiz inner gap between windows
static unsigned int gappiv                  = 10;                                                               // vert inner gap between windows
static unsigned int gappoh                  = 10;                                                               // horiz outer gap between windows and screen edge
static unsigned int gappov                  = 30;                                                               // vert outer gap between windows and screen edge
static int smartgaps                        = 0;                                                                // 1 means no outer gap when there is only one window
static unsigned int borderpx                = 1;                                                                // border pixel of windows
static unsigned int snap                    = 32;                                                               // snap pixel
static int showbar                          = 1;                                                                // 0 means no bar
static int topbar                           = 1;                                                                // 0 means bottom bar
static int focusonwheel                     = 0;
static int focusedontoptiled                = 1;                                                                // 1 means focused tile client is shown on top of floating windows
static char normbgcolor[]                   = "#222222";
static char normbordercolor[]               = "#444444";
static char normfgcolor[]                   = "#bbbbbb";
static char selfgcolor[]                    = "#eeeeee";
static char selbordercolor[]                = "#005577";
static char selbgcolor[]                    = "#005577";
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
		[SchemeStatus]                      = { statusfgcolor,      statusbgcolor,      "#000000"  },           // Statusbar right {text,background,not used but cannot be empty}
		[SchemeTagsSel]                     = { tagselfgcolor,      tagselbgcolor,      "#000000"  },           // Tagbar left selected {text,background,not used but cannot be empty}
		[SchemeTagsNorm]                    = { tagnormfgcolor,     tagnormbgcolor,     "#000000"  },           // Tagbar left unselected {text,background,not used but cannot be empty}
		[SchemeInfoSel]                     = { infoselfgcolor,     infoselbgcolor,     "#000000"  },           // infobar middle  selected {text,background,not used but cannot be empty}
		[SchemeInfoNorm]                    = { infonormfgcolor,    infonormbgcolor,    "#000000"  },           // infobar middle  unselected {text,background,not used but cannot be empty}
};

/* tagging */
/* static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" }; */
/* static const char *tags[] = { "", "Finder", "File", "Edit", "View", "Settings", "Go", "Window", "Help"}; */
static const char *tags[] = { "", "", "", "", "", "", "󰊻", "", "" };

static const Rule rules[] = {
	/* class                    instance                  title                           tags mask  iscentered  isfloating  alwaysontop  isfakefullscreen  monitor  scratch key */
	{ "Arandr",                 "arandr",                 NULL,                           0,         1,          1,          0,           0,                -1,      0  },
	{ "Blueman-manager",        "blueman-manager",        NULL,                           0,         1,          1,          0,           0,                -1,      0  },
	{ "Citrix",                 "citrix",                 "Citrix Workspace",             1 << 5,    0,          1,          0,           0,                -1,      0  },
	{ "cool-retro-term",        "cool-retro-term",        "Settings",                     0,         1,          1,          0,           0,                -1,      0  },
	{ "cool-retro-term",        "cool-retro-term",        "cool-retro-term",              0,         1,          1,          0,           0,                -1,      0  },
	{ "cool-retro-term",        "cool-retro-term",        "CMatrix",                      0,         1,          1,          0,           0,                -1,      0  },
	{ "Deadbeef",               "deadbeef",               "DeaDBeeF-1.8.4",               0,         1,          1,          0,           0,                -1,      0  },
	{ "dragonplayer",           "dragon",                 NULL,                           0,         1,          1,          0,           0,                -1,      0  },
	{ "Firefox",                "Navigator",              NULL,                           1 << 8,    0,          0,          0,           0,                -1,      0  },
	{ "Firefox",                "Browser",                "Firefox Preferences",          1 << 8,    0,          1,          0,           0,                -1,      0  },
	{ "Gcolor3",                "gcolor3",                NULL,                           0,         1,          1,          0,           0,                -1,      0  },
	{ "Gimp",                   NULL,                     NULL,                           0,         0,          1,          0,           0,                -1,      0  },
	{ "gnome-calculator",       "gnome-calculator",       "Calculator",                   0,         1,          1,          0,           0,                -1,      0  },
	{ "gnuplot_qt",             NULL,                     NULL,                           0,         1,          1,          0,           0,                -1,      0  },
	{ "Gpick",                  "gpick",                  NULL,                           0,         1,          1,          0,           0,                -1,      0  },
	{ "Gxmessage",              "gxmessage",              "PopUp",                        0,         1,          1,          0,           0,                -1,      0  },
	{ "hugin",                  "hugin",                  NULL,                           1 << 2,    0,          1,          0,           0,                -1,      0  },
	{ "hugin",                  "PTBatcherGUI",           NULL,                           1 << 2,    0,          1,          0,           0,                -1,      0  },
	{ "libreoffice-impress",    "libreoffice",            "LibreOffice Impress",          0,         0,          0,          0,           0,                -1,      0  },
	{ "Soffice",                "soffice",                "LibreOffice Impress",          0,         0,          0,          0,           1,                -1,      0  },
	{ "Soffice",                "soffice",                "Presenting",                   0,         0,          0,          0,           0,                 1,      0  },
	{ "Krasses Radio",          NULL,                     NULL,                           1 << 1,    1,          1,          0,           0,                -1,      0  },
	{ "mpv",                    NULL,                     NULL,                           0,         1,          1,          0,           0,                -1,      0  },
	{ "Pavucontrol",            "pavucontrol",            NULL,                           0,         1,          1,          0,           0,                -1,      0  },
	{ "Surf",                   NULL,                     NULL,                           0,         1,          1,          0,           0,                -1,      0  },
	{ "Sxiv",                   NULL,                     NULL,                           0,         1,          1,          0,           0,                -1,      0  },
	{ "Teams",                  NULL,                     NULL,                           0,         1,          1,          0,           0,                -1,      0  },
	{ "Thunderbird",            NULL,                     NULL,                           1 << 7,    0,          0,          0,           0,                -1,      0  },
	{ "Thunderbird",            "Calendar",               NULL,                           1 << 7,    1,          1,          0,           0,                -1,      0  },
	{ "Thunderbird",            "CardBook",               NULL,                           1 << 7,    1,          1,          0,           0,                -1,      0  },
	{ "Thunderbird",            "Mail",                   "About Mozilla Thunderbird",    1 << 7,    1,          1,          0,           0,                -1,      0  },
	{ "Thunderbird",            "Navigator",              NULL,                           1 << 7,    1,          1,          0,           0,                -1,      0  },
	{ "Thunderbird",            "Msgcompose",             NULL,                           1 << 7,    1,          1,          0,           0,                -1,      0  },
	{ "VirtualBox Machine",     "VirtualBox Machine",     NULL,                           1 << 5,    1,          1,          0,           0,                -1,      0  },
	{ "VirtualBox Manager",     "VirtualBox Manager",     NULL,                           0,         1,          1,          0,           0,                -1,      0  },
	{ "Wfica",                  NULL,                     NULL,                           1 << 5,    1,          1,          0,           0,                -1,      0  },
	{ "Vmrc",                   "vmrc",                   NULL,                           0,         1,          1,          0,           0,                -1,      0  },
	{ "XClock",                 "xclock",                 "xclock",                       0,         0,          1,          0,           0,                -1,      0  },
	{ "XEyes",                  "xeyes",                  "xeyes",                        0,         0,          1,          0,           0,                -1,      0  },
	{ "Xfce4-terminal",         NULL,                     NULL,                           0,         0,          0,          0,           0,                -1,      0  },
	{ "Xfe",                    "xfe",                    NULL,                           0,         1,          1,          0,           0,                -1,      0  },
	{ "xfreerdp",               NULL,                     NULL,                           1 << 4,    1,          1,          0,           0,                -1,      0  },
	{ "Xmessage",               "xmessage",               "xmessage",                     0,         1,          1,          0,           0,                -1,      0  },
	{ "Xsensors",               "xsensors",               NULL,                           0,         1,          1,          0,           0,                -1,      0  },
	{ "XTerm",                  "xterm",                  "cava",                         0,         1,          1,          0,           0,                -1,      0  },
	{ "XTerm",                  "xterm",                  "alsamixer",                    0,         1,          1,          0,           0,                -1,      0  },
	{ "zenity",                 "zenity",                 NULL,                           0,         1,          1,          1,           0,                -1,      0  },
	{ NULL,                     "outlook.office365.com",  NULL,                           0,         1,          1,          0,           0,                -1,      0  },
	{ NULL,                     "google-chrome",          NULL,                           1 << 8,    0,          0,          0,           0,                -1,      0  },
	{ NULL,                     NULL,                     "ScratchPad1",                  0,         1,          1,          1,           0,                -1,     '1' },
	{ NULL,                     NULL,                     "ScratchPad2",                  0,         1,          1,          1,           0,                -1,     '2' },
	{ NULL,                     NULL,                     "NoteTaking",                   0,         1,          1,          1,           0,                -1,     '3' },
};

#define FORCE_VSPLIT 1  /* nrowgrid layout: force two clients to always split vertically */

/* include */
#include <X11/XF86keysym.h>
#include "vanitygaps.c"
#include "movestack.c"

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "   Tile     ", tile },                                                                                     // first entry is default
	{ "   Float    ", NULL },                                                                                     // no layout function means floating behavior
	{ "   Monocle  ", monocle },
	{ "   Spiral   ", spiral },
	{ "   Dwindle  ", dwindle },
	{ "   Deck     ", deck },
	{ "   BStack   ", bstack },
	{ "   BStackH  ", bstackhoriz },
	{ "   Grid     ", grid },
	{ "   nRow Grid", nrowgrid },
	{ "   HorizGrid", horizgrid },
	{ "   Gapless G", gaplessgrid },
	{ "| |CMaster  ", centeredmaster },
	{ "| |CFMaster ", centeredfloatingmaster },
	{ NULL,            NULL },
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
static char dmenumon[2] = "0";                                                                                  // component of dmenucmd, manipulated in spawn()
static const char *dmenucmd[]           = { "dmenu_run", "-m", dmenumon, "-i", "-c", "-l", "15", "-bw", "2", "-p", "Яцп ТЋїѕ Ѕћїт: 󰜎 ", NULL };
static const char *dmenusystem[]        = { "dwm-system", NULL };
static const char *dmenumedia[]         = { "dwm-media", NULL };
static const char *termcmd[]            = { "st", NULL };
static const char *tmuxcmd[]            = { "st", "-e", "tmux-start.sh", "Login", NULL };
static const char *volumeup[]           = { "dwm-volumectrl", "up", NULL };
static const char *volumedown[]         = { "dwm-volumectrl", "down", NULL };
static const char *volumemute[]         = { "dwm-volumectrl", "mute", NULL };
static const char *brightnessup[]       = { "dwm-brightness", "up", NULL };
static const char *brightnessdown[]     = { "dwm-brightness", "down", NULL };
static const char *xmenu[]              = { "xmenu.sh", NULL };
static const char *scratchpad1[]        = { "1", "st", "-t", "ScratchPad1", "-g", "200x40", "-e", "tmux-start.sh", "ScratchPad1", NULL }; 
static const char *scratchpad2[]        = { "2", "xterm", "-class", "XTermScratchPad", "-title", "ScratchPad2", "-e", "tmux-start.sh", "ScratchPad2", NULL }; 
static const char *NoteTaking[]         = { "3", "xterm", "-class", "XTermNoteTaking", "-title", "NoteTaking", "-e", "dwm-notetaking", NULL }; 
static const char *layoutmenu_cmd       = "dwm-layoutmenu";

/* commands spawned when clicking statusbar, the mouse button pressed is exported as BUTTON */
static const char *statuscmd[]          = { "/bin/sh", "-c", NULL, NULL };
static const StatusCmd statuscmds[]     = { 
                                            { "dwm-statuscmd 1 $BUTTON", 1 },
                                            { "dwm-statuscmd 2 $BUTTON", 2 },
                                            { "dwm-statuscmd 3 $BUTTON", 3 },
                                            { "dwm-statuscmd 4 $BUTTON", 4 },
                                            { "dwm-statuscmd 5 $BUTTON", 5 },
                                            { "dwm-statuscmd 6 $BUTTON", 6 },
                                            { "dwm-statuscmd 7 $BUTTON", 7 },
                                            { "dwm-statuscmd 8 $BUTTON", 8 },
                                            { "dwm-statuscmd 9 $BUTTON", 9 },
};

/*
 * Xresources preferences to load at startup
 */
ResourcePref resources[] = {
		{ "borderpx",           INTEGER, &borderpx },
		{ "font",               STRING,  &font },
		{ "gappih",             INTEGER, &gappih },
		{ "gappiv",             INTEGER, &gappiv },
		{ "gappoh",             INTEGER, &gappoh },
		{ "gappov",             INTEGER, &gappov },
		{ "infonormbgcolor",    STRING,  &infonormbgcolor },
		{ "infonormfgcolor",    STRING,  &infonormfgcolor },
		{ "infoselbgcolor",     STRING,  &infoselbgcolor },
		{ "infoselfgcolor",     STRING,  &infoselfgcolor },
		{ "lockfullscreen",     STRING,  &lockfullscreen },
		{ "mfact",              FLOAT,   &mfact },
		{ "nmaster",            INTEGER, &nmaster },
		{ "normbgcolor",        STRING,  &normbgcolor },
		{ "normbordercolor",    STRING,  &normbordercolor },
		{ "normfgcolor",        STRING,  &normfgcolor },
		{ "resizehints",        INTEGER, &resizehints },
		{ "selbgcolor",         STRING,  &selbgcolor },
		{ "selbordercolor",     STRING,  &selbordercolor },
		{ "selfgcolor",         STRING,  &selfgcolor },
		{ "showbar",            INTEGER, &showbar },
		{ "snap",               INTEGER, &snap },
		{ "statusbgcolor",      STRING,  &statusbgcolor },
		{ "statusfgcolor",      STRING,  &statusfgcolor },
		{ "tagnormbgcolor",     STRING,  &tagnormbgcolor },
		{ "tagnormfgcolor",     STRING,  &tagnormfgcolor },
		{ "tagselbgcolor",      STRING,  &tagselbgcolor },
		{ "tagselfgcolor",      STRING,  &tagselfgcolor },
		{ "topbar",             INTEGER, &topbar },
};

static const Key keys[] = {
	/* modifier                     key                         function                argument */
	{ MODKEY|ShiftMask,             XK_q,                       quit,                   {0} },
	{ MODKEY,                       XK_q,                       killclient,             {0} },
	{ MODKEY,                       XK_w,                       spawn,                  {.v = xmenu } },
	{ MODKEY,                       XK_p,                       spawn,                  {.v = dmenucmd } },
	{ MODKEY,                       XK_Return,                  spawn,                  {.v = termcmd } },
	{ MODKEY,                       XK_s,                       spawn,                  {.v = dmenusystem } },
	{ MODKEY,                       XK_r,                       spawn,                  {.v = dmenumedia } },
	{ MODKEY,                       XK_backslash,               spawn,                  {.v = tmuxcmd } },
	{ MODKEY,                       XK_bracketleft,             togglescratch,          {.v = scratchpad1 } },
	{ MODKEY,                       XK_bracketright,            togglescratch,          {.v = scratchpad2 } },
	{ MODKEY,                       XK_semicolon,               togglescratch,          {.v = NoteTaking } },
	{ MODKEY,                       XK_b,                       togglebar,              {0} },
	{ MODKEY,                       XK_j,                       focusstack,             {.i = +1 } },
	{ MODKEY,                       XK_k,                       focusstack,             {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_i,                       incnmaster,             {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_d,                       incnmaster,             {.i = -1 } },
	{ MODKEY,                       XK_h,                       setmfact,               {.f = -0.05} },
	{ MODKEY,                       XK_l,                       setmfact,               {.f = +0.05} },
	{ MODKEY|ShiftMask,             XK_h,                       setcfact,               {.f = +0.25} },
	{ MODKEY|ShiftMask,             XK_l,                       setcfact,               {.f = -0.25} },
	{ MODKEY|ShiftMask,             XK_o,                       setcfact,               {.f =  0.00} },
	{ MODKEY|ShiftMask,             XK_j,                       movestack,              {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_k,                       movestack,              {.i = -1 } },
//	{ MODKEY,                       XK_Return,                  zoom,                   {0} },
	{ MODKEY|ShiftMask,             XK_u,                       incrgaps,               {.i = +1 } },
	{ MODKEY|ShiftMask|ShiftMask,   XK_u,                       incrgaps,               {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_i,                       incrigaps,              {.i = +1 } },
	{ MODKEY|ShiftMask|ShiftMask,   XK_i,                       incrigaps,              {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_o,                       incrogaps,              {.i = +1 } },
	{ MODKEY|ShiftMask|ShiftMask,   XK_o,                       incrogaps,              {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_6,                       incrihgaps,             {.i = +1 } },
	{ MODKEY|ShiftMask|ShiftMask,   XK_6,                       incrihgaps,             {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_7,                       incrivgaps,             {.i = +1 } },
	{ MODKEY|ShiftMask|ShiftMask,   XK_7,                       incrivgaps,             {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_8,                       incrohgaps,             {.i = +1 } },
	{ MODKEY|ShiftMask|ShiftMask,   XK_8,                       incrohgaps,             {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_9,                       incrovgaps,             {.i = +1 } },
	{ MODKEY|ShiftMask|ShiftMask,   XK_9,                       incrovgaps,             {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_0,                       togglegaps,             {0} },
	{ MODKEY|ShiftMask|ShiftMask,   XK_0,                       defaultgaps,            {0} },
	{ MODKEY,                       XK_Tab,                     view,                   {0} },
	{ MODKEY,                       XK_t,                       setlayout,              {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,                       setlayout,              {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,                       setlayout,              {.v = &layouts[2]} },
	{ MODKEY,                       XK_space,                   setlayout,              {0} },
	{ MODKEY|ShiftMask,             XK_space,                   togglefloating,         {0} },
	{ MODKEY|ControlMask,           XK_f,                       togglefullscreen,       {0} },
	{ MODKEY|ShiftMask,             XK_f,                       togglefakefullscreen,   {0} },
	{ MODKEY,                       XK_0,                       view,                   {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,                       tag,                    {.ui = ~0 } },
	{ MODKEY,                       XK_comma,                   focusmon,               {.i = -1 } },
	{ MODKEY,                       XK_period,                  focusmon,               {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,                   tagmon,                 {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period,                  tagmon,                 {.i = +1 } },
	{ 0,                            XF86XK_AudioLowerVolume,    spawn,                  {.v = volumedown } },
	{ 0,                            XF86XK_AudioRaiseVolume,    spawn,                  {.v = volumeup } },
	{ 0,                            XF86XK_AudioMute,           spawn,                  {.v = volumemute } },
	{ 0,                            XF86XK_MonBrightnessUp,     spawn,                  {.v = brightnessup } },
	{ 0,                            XF86XK_MonBrightnessDown,   spawn,                  {.v = brightnessdown } },
//	{ 0,                            XF86XK_AudioLowerVolume,    spawn,                  SHCMD("command.sh option1 option2") },
	TAGKEYS(                        XK_1,                       0)
	TAGKEYS(                        XK_2,                       1)
	TAGKEYS(                        XK_3,                       2)
	TAGKEYS(                        XK_4,                       3)
	TAGKEYS(                        XK_5,                       4)
	TAGKEYS(                        XK_6,                       5)
	TAGKEYS(                        XK_7,                       6)
	TAGKEYS(                        XK_8,                       7)
	TAGKEYS(                        XK_9,                       8)
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
	/* click                event mask          button          function        argument */
	{ ClkLtSymbol,          0,                  Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,                  Button3,        layoutmenu,     {0} },
	{ ClkWinTitle,          0,                  Button2,        zoom,           {0} },
	{ ClkWinTitle,          0,                  Button3,        spawn,          {.v = xmenu } },
// 	{ ClkStatusText,        0,                  Button2,        spawn,          {.v = termcmd } },
	{ ClkStatusText,        0,                  Button1,        spawn,          {.v = statuscmd } },
	{ ClkStatusText,        0,                  Button2,        spawn,          {.v = statuscmd } },
	{ ClkStatusText,        0,                  Button3,        spawn,          {.v = statuscmd } },
	{ ClkClientWin,         MODKEY,             Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,             Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY|ShiftMask,   Button3,        resizeorfacts,  {0} },
	{ ClkClientWin,         MODKEY,             Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,                  Button1,        view,           {0} },
	{ ClkTagBar,            0,                  Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,             Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,             Button3,        toggletag,      {0} },
};

