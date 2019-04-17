#!/bin/bash
# build properties
JDK_UPDATE_VERSION=202
DISTRO_NAME=Dragonwell-Terwer
DISTRO_VERSION=8.0-preview

if [ $# != 1 ]; then
  echo "USAGE: $0 release/debug"
fi

LC_ALL=C
BUILD_MODE=$1

case "$BUILD_MODE" in
    release)
        DEBUG_LEVEL="release"
        JDK_IMAGES_DIR=`pwd`/build/linux-x86_64-normal-server-release/images
    ;;
    debug)
        DEBUG_LEVEL="slowdebug"
        JDK_IMAGES_DIR=`pwd`/build/linux-x86_64-normal-server-slowdebug/images
    ;;
    *)
        echo "Argument must be release or debug!"
        exit 1
    ;;
esac

NEW_JAVA_HOME=$JDK_IMAGES_DIR/j2sdk-image
NEW_JRE_HOME=$JDK_IMAGES_DIR/j2re-image

\rm -rf build

if [ -z "$BUILD_NUMBER" ]; then
  BUILD_INDEX=b00
else
  BUILD_INDEX=b$BUILD_NUMBER
fi

bash ./configure --with-boot-jdk=/opt/java/jdk1.7.0_80 \
				 --with-debug-level=slowdebug \
				 --with-native-debug-symbols=internal \
				 --with-jvm-variants=server \
				 --with-target-bits=64 \
				 --enable-ccache \
				 --with-num-cores=4 \
				 --with-memory-size=3000 \
				 --with-milestone=fcs \
                 --with-update-version=$JDK_UPDATE_VERSION \
                 --with-build-number=$BUILD_INDEX \
                 --with-user-release-suffix="" \
                 --enable-unlimited-crypto \
                 --with-jvm-variants=server \
                 --with-debug-level=$DEBUG_LEVEL \
                 --with-extra-cflags="-DVENDOR='\"Alibaba\"'                                         \
                                      -DVENDOR_URL='\"http://www.alibabagroup.com\"'                 \
                                      -DVENDOR_URL_BUG='\"mailto:dragonwell_use@googlegroups.com\"'"        \
                 --with-zlib=system \
                 --with-extra-ldflags="-Wl,--build-id=sha1"
make clean
make LOG=debug DISTRO_NAME=$DISTRO_NAME DISTRO_VERSION=$DISTRO_VERSION COMPANY_NAME=Alibaba images

# Sanity tests
JAVA_EXES=("$NEW_JAVA_HOME/bin/java" "$NEW_JAVA_HOME/jre/bin/java" "$NEW_JRE_HOME/bin/java")
VERSION_OPTS=("-version" "-Xinternalversion" "-fullversion")
for exe in "${JAVA_EXES[@]}"; do
  for opt in "${VERSION_OPTS[@]}"; do
    $exe $opt > /dev/null 2>&1
    if [ 0 -ne $? ]; then
      echo "Failed: $exe $opt"
      exit 128
    fi
  done
done

# Keep old output
$NEW_JAVA_HOME/bin/java -version

cat > /tmp/systemProperty.java << EOF
public class systemProperty {
    public static void main(String[] args) {
        System.getProperties().list(System.out);
    }
}
EOF

$NEW_JAVA_HOME/bin/javac /tmp/systemProperty.java
$NEW_JAVA_HOME/bin/java -cp /tmp/ systemProperty > /tmp/systemProperty.out

EXPECTED_PATTERN=('^java\.vm\.vendor\=.*Alibaba.*$'
                '^java\.vendor\.url\=http\:\/\/www\.alibabagroup\.com$'
                '^java\.vendor\=Alibaba$'
                '^java\.vendor\.url\.bug\=mailto\:dragonwell_use@googlegroups\.com$')
RET=0
for p in ${EXPECTED_PATTERN[*]}
do
    cat /tmp/systemProperty.out | grep "$p"
    if [ 0 != $? ]; then RET=1; fi
done

\rm -f /tmp/systemProperty*

# check version string
$NEW_JAVA_HOME/bin/java -version > /tmp/version.out 2>&1
grep "^OpenJDK Runtime" /tmp/version.out | grep "($DISTRO_NAME $DISTRO_VERSION)"
if [ 0 != $? ]; then RET=1; fi
grep "^OpenJDK .*VM" /tmp/version.out | grep "($DISTRO_NAME $DISTRO_VERSION)"
if [ 0 != $? ]; then RET=1; fi
\rm -f /tmp/version.out

ldd $NEW_JAVA_HOME/jre/lib/amd64/libzip.so|grep libz
if [ 0 != $? ]; then RET=1; fi

exit $RET

