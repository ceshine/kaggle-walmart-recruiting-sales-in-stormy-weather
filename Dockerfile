FROM ceshine/kaggle-env:py3

# File Author / Maintainer
MAINTAINER CeShine Lee "shuanck@gmail.com"

# Update the repository sources list
RUN apt-get update

# Install VW build prerequisites
RUN DEBIAN_FRONTEND=noninteractive apt-get -y -q install build-essential
RUN DEBIAN_FRONTEND=noninteractive apt-get -y -q install automake
RUN DEBIAN_FRONTEND=noninteractive apt-get -y -q install autoconf
RUN DEBIAN_FRONTEND=noninteractive apt-get -y -q install libxmu-dev
RUN DEBIAN_FRONTEND=noninteractive apt-get -y -q install gcc
RUN DEBIAN_FRONTEND=noninteractive apt-get -y -q install libpthread-stubs0-dev
RUN DEBIAN_FRONTEND=noninteractive apt-get -y -q install libtool
RUN DEBIAN_FRONTEND=noninteractive apt-get -y -q install libboost-program-options-dev
RUN DEBIAN_FRONTEND=noninteractive apt-get -y -q install libboost-python-dev
RUN DEBIAN_FRONTEND=noninteractive apt-get -y -q install zlib1g-dev
RUN DEBIAN_FRONTEND=noninteractive apt-get -y -q install libc6
RUN DEBIAN_FRONTEND=noninteractive apt-get -y -q install libgcc1
RUN DEBIAN_FRONTEND=noninteractive apt-get -y -q install libstdc++6

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q wget
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q curl

# Add /usr/local/lib to LD_LIBRARY_PATH
ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:/usr/local/lib

# Install and make vw (Vowpal Wabbit) and perf
RUN cd /usr/local/src;git clone https://github.com/JohnLangford/vowpal_wabbit
RUN cd /usr/local/src/vowpal_wabbit;git checkout tags/7.10;./autogen.sh;make;make test;make install
