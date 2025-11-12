#include <verilated.h>
#include <verilated_vcd_c.h>

#include <memory>

#include "VCounter.h"
#include "gtest/gtest.h"

namespace {

class CounterTest : public testing::Test {};

TEST_F(CounterTest, count16) {
  std::unique_ptr<VCounter> dut = std::make_unique<VCounter>();
  auto clock_step = [&dut]() {
    dut->clock = 0;
    dut->eval();
    dut->clock = 1;
    dut->eval();
  };
  // reset
  dut->reset = 1;
  for(int i=0;i<10;++i) clock_step();
  // test
  dut->reset = 0;
  for(int i=1;i<=16;++i){
    
    clock_step();
    dut->eval();
    EXPECT_EQ(int(dut->io_out), i%(1<<3));
  }
}

}  // namespace