/* REMEMBER TO:
 *
 * Update fonts buffer to a safe size, e.g:
 * ```config.def.h
 * static char font[64]      = ...
 * static char dmenufont[64] = ...
 * ```
 *
 * Add:
 * ```dwm.c
 * db = XrmGetStringDatabase(resm);
 * for (p = resources; p < resources + LENGTH(resources); p++)
 *     resource_load(db, p->name, p->type, p->dst);
 * XrmDestroyDatabase(db); // ← This
 * XCloseDisplay(display);
 * ```
 *
 * and
 *
 * ```config.def.h
 * { MODKEY,                       XK_F5,         reload_resources,  {.v = NULL } },
 * ```
 * with the function:
 */
void
reload_resources(const Arg *arg)
{
	int i;
	Client *c;
	Monitor *m;

	load_xresources();

	for (i = 0; i < LENGTH(colors) + 1; i++) {
		if (scheme[i]) drw_scm_free(drw, scheme[i], 3);
	}

	if (drw->fonts)
		drw_fontset_free(drw->fonts);
	drw->fonts = drw_fontset_create(drw, fonts, LENGTH(fonts));
	lrpad = drw->fonts->h;
	bh = drw->fonts->h + user_bh;

	scheme[LENGTH(colors)] = drw_scm_create(drw, colors[0], 3);
	for (i = 0; i < LENGTH(colors); i++)
		scheme[i] = drw_scm_create(drw, colors[i], 3);

	for (m = mons; m; m = m->next) {
		for (c = m->clients; c; c = c->next) {
			if (c == selmon->sel)
				XSetWindowBorder(dpy, c->win, scheme[SchemeSel][ColBorder].pixel);
			else
				XSetWindowBorder(dpy, c->win, scheme[SchemeNorm][ColBorder].pixel);
		}
	}

	for (m = mons; m; m = m->next) {
		updatebarpos(m);
		resizebarwin(m);
	}

	focus(NULL);
	arrange(NULL);
}
