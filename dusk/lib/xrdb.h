#include <X11/Xresource.h>

/* Xresources preferences */
enum resource_type {
	STRING = 0,
	INTEGER = 1,
	FLOAT = 2
};

typedef struct {
	char *name;
	enum resource_type type;
	void *dst;
} ResourcePref;

static void loadxrdb(void);
static int loadxrdbcolor(XrmDatabase xrdb, char **dest, unsigned int *alpha, char *resource);
static int loadxrdbalpha(XrmDatabase xrdb, unsigned int *alpha, char *resource);
static void loadxrdbconfig(XrmDatabase xrdb, char *name, enum resource_type rtype, void *dst);
static void xrdb(const Arg *arg);
