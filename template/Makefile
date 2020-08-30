NVCC := nvcc
CFLAGS := -Wall -O2
CUDAFLAGS := 
DEBUG_FLAGS := -g -G
LDFLAGS :=
GEN_DEP_FLAGS :=

ifeq ($(OS), Windows_NT)
	GEN_DEP_FLAGS := -MD
else
	CFLAGS += -Wextra
	GEN_DEP_FLAGS := -MMD
endif

SRC_DIR := src
BIN_DIR := bin
PROJ_NAME := PROJ_NAME_PLACEHOLDER.exe
EXE_NAME := $(BIN_DIR)/$(PROJ_NAME)
OBJ_SUFX := 

ifeq ($(OS), Windows_NT)
	OBJ_SUFX := obj
else
	OBJ_SUFX := o
endif

C_SRCS := $(wildcard $(SRC_DIR)/*.c)
CUDA_SRCS := $(wildcard $(SRC_DIR)/*.cu)
C_OBJS := $(C_SRCS:$(SRC_DIR)/%.c=$(BIN_DIR)/%.$(OBJ_SUFX))
CUDA_OBJS := $(CUDA_SRCS:$(SRC_DIR)/%.cu=$(BIN_DIR)/%.$(OBJ_SUFX))

.PHONY: all
all: build

.PHONY: build
build: $(EXE_NAME)

.PHONY: run
run: build
	@echo "Running" $(EXE_NAME) "..."
	@echo
	@$(EXE_NAME)

.PHONY: clean
clean:
	rm -f $(EXE_NAME) $(C_OBJS) $(CUDA_OBJS) $(BIN_DIR)/*.d $(BIN_DIR)/*.pdb *.pdb

$(EXE_NAME): $(C_OBJS) $(CUDA_OBJS)
	@echo "Building" $(PROJ_NAME)
	@$(NVCC) $(CUDAFLAGS) $(DEBUG_FLAGS) $(LDFLAGS) $^ -o $@
	@echo $(PROJ_NAME)" successfully compiled"

$(C_OBJS): $(BIN_DIR)/%.$(OBJ_SUFX) : $(SRC_DIR)/%.c
	@echo "Compiling" $<
	@$(NVCC) $(CUDAFLAGS) $(DEBUG_FLAGS) $(GEN_DEP_FLAGS) -c $< -o $@
	@echo $< "successfully compiled"

$(CUDA_OBJS): $(BIN_DIR)/%.$(OBJ_SUFX) : $(SRC_DIR)/%.cu
	@echo "Compiling" $<
	@$(NVCC) $(CUDAFLAGS) $(DEBUG_FLAGS) $(GEN_DEP_FLAGS) -c $< -o $@
	@echo $< "successfully compiled"

