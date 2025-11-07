package demo

import chisel3._
import _root_.circt.stage.{ChiselStage}

class Counter(dataBits: Int) extends Module {
  val io = IO(new Bundle {
    val out = Output(UInt(dataBits.W))
  })

  val reg = RegInit(0.U(dataBits.W))
  reg := reg + 1.U
  io.out := reg
}

object EmitCounter extends App {
  ChiselStage.emitSystemVerilogFile(new Counter(3), args)
}
