.PHONY: gen
gen:
	melos gen

.PHONY: setup/pub
setup/pub:
	dart pub global activate melos
	flutter pub get
