//-----------------------------------------------------------------------------
//
// (c) Copyright 2010-2011 Xilinx, Inc. All rights reserved.
//
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
//
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
//
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
//
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
//
//-----------------------------------------------------------------------------
// Project    : Series-7 Integrated Block for PCI Express
// File       : cgator_cfg_rom.data
// Version    : 3.3
// Description : Configurator Configuration ROM contents - Binary data file
//               for defining Configurator Controller ROM Fields alternate -
//               even fields are control information, odd fields are data.
//               For control fields, Message TLPs and CfgRd/Wr TLPs have
//               different fields
//-----------------------------------------------------------------------------
//
//
// This example data file is for configuring a V-6 Endpoint with PIO design
// using the following configuration transactions:
//  1:  Send SET_SLOT_PWR_LIMIT message with value = 25 Watts
//  2:  Read from Device ID Reg to set Bus/Device to 1/0
//  3:  Write 0xFFFF_FFFF to BAR0
//  4:  Read back BAR0
//  5:  Write 0xFFFF_FFFF to BAR1
//  6:  Read back BAR1
//  7:  Write 0xFFFF_FFFF to BAR2
//  8:  Read back BAR2
//  9:  Write 0xFFFF_FFFF to Expansion ROM BAR
//  10: Read back Expansion ROM BAR
//  11: Write 0x8000_0000 to BAR0 (64-bit BAR, 31:0)
//  12: Write 0x1000_0000 to BAR1 (64-bit BAR, 63:32)
//  13: Write 0x2000_0000 to BAR2 (32-bit BAR)
//  14: Write 0x8000_0001 to Expansion ROM BAR
//  15: Write 0x0041 to Link Control Reg (Enable L0s and Common CLock)
//  16: Write 0x0006 to Command Reg (Enable Memory and Bus-master)
//
// Bit layout:
//   All TLPs:
//     Unused - bits 31-18
//     Type - bits 17-16: 00=CfgRd, 01=CfgWr, 10=Msg, 11=MsgD
//   Cfg TLPs:
//     Function Number (2 LSb) - bits 15-14
//     Register Number - bits 13-4
//     1DW BE - bits 3-0
//   Msg TLPs:
//     Unused - bits 15-11
//     Message Routing - bits 10-8
//     Message Code - bits 7-0
//     Payload Data - bits 31-0
//
// Unused        Type                                           - All TLPs (even)
// |-----------| ||
//                    Func  Register  1DW
//                    Num    Number    BE                       - Cfg TLPs (even)
//                    ||   |--------| |--|
//                                                Msg     Msg
//                                         Unused Routing Code  - Msg TLPs (even)
//                                         |---|  |-|     |------|
//  Payload Data
// |-------_--------_--------_-------|                          - All TLPs (odd)
//
//
// TLP #1 - SET_SLOT_PWR_LIMIT MsgD TLP - 25W
   0000000000000110000010001010000
   00000000000000000000000000011001  // Scale = 0 (1.0x), Data = 25
//
// TLP #2 - CfgRd from Device ID (sets Bus/Dev number) for Func 0
//
   0000000000000000000000000001111
   00000000000000000000000000000000  // Data unused
//
// TLP #3 - CfgWr to BAR0 - probe extents
//
   0000000000000010000000001001111 // DW Addr 4 = BAR0
   11111111111111111111111111111111  // Data = hFFFFFFFF
//
// TLP #4 - CfgRd from BAR0 (64-bit Mem)
//
   0000000000000000000000001001111 // DW Addr 4 = BAR0
   00000000000000000000000000000000  // Data unused
//
// TLP #5 - CfgWr to BAR1 - probe extents
//
   0000000000000010000000001011111 // DW Addr 5 = BAR1
   11111111111111111111111111111111  // Data = hFFFFFFFF
//
// TLP #6 - CfgRd from BAR1 (64-bit Mem)
//
   0000000000000000000000001011111 // DW Addr 5 = BAR1
   00000000000000000000000000000000  // Data unused
//
// TLP #7 - CfgWr to BAR2 - probe extents
//
   0000000000000010000000001101111 // DW Addr 6 = BAR2
   11111111111111111111111111111111  // Data = hFFFFFFFF
//
// TLP #8 - CfgRd from BAR2 (32-bit Mem)
//
   0000000000000000000000001101111 // DW Addr 6 = BAR2
   00000000000000000000000000000000  // Data unused
//
// TLP #9 - CfgWr to Expansion ROM BAR - probe extents
//
   0000000000000010000000011001111 // DW Addr 12 = Expansion ROM BAR
   11111111111111111111111111111111  // Data = hFFFFFFFF
//
// TLP #10 - CfgRd from Expansion ROM BAR
//
   0000000000000000000000011001111 // DW Addr 12 = Expansion ROM BAR
   00000000000000000000000000000000  // Data unused
//
// TLP #11 - CfgWr to BAR0 - assign base address h1000000080000000 to 64-bit BAR
//
   0000000000000010000000001001111 // DW Addr 4 = BAR0
   00000000000000000000000010000000  // Data = h00000080
//
// TLP #12 - CfgWr to BAR1 - write second half of 64-bit BAR
//
   0000000000000010000000001011111 // DW Addr 5 = BAR1
   00000000000000000000000000010000  // Data = h00000010
//
// TLP #13 - CfgWr to BAR2 - assign base address h20000000 to 32-bit Mem BAR
//
   0000000000000010000000001101111 // DW Addr 6 = BAR2
   00000000000000000000000000100000  // Data = h00000020
//
// TLP #14 - CfgWr to Expansion ROM BAR - assign base address h80000000 and enable
//
   0000000000000010000000011001111 // DW Addr 12 = Expansion ROM BAR
   00000001000000000000000010000000  // Data = h01000080
//
// TLP #15 - CfgWr to Link Ctl Reg - Enable ASPM L0s and Common Clock
//
   0000000000000010000000111000001 // DW Addr 28 = Link Control Reg
   01000001000000000000000000000000  // Data = h41000000
//
// TLP #16 - CfgWr to Command Reg - Enable IO, Mem, and Bus Master
//
   0000000000000010000000000010001 // DW Addr 1 = Command Reg
   00000110000000000000000000000000  // Data = h06000000

