cd /workspace

BINUTILS_VERSION=2_43_1
GCC_VERSION=12.4.0
LIBC_VERSION=2_2_1

mkdir -p repos
cd repos

if test -d binutils-gdb; then
  echo "Binutils repo found. Reusing existing repo."
else
    git clone --branch binutils-$BINUTILS_VERSION --depth 1 git://sourceware.org/git/binutils-gdb.git
fi

if test -d gcc; then
  echo "Gcc repo found. Reusing existing repo."
else
    git clone --branch releases/gcc-$GCC_VERSION --depth 1 git://gcc.gnu.org/git/gcc.git
fi

if test -d avr-libc; then
  echo "Avr-libc repo found. Reusing existing repo."
else
    git clone --branch avr-libc-$LIBC_VERSION-release --depth 1 https://github.com/avrdudes/avr-libc.git
fi

cd ..
mkdir -p build
cd build

# Building binutils
if test -d binutils-gdb; then
    echo "Binutils build folder found. Skipping build. Remove folder to force build."
else
    mkdir binutils-gdb
    cd binutils-gdb
    ../../repos/binutils-gdb/configure --prefix=/workspace/build/avrtools --disable-nls --target=avr
    make -j2
    make install
    cd ..
fi

# Building gcc
if test -d gcc; then
    echo "Gcc build folder found. Skipping build. Remove folder to force build."
else
    mkdir gcc
    cd gcc
    ../../repos/gcc/configure --prefix=/workspace/build/avrtools --disable-nls --enable-languages=c,c++ --target=avr --disable-libssp --with-dwarf2
    make -j2
    make install
    cd ..
fi

# Building avr-libc
if test -d avr-libc; then
    echo "Avr-libc build folder found. Skipping build. Remove folder to force build."
else
    cd ../repos/avr-libc
    rm -rf ../../build/avr-libc
    git checkout-index -af --prefix=$(pwd)/../../build/avr-libc/
    cd ../../build/avr-libc
    ./bootstrap
    ./configure --prefix=/workspace/build/avrtools --build=`./config.guess` --host=avr --enable-debug-info=dwarf-4
    make -j2
    make install
    cd ..
fi

tar -czvf avrtools.tgz avrtools
