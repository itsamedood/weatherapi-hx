@ECHO OFF
TITLE Makefile-ish
:MAIN
	CLS
	CALL haxe build.hxml
	CALL neko bin/wapi.n
