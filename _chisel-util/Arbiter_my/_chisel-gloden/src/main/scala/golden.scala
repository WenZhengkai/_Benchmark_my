import chisel3.util._
import chisel3._

/** Arbiter Control determining which producer has access
  */
private object ArbiterCtrl_my {
  def apply(request: Seq[Bool]): Seq[Bool] = request.length match {
    case 0 => Seq()
    case 1 => Seq(true.B)
    case _ => true.B +: request.tail.init.scanLeft(request.head)(_ || _).map(!_)
  }
}

/** Hardware module that is used to sequence n producers into 1 consumer.
  * Priority is given to lower producer.
  *
  * @param gen data type
  * @param n number of inputs
  *
  * @example {{{
  * val arb = Module(new Arbiter(UInt(), 2))
  * arb.io.in(0) <> producer0.io.out
  * arb.io.in(1) <> producer1.io.out
  * consumer.io.in <> arb.io.out
  * }}}
  */
class Arbiter_my[T <: Data](val gen: T, val n: Int) extends Module {

  /** Give this Arbiter a default, stable desired name using the supplied `Data`
    * generator's `typeName` and input count parameter
    */
  override def desiredName = s"Arbiter${n}_" + gen.toString + "_golden"

  val io = IO(new ArbiterIO(gen, n))

  io.chosen := (n - 1).asUInt
  io.out.bits := io.in(n - 1).bits
  for (i <- n - 2 to 0 by -1) {
    when(io.in(i).valid) {
      io.chosen := i.asUInt
      io.out.bits := io.in(i).bits
    }
  }

  val grant = ArbiterCtrl_my(io.in.map(_.valid))
  for ((in, g) <- io.in.zip(grant))
    in.ready := g && io.out.ready
  io.out.valid := !grant.last || io.in.last.valid
}



object Driver extends App {
  println("Generating the Arbiter_my hardware")
  emitVerilog(new Arbiter_my(UInt(8.W),4), Array("--target-dir", "generated"))
}