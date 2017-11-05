all: dice-roller.desktop \
     po/dice-roller.bhdouglass.pot \
     share/locale/de/LC_MESSAGES/dice-roller.bhdouglass.mo \
     share/locale/el/LC_MESSAGES/dice-roller.bhdouglass.mo \
     share/locale/fr/LC_MESSAGES/dice-roller.bhdouglass.mo \
     share/locale/hu/LC_MESSAGES/dice-roller.bhdouglass.mo \
     share/locale/it/LC_MESSAGES/dice-roller.bhdouglass.mo \
     share/locale/nl/LC_MESSAGES/dice-roller.bhdouglass.mo \
     share/locale/zh_CN/LC_MESSAGES/dice-roller.bhdouglass.mo

dice-roller.desktop: dice-roller.desktop.in po/*.po
	intltool-merge --desktop-style po $< $@

po/dice-roller.bhdouglass.pot: Main.qml DiceDialog.qml dice-roller.desktop.in
	touch po/dice-roller.bhdouglass.pot
	xgettext --language=JavaScript --keyword=tr --keyword=tr:1,2 --add-comments=TRANSLATORS Main.qml -o po/dice-roller.bhdouglass.pot
	xgettext --language=JavaScript --keyword=tr --keyword=tr:1,2 --add-comments=TRANSLATORS DiceDialog.qml -o po/dice-roller.bhdouglass.pot
	intltool-extract --type=gettext/keys dice-roller.desktop.in
	xgettext --keyword=N_ dice-roller.desktop.in.h -j -o po/dice-roller.bhdouglass.pot
	rm -f dice-roller.desktop.in.h

share/locale/%/LC_MESSAGES/dice-roller.bhdouglass.mo: po/%.po
	mkdir -p $@
	rmdir $@
	msgfmt -o $@ $<

clean:
	rm -f share/locale/*/*/*.mo dice-roller.desktop

run:
	/usr/bin/qmlscene $@ Main.qml
