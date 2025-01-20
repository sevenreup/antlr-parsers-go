ANTLR_URL := https://www.antlr.org/download/antlr-4.13.2-complete.jar
ANTLR_BIN := $(PWD)/.bin/antlr-4.13.2-complete.jar
ANTLR := java -jar $(ANTLR_BIN) -Dlanguage=Go -listener -no-visitor


$(ANTLR_BIN):
	mkdir -p .bin
	curl -o $@ $(ANTLR_URL)

BUILD=bash -c '\
	basedir=$$PWD; \
	mkdir -p java; \
	$(ANTLR) $$basedir/grammars-v4/java/java/JavaLexer.g4 -package java -o $$basedir/java; \
	$(ANTLR) $$basedir/grammars-v4/java/java/JavaParser.g4 -package java -o $$basedir/java; \
'

grammars-v4:
	git submodule init
	git submodule update

build:
	${BUILD}