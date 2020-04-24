# goal: work out of the box on Ubuntu 18.04

# xz = brew install xz
# ar = install Xcode CLI tools

# libatomic1
# https://packages.ubuntu.com/bionic/libatomic1

ATOMIC=./libatomic/libatomic.deb
if [ ! -f $ATOMIC ]; then
  mkdir -p libatomic
  echo "Downloading libatomic"
  curl -L http://mirrors.kernel.org/ubuntu/pool/main/g/gcc-8/libatomic1_8-20180414-1ubuntu2_amd64.deb -o $ATOMIC
  pushd libatomic
  ar -x libatomic.deb
  xz -d data.tar.xz
  tar -xf data.tar
  popd
  cp -R ./libatomic/usr/lib/x86_64-linux-gnu/. .
  curl -L http://changelogs.ubuntu.com/changelogs/pool/main/g/gcc-8/gcc-8_8-20180414-1ubuntu2/copyright -o libatomic.txt
else
  echo "Atomic exists"
fi

# llvm-nm
# http://releases.llvm.org/download.html

LLVM="llvm/llvm.tar.xz"
if [ ! -f "llvm/llvm.tar" ]; then
  mkdir -p llvm
  echo "Downloading llvm"
  curl -L https://github.com/llvm/llvm-project/releases/download/llvmorg-10.0.0/clang+llvm-10.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz -o $LLVM
  pushd llvm
  xz -d llvm.tar.xz
  tar -xf llvm.tar
  echo "Updating nm"
  cp clang+*/bin/llvm-nm ../nm
  cp clang+*/include/llvm/Support/LICENSE.TXT ../llvm.txt
  popd
else
  echo "LLVM exists"
fi

# swift-demangle
# https://swift.org/download/#releases

SWIFT="swift/swift.tar.gz"
if [ ! -f $SWIFT ]; then
  mkdir -p swift
  echo "Downloading swift"
  curl -L https://swift.org/builds/swift-5.2.2-release/ubuntu1804/swift-5.2.2-RELEASE/swift-5.2.2-RELEASE-ubuntu18.04.tar.gz -o $SWIFT
  pushd swift
  tar -xzf swift.tar.gz
  echo "Updating swift-demangle"
  cp swift-*/usr/bin/swift-demangle ../swift-demangle
  cp swift-*/usr/share/swift/LICENSE.TXT ../swift.txt
  popd
else
  echo "Swift exists"
fi
