Please write a function definition document for the following chisel code
## using following document format:
Module Name
Overview
Parameters
Input/Output Interface
Internal Logic(nature language)

## chisel code
``` scala
import chisel3._
import chisel3.util._
import scala.math.min

class Allocator(nWays: Int, tagSz: Int) extends Module {

  class MetaData(tagSize: Int) extends Bundle {
    val tag = UInt(tagSize.W)
  }

  val io = IO(new Bundle {
    val s1_req_rmeta = Input(Vec(nWays, Vec(nWays, new MetaData(tagSz))))  // Assuming a 2D vector input for rmeta
    val s1_req_tag = Input(UInt(tagSz.W))
    val s1_hits = Input(Vec(nWays, Bool()))
    val s1_meta_write_way = Output(UInt(log2Ceil(nWays).W))
  })

  val alloc_way = if (nWays > 1) {
    // Concatenate tags and create r_metas
    val r_metas = Cat(VecInit(io.s1_req_rmeta.map { w => Cat(w.map(_.tag)) }).asUInt, io.s1_req_tag(tagSz - 1, 0))
    val l = log2Ceil(nWays)
    val nChunks = (r_metas.getWidth + l - 1) / l
    val chunks = (0 until nChunks).map { i =>
      r_metas(min((i + 1) * l, r_metas.getWidth) - 1, i * l)
    }
    chunks.reduce(_ ^ _)
  } else {
    0.U
  }

  io.s1_meta_write_way := Mux(io.s1_hits.reduce(_ || _),
    PriorityEncoder(io.s1_hits.map(_.asUInt).reduce(_ | _)),
    alloc_way)
}


```