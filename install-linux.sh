# preface: install Emscripten
# See https://kripken.github.io/emscripten-site/docs/getting_started/downloads.html#installation-instructions
# curl -s https://s3.amazonaws.com/mozilla-games/emscripten/releases/emsdk-portable.tar.gz | tar xz
# $ cd ../emsdk-portable/
# $ ./emsdk update
# $ ./emsdk install latest
# $ ./emsdk activate latest
# $ source ./emsdk_env.sh

LIBJPEG_URL="http://www.ijg.org/files/jpegsrc.v9b.tar.gz"

npm install
mkdir libjpeg
curl -s "$LIBJPEG_URL" | tar xvz -C ./libjpeg --strip-components=1 
cd libjpeg
emconfigure ./configure
# You may have an error message about the dynamic linker. Just ignore it.
emmake make

cd ..
emcc -o example.js example.c libjpeg/.libs/libjpeg.a -O3 -s WASM=1 -s NO_EXIT_RUNTIME=1

npm start 
open localhost:8080

#cat << EOF
#The following error will appear in the browser console:

#wasm streaming compile failed: TypeError: Module.cwrap is not a function
#example.js:1:15562
#falling back to ArrayBuffer instantiation
#example.js:1:15623
#EOF
