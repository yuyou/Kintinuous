FROM nvidia/cuda:8.0-devel-ubuntu16.04
MAINTAINER Yu You <youyu.youyu@gmail.com>

RUN apt-get update && apt-get install -y \
  cmake-qt-gui \
  git wget curl nano unzip \
  build-essential \
  libusb-1.0-0-dev \ 
  libudev-dev \
  freeglut3-dev \
  python-vtk \
  libvtk-java \
  libglew-dev  \
  libsuitesparse-dev \
  openexr \
  openjdk-8-jdk \
  doxygen \
  libopenni2-0 openni2-utils libopenni2-dev \
  libeigen3-dev \
  libflann-dev \
  libboost-all-dev \
  libqhull* \
  #libvtk5-dev \
  libvtk6-dev \
  libusb-dev \
  libvtk5.10-qt4 libvtk5.10 \
  libpcl-dev \
#  libvtk6.2 libvtk5-dev libqhull* libusb-dev libgtest-dev git-core freeglut3-dev 
  pkg-config libxmu-dev libxi-dev graphviz

RUN mkdir /opt && cd /opt

# PCL
#RUN git clone https://github.com/PointCloudLibrary/pcl.git && \
#cd pcl && \
#mkdir build && \
#cd build && \
#cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_GPU=OFF -DBUILD_apps=OFF -DBUILD_examples=OFF .. && \
#make -j8 && \
#make install && ldconfig && \
#rm -rf /opt/pcl

# ffmpeg
#RUN cd /opt && git clone git://source.ffmpeg.org/ffmpeg.git && \
#cd ffmpeg/ && \
#git reset --hard cee7acfcfc1bc806044ff35ff7ec7b64528f99b1 && \
#./configure --enable-shared && \
#make -j8 && make install && \
#ldconfig && \
#rm -rf /opt/ffmpeg

# OpenCV 2.4.9
RUN cd /opt && \
wget http://sourceforge.net/projects/opencvlibrary/files/opencv-unix/2.4.9/opencv-2.4.9.zip && \
unzip opencv-2.4.9.zip && \
rm opencv-2.4.9.zip && \
cd opencv-2.4.9 && \
mkdir build && \
cd build && \
cmake -D BUILD_NEW_PYTHON_SUPPORT=OFF -D WITH_OPENCL=OFF -D WITH_OPENMP=ON -D INSTALL_C_EXAMPLES=OFF -D BUILD_DOCS=OFF -D BUILD_EXAMPLES=OFF -D WITH_QT=OFF -D WITH_OPENGL=OFF -D WITH_VTK=OFF -D BUILD_PERF_TESTS=OFF -D BUILD_TESTS=OFF -D WITH_CUDA=OFF -D BUILD_opencv_gpu=OFF .. && \
make -j8 && \
make install && \
echo "/usr/local/lib" | tee -a /etc/ld.so.conf.d/opencv.conf && \
ldconfig && \
echo "PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig" | tee -a /etc/bash.bashrc && \
echo "export PKG_CONFIG_PATH" | tee -a /etc/bash.bashrc && \
source /etc/bash.bashrc && \
rm -rf /opt/opencv-2.4.9

#DLib for place recognition
RUN cd /opt && git clone https://github.com/dorian3d/DLib.git && \
cd DLib && \
git reset --hard 330bdc10576f6bcb55e0bd85cd5296f39ba8811a && \
mkdir build && \
cd build && \
cmake ../ && \
make -j8 && \
make install && \
rm -rf /opt/DLib

#DBoW2 for place recognition
RUN cd /opt && git clone https://github.com/dorian3d/DBoW2.git && \
cd DBoW2 && \
git reset --hard 4a6eed2b3ae35ed6837c8ba226b55b30faaf419d && \
mkdir build && \
cd build && \
cmake ../ && \
make -j8 && \
make install && \
rm -rf /opt/DBoW2

#DLoopDetector for place recognition
RUN cd /opt && git clone https://github.com/dorian3d/DLoopDetector.git && \
cd DLoopDetector && \
git reset --hard 84bfc56320371bed97cab8aad3aa9561ca931d3f && \
mkdir build && \
cd build && \
cmake ../ && \
make -j8 && \
make install && \
rm -rf /opt/DLoopDetector


#iSAM for pose graph optimisation
RUN cd /opt && wget http://people.csail.mit.edu/kaess/isam/isam_v1_7.tgz && \
tar -xvf isam_v1_7.tgz && \
rm isam_v1_7.tgz && \
cd isam_v1_7 && \
mkdir build && \
cd build && \
cmake .. && \
make -j8 && \
make install && \
rm -rf /opt/isam_v1_7

#
