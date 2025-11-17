#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wsign-compare"
#include <verilated.h>
#include <verilated_vcd_c.h>
#include "VCounter.h"
#pragma GCC diagnostic pop

#include <memory>

#include "gtest/gtest.h"

namespace {

class CounterTest : public testing::Test {};

TEST_F(CounterTest, count16) {
  auto contextp = std::make_unique<VerilatedContext>();
  std::unique_ptr<VCounter> dut = std::make_unique<VCounter>();

#ifdef WAVEON
  Verilated::traceEverOn(true);
  auto tfp = std::make_unique<VerilatedVcdC>();
  dut->trace(tfp.get(), 99);
  char const* waveFile = "wave.vcd";
  tfp->open(waveFile);
#endif

  auto clock_step = [&]() {
    for(int i=0;i<=1;++i){
      contextp->timeInc(1);
      dut->clock = i;
      dut->eval();
#ifdef WAVEON
      tfp.get()->dump(contextp->time());
#endif
    }
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

#ifdef WAVEON
  tfp->close();
#endif
  dut->final();
}

}  // namespace