# expects node, VS, and MSYS environments to be set up already. does everything else.

deps="cairo-2 png16-16 jpeg-8 pango-1.0-0 pangocairo-1.0-0 gobject-2.0-0 glib-2.0-0 turbojpeg gif-7 freetype-6 rsvg-2-2";

# install cairo and tools to create .lib

pacman --noconfirm -S \
  wget \
  unzip \
  mingw-w64-ucrt-x86_64-binutils \
  mingw-w64-ucrt-x86_64-tools \
  mingw-w64-ucrt-x86_64-libjpeg-turbo \
  mingw-w64-ucrt-x86_64-pango \
  mingw-w64-ucrt-x86_64-cairo \
  mingw-w64-ucrt-x86_64-giflib \
  mingw-w64-ucrt-x86_64-freetype \
  mingw-w64-ucrt-x86_64-fontconfig \
  mingw-w64-ucrt-x86_64-librsvg \
  mingw-w64-ucrt-x86_64-libxml2

# create .lib files for vc++

echo "generating lib files for the MSYS2 dlls"
for lib in $deps; do
  gendef /ucrt64/bin/lib$lib.dll > /dev/null 2>&1 || {
    echo "could not find lib$lib.dll, have to skip ";
    continue;
  }

  dlltool -d lib$lib.def -l /ucrt64/lib/lib$lib.lib > /dev/null 2>&1 || {
    echo "could not create dll for lib$lib.dll";
    continue;
  }

  echo "created lib$lib.lib from lib$lib.dll";

  rm lib$lib.def
done
