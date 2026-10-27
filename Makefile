CXX ?= g++
CXXFLAGS = -std=c++17 -O2 -Wall -Wextra -g -fno-omit-frame-pointer
SRC = bench.cpp common.hpp map_book.hpp heap_book.hpp array_book.hpp workload.hpp verify.hpp

# asan + ubsan build for checking --verify, -fno-sanitize-recover so any ub report fails the run
ASAN_FLAGS = -std=c++17 -O1 -g -Wall -Wextra -Wpedantic -fno-omit-frame-pointer \
             -fsanitize=address,undefined -fno-sanitize-recover=all

bench: $(SRC)
	$(CXX) $(CXXFLAGS) -o bench bench.cpp

bench_asan: $(SRC)
	$(CXX) $(ASAN_FLAGS) -o bench_asan bench.cpp

verify: bench
	./bench --verify

test: verify

asan: bench_asan
	./bench_asan --verify

clean:
	rm -f bench bench_asan bench_presized perf.data perf.data.old

.PHONY: verify test asan clean
