CFLAGS += -I$(PWD)/src
CFLAGS += -I./third_party/hisi/include
CFLAGS += -L./third_party/hisi/lib

CXXFLAGS += -I$(PWD)/src
CXXFLAGS += -I./third_party/hisi/include
CXXFLAGS += -I./third_party/opencv4/include/opencv4
CXXFLAGS += -L./third_party/opencv4/lib
CXXFLAGS += -L./third_party/hisi/lib
LD_OPENCV_LIBS += -lopencv_highgui -lopencv_imgproc -lopencv_video -lopencv_videoio -lopencv_dnn -lopencv_ml -lopencv_photo \
			-lopencv_objdetect -lopencv_stitching -lopencv_flann -lopencv_imgcodecs -lopencv_gapi -lopencv_core -lopencv_calib3d \
			-lopencv_features2d

LD_HISI_LIBS +=  -laacdec -laacenc -ldetail_ap \
-ldnvqe -ldpu_match -ldpu_rect -ldsp -lhdmi -lhdr_ap -lhi_cipher -lhiavslut -lhifisheyecalibrate \
-live -lmd -lmfnr_ap -lmpi -lmpi_photo -lpciv\
-lpos_query -lsecurec -lsfnr_ap -lsvpruntime -ltde -lupvqe -lVoiceEngine -lnnie

CXXFLAGS += ${LD_OPENCV_LIBS}
CXXFLAGS += -std=c++11
CXXFLAGS += -Wno-error
CXXFLAGS += -fomit-frame-pointer -fstrict-aliasing -ffunction-sections -fdata-sections -ffast-math -fno-rtti -fno-exceptions -fpermissive
CXXFLAGS += -O3

SRCS := $(wildcard ./src/*.c)
TARGET := sample_nnie_main

# target source

OBJS  = $(SRCS:%.c=%.o)

CXX = aarch64-himix100-linux-g++
CC = aarch64-himix100-linux-gcc
.PHONY : clean all

all: $(TARGET)

$(TARGET):  ./sample/sample_nnie_main.o ./src/ins_nnie_interface.o $(OBJS) 
	$(CXX) $(CXXFLAGS)  -lpthread -lm -ldl -o $@ $^ -Wl,--start-group ${LD_HISI_LIBS} -Wl,--end-group

clean:
	@rm -f $(TARGET) ./sample/sample_nnie_main.o ./src/ins_nnie_interface.o ./src/util.o
	@rm -f $(OBJS)
