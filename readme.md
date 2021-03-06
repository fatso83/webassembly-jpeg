# Experiments : read and write Jpeg with Web Assembly in real time

## Install, build and run

Install Emscripten from https://kripken.github.io/emscripten-site/index.html  
Don't forget to launch the environment script (`source emsdk_set_env.sh` on Linux for example)

Install dependencies : 

    npm install 

Download the JPEG lib from the Independant Jpeg Group website to project directory :

    http://www.ijg.org/files/

Let's say you downloaded `jpegsrc.v9b.tar.gz`

Untar & unzip the jpeg lib : 

    mkdir libjpeg
    tar xvzf jpegsrc.v9b.tar.gz -C ./libjpeg --strip-components=1

The first step is to configure the Jpeg lib build environment. Usually, you would launch the `configure` script, but since our target is not the host architecture/operating system but WASM, we use `emconfigure` to wrap this process : 

    cd libjpeg
    emconfigure ./configure
    # You may have an error message about the dynamic linker. Just ignore it.

We can now build the library in WASM format. We use the `emmake` wrapper : 
    
    emmake make

We have now a WASM Jpeg library ready to be included into our project.  
Let's build our app :

    cd ..
    emcc -o example.js example.c libjpeg/.libs/libjpeg.a -O3 -s WASM=1 -s NO_EXIT_RUNTIME=1

Launch a local server : 

    npm start

And play with the app on `localhost:8080/example.html`

