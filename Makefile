ifeq ($(OS),Windows_NT)
	TARGET := bin2cs.exe
	RID := win-x64
else
	ifeq ($(OS),DARWIN)
		TARGET := bin2cs
		RID := osx-x64
	else
		TARGET := bin2cs
		RID := linux-x64
	endif
endif

FLAGS := publish -c Release -r
FLAGS2 := $(RID) --self-contained true /p:PublishSingleFile=true
COPY := bin2cs\bin\Release\net6.0
COPY2 := \$(RID)\publish\$(TARGET)

all: $(TARGET)
	
$(TARGET):
	cd bin2cs; dotnet $(FLAGS) $(FLAGS2)
	cp $(COPY)$(COPY2) $@

clean:
	rm -rf windows osx linux $(TARGET)

windows:
	cd bin2cs; dotnet $(FLAGS) win-x64 --self-contained true /p:PublishSingleFile=true
	mkdir -p $@
	cp $(COPY)\win-x64\publish\bin2cs.exe $@\bin2cs.exe

osx:
	cd bin2cs; dotnet $(FLAGS) $@-x64 --self-contained true /p:PublishSingleFile=true
	mkdir -p $@
	cp $(COPY)\$@-x64\publish\bin2cs $@\bin2cs

linux:
	cd bin2cs; dotnet $(FLAGS) $@-x64 --self-contained true /p:PublishSingleFile=true
	mkdir -p $@
	cp $(COPY)\$@-x64\publish\bin2cs $@\bin2cs

full: windows osx linux