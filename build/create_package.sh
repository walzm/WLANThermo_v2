#!/bin/bash

cd "${BASH_SOURCE%/*}" || exit

echo Kopiere Software in das Buildverzeichniss...
cp -r ../software/* ./build/
echo Kopiere Paketdaten in das Buildverzeichniss...
cp -r ../DEBIAN ./build/
echo Kopiere Changelog in das Buildverzeichniss...
cp -r ../changelog ./build/DEBIAN/changelog

echo Suche Versionsnummer...
VERSION=`dpkg-parsechangelog -lbuild/DEBIAN/changelog --show-field Version`
echo Paketversion: $VERSION
echo Setze Version in den Paketdaten...
echo Version: $VERSION >> ./build/DEBIAN/control

echo Baue Paket...
dpkg -b ./build ./package/wlanthermo-$VERSION.deb

echo Lösche Buildverzeichniss...
rm -r ./build/*
