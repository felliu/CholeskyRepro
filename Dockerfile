FROM archlinux:latest AS build_base
RUN pacman -Syu --noconfirm
WORKDIR /bench
COPY . .
# This is an interactive shell as a hack to be able to source the
# setvars.sh script from MKL in each shell.
SHELL ["/bin/bash", "-ci"]

RUN pacman -S --noconfirm base-devel cmake gcc intel-oneapi-mkl python python-pip vim nano

# Add the MKL variables script to bashrc so it's sourced in each command below.
RUN echo "source /opt/intel/oneapi/setvars.sh" >> ~/.bashrc
RUN python3 -m pip install --user matplotlib numpy

RUN mkdir -p /bench/BandCholesky/build
# Move to the build directory
WORKDIR /bench/BandCholesky/build
RUN cmake -DBLA_VENDOR=Intel10_64lp_seq -DCMAKE_BUILD_TYPE=Release -DBC_USE_IOMP=TRUE ..
RUN make -j4

RUN mkdir -p /bench/BandCholesky/build_mkl
WORKDIR /bench/BandCholesky/build_mkl
RUN cmake -DBLA_VENDOR=Intel10_64lp -DCMAKE_BUILD_TYPE=Release -DBC_USE_IOMP=TRUE ..
RUN make -j4

#reset the working directory
WORKDIR /bench

RUN chmod +x /bench/run_benchmarks.bash

CMD ["/bench/run_benchmarks.bash"]
