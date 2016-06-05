all: dice-roller.desktop \
     po/com.ubuntu.developer.robert-ancell.dice-roller.pot \
     share/locale/de/LC_MESSAGES/com.ubuntu.developer.robert-ancell.dice-roller.mo \
     share/locale/fr/LC_MESSAGES/com.ubuntu.developer.robert-ancell.dice-roller.mo \
     share/locale/it/LC_MESSAGES/com.ubuntu.developer.robert-ancell.dice-roller.mo

click:
	click build --ignore=Makefile --ignore=*.pot --ignore=*.po --ignore=*.qmlproject --ignore=*.qmlproject.user --ignore=*.in --ignore=po .

dice-roller.desktop: dice-roller.desktop.in po/*.po
	intltool-merge --desktop-style po $< $@

po/com.ubuntu.developer.robert-ancell.dice-roller.pot: main.qml dice-roller.desktop.in
	touch po/com.ubuntu.developer.robert-ancell.dice-roller.pot
	xgettext --language=JavaScript --keyword=tr --keyword=tr:1,2 --add-comments=TRANSLATORS main.qml -o po/com.ubuntu.developer.robert-ancell.dice-roller.pot
	intltool-extract --type=gettext/keys dice-roller.desktop.in
	xgettext --keyword=N_ dice-roller.desktop.in.h -j -o po/com.ubuntu.developer.robert-ancell.dice-roller.pot
	rm -f dice-roller.desktop.in.h

share/locale/%/LC_MESSAGES/com.ubuntu.developer.robert-ancell.dice-roller.mo: po/%.po
	msgfmt -o $@ $<

clean:
	rm -f share/locale/*/*/*.mo dice-roller.desktop

run:
	/usr/bin/qmlscene $@ main.qml
