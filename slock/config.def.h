/* user and group to drop privileges to */
static const char *user  = "nobody";
static const char *group = "nobody";

static const char *colorname[NUMCOLS] = {
	[INIT] =   "black",     /* after initialization */
	[INPUT] =  "#005577",   /* during input */
	[FAILED] = "#CC3333",   /* wrong password */
	[CAPS] =   "red",       /* CapsLock on */
};

/* treat a cleared input like a wrong password (color) */
static const int failonclear = 1;

/* default message */
static const char * message = "Suckless: Software that sucks less.";

/* text color */
static const char * text_color = "#ffffff";

/* text size (must be a valid size) */
static const char * font_name = "6x10";

/*
 * Xresources preferences to load at startup
 */
ResourcePref resources[] = {
		{ "color0",       STRING,  &colorname[INIT] },
		{ "color1",       STRING,  &colorname[FAILED] },
		{ "color3",       STRING,  &colorname[CAPS] },
		{ "color4",       STRING,  &colorname[INPUT] },
		{ "fontname",     STRING,  &font_name },
		{ "fontcolor",    STRING,  &text_color },
};
