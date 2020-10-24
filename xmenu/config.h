static struct Config config = {
	/* font */
	.font = "FiraMono Nerd Font:size=12", /* for regular items */

	/* colors */
	.background_color = "#5f005f",
	.foreground_color = "#bbbbbb",
	.selbackground_color = "#8700af",
	.selforeground_color = "#eeeeee",
	.separator_color = "#af87d7",
	.border_color = "#8700af",

	/* sizes in pixels */
	.width_pixels = 130,        /* minimum width of a menu */
	.height_pixels = 25,        /* height of a single menu item */
	.border_pixels = 0,         /* menu border */
	.separator_pixels = 3,      /* space around separator */
	.gap_pixels = 0,            /* gap between menus */

	/*
	 * The variables below cannot be set by X resources.
	 * Their values must be less than .height_pixels.
	 */

	/* geometry of the right-pointing isoceles triangle for submenus */
	.triangle_width = 3,
	.triangle_height = 7,

	/* the icon size is equal to .height_pixels - .iconpadding * 2 */
	.iconpadding = 2,

	/* area around the icon, the triangle and the separator */
	.horzpadding = 8,
};
