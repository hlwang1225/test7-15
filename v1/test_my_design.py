# -*- coding: UTF-8 -*-


import cocotb
from cocotb.triggers import FallingEdge, Timer


async def generate_clock(dut,count):
    """Generate clock pulses."""

    for cycle in range(count):
        dut.sys_clk.value = 0
        await Timer(10, units="ns")
        dut.sys_clk.value = 1
        await Timer(10, units="ns")
        
async def reset_dut(dut):
    """sys_rst_n DUT"""
    
    dut.sys_rst_n.value = 0
    await generate_clock(dut,5)
    dut.sys_rst_n.value = 1
    
@cocotb.test()
async def my_first_test(dut):
    """Try accessing the design."""
    
    await reset_dut(dut)
    dut._log.debug("After reset")
    await cocotb.start(generate_clock(dut,1000000))  # run the clock "in the background"
   
    await Timer(1000000, units="ns")  # wait a bit
#    await RisingEdge(dut.sys_clk)  # wait for falling edge/"negedge"

    # dut._log.info("ctrl_1 is %s", dut.ctrl_1.value)
    # dut._log.info("ctrl_2 is %s", dut.ctrl_2.value)