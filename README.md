`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 29.04.2025 23:38:47
// Design Name:
// Module Name: tb_pcie
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////


module tb_pcie ();

  // PIPE bağlayıcıları ve ortak sinyaller için eklenecek bölüm:

  // Clock & Reset
  logic sys_clk;
  logic sys_rst_n;

  // PIPE bağlantı sinyalleri (örnek: x4 için 4 lane)
  logic [3:0] rp_pci_exp_txp;
  logic [3:0] rp_pci_exp_txn;
  logic [3:0] rp_pci_exp_rxp;
  logic [3:0] rp_pci_exp_rxn;

  logic [3:0] ep_pci_exp_txp;
  logic [3:0] ep_pci_exp_txn;
  logic [3:0] ep_pci_exp_rxp;
  logic [3:0] ep_pci_exp_rxn;

  // PIPE interconnect (çapraz bağla)
  assign rp_pci_exp_rxp = ep_pci_exp_txp;
  assign rp_pci_exp_rxn = ep_pci_exp_txn;
  assign ep_pci_exp_rxp = rp_pci_exp_txp;
  assign ep_pci_exp_rxn = rp_pci_exp_txn;

  // Clock üretici
  initial begin
    sys_clk = 0;
    forever #2 sys_clk = ~sys_clk;  // 250MHz için 4ns periyot
  end

  // Reset
  initial begin
    sys_rst_n = 0;
    #100 sys_rst_n = 1;
  end

  logic user_clk_out_ep;
  logic user_reset_out_ep;
  logic user_lnk_up_ep;
  logic user_app_rdy_ep;
  logic [5 : 0] tx_buf_av_ep;
  logic tx_cfg_req_ep;
  logic tx_err_drop_ep;
  logic s_axis_tx_tready_ep;
  logic [63 : 0] s_axis_tx_tdata_ep;
  logic [7 : 0] s_axis_tx_tkeep_ep;
  logic s_axis_tx_tlast_ep;
  logic s_axis_tx_tvalid_ep;
  logic [3 : 0] s_axis_tx_tuser_ep;
  logic tx_cfg_gnt_ep;
  logic [63 : 0] m_axis_rx_tdata_ep;
  logic [7 : 0] m_axis_rx_tkeep_ep;
  logic m_axis_rx_tlast_ep;
  logic m_axis_rx_tvalid_ep;
  logic m_axis_rx_tready_ep;
  logic [21 : 0] m_axis_rx_tuser_ep;
  logic rx_np_ok_ep;
  logic rx_np_req_ep;
  logic [11 : 0] fc_cpld_ep;
  logic [7 : 0] fc_cplh_ep;
  logic [11 : 0] fc_npd_ep;
  logic [7 : 0] fc_nph_ep;
  logic [11 : 0] fc_pd_ep;
  logic [7 : 0] fc_ph_ep;
  logic [2 : 0] fc_sel_ep;
  logic [31 : 0] cfg_mgmt_do_ep;
  logic cfg_mgmt_rd_wr_done_ep;
  logic [15 : 0] cfg_status_ep;
  logic [15 : 0] cfg_command_ep;
  logic [15 : 0] cfg_dstatus_ep;
  logic [15 : 0] cfg_dcommand_ep;
  logic [15 : 0] cfg_lstatus_ep;
  logic [15 : 0] cfg_lcommand_ep;
  logic [15 : 0] cfg_dcommand2_ep;
  logic [2 : 0] cfg_pcie_link_state_ep;
  logic cfg_pmcsr_pme_en_ep;
  logic [1 : 0] cfg_pmcsr_powerstate_ep;
  logic cfg_pmcsr_pme_status_ep;
  logic cfg_received_func_lvl_rst_ep;
  logic [31 : 0] cfg_mgmt_di_ep;
  logic [3 : 0] cfg_mgmt_byte_en_ep;
  logic [9 : 0] cfg_mgmt_dwaddr_ep;
  logic cfg_mgmt_wr_en_ep;
  logic cfg_mgmt_rd_en_ep;
  logic cfg_mgmt_wr_readonly_ep;
  logic cfg_err_ecrc_ep;
  logic cfg_err_ur_ep;
  logic cfg_err_cpl_timeout_ep;
  logic cfg_err_cpl_unexpect_ep;
  logic cfg_err_cpl_abort_ep;
  logic cfg_err_posted_ep;
  logic cfg_err_cor_ep;
  logic cfg_err_atomic_egress_blocked_ep;
  logic cfg_err_internal_cor_ep;
  logic cfg_err_malformed_ep;
  logic cfg_err_mc_blocked_ep;
  logic cfg_err_poisoned_ep;
  logic cfg_err_norecovery_ep;
  logic [47 : 0] cfg_err_tlp_cpl_header_ep;
  logic cfg_err_cpl_rdy_ep;
  logic cfg_err_locked_ep;
  logic cfg_err_acs_ep;
  logic cfg_err_internal_uncor_ep;
  logic cfg_trn_pending_ep;
  logic cfg_pm_halt_aspm_l0s_ep;
  logic cfg_pm_halt_aspm_l1_ep;
  logic cfg_pm_force_state_en_ep;
  logic [1 : 0] cfg_pm_force_state_ep;
  logic [63 : 0] cfg_dsn_ep;
  logic cfg_interrupt_ep;
  logic cfg_interrupt_rdy_ep;
  logic cfg_interrupt_assert_ep;
  logic [7 : 0] cfg_interrupt_di_ep;
  logic [7 : 0] cfg_interrupt_do_ep;
  logic [2 : 0] cfg_interrupt_mmenable_ep;
  logic cfg_interrupt_msienable_ep;
  logic cfg_interrupt_msixenable_ep;
  logic cfg_interrupt_msixfm_ep;
  logic cfg_interrupt_stat_ep;
  logic [4 : 0] cfg_pciecap_interrupt_msgnum_ep;
  logic cfg_to_turnoff_ep;
  logic cfg_turnoff_ok_ep;
  logic [7 : 0] cfg_bus_number_ep;
  logic [4 : 0] cfg_device_number_ep;
  logic [2 : 0] cfg_function_number_ep;
  logic cfg_pm_wake_ep;
  logic cfg_pm_send_pme_to_ep;
  logic [7 : 0] cfg_ds_bus_number_ep;
  logic [4 : 0] cfg_ds_device_number_ep;
  logic [2 : 0] cfg_ds_function_number_ep;
  logic cfg_mgmt_wr_rw1c_as_rw_ep;
  logic cfg_msg_received_ep;
  logic [15 : 0] cfg_msg_data_ep;
  logic cfg_bridge_serr_en_ep;
  logic cfg_slot_control_electromech_il_ctl_pulse_ep;
  logic cfg_root_control_syserr_corr_err_en_ep;
  logic cfg_root_control_syserr_non_fatal_err_en_ep;
  logic cfg_root_control_syserr_fatal_err_en_ep;
  logic cfg_root_control_pme_int_en_ep;
  logic cfg_aer_rooterr_corr_err_reporting_en_ep;
  logic cfg_aer_rooterr_non_fatal_err_reporting_en_ep;
  logic cfg_aer_rooterr_fatal_err_reporting_en_ep;
  logic cfg_aer_rooterr_corr_err_received_ep;
  logic cfg_aer_rooterr_non_fatal_err_received_ep;
  logic cfg_aer_rooterr_fatal_err_received_ep;
  logic cfg_msg_received_err_cor_ep;
  logic cfg_msg_received_err_non_fatal_ep;
  logic cfg_msg_received_err_fatal_ep;
  logic cfg_msg_received_pm_as_nak_ep;
  logic cfg_msg_received_pm_pme_ep;
  logic cfg_msg_received_pme_to_ack_ep;
  logic cfg_msg_received_assert_int_a_ep;
  logic cfg_msg_received_assert_int_b_ep;
  logic cfg_msg_received_assert_int_c_ep;
  logic cfg_msg_received_assert_int_d_ep;
  logic cfg_msg_received_deassert_int_a_ep;
  logic cfg_msg_received_deassert_int_b_ep;
  logic cfg_msg_received_deassert_int_c_ep;
  logic cfg_msg_received_deassert_int_d_ep;
  logic cfg_msg_received_setslotpowerlimit_ep;
  logic [1 : 0] pl_directed_link_change_ep;
  logic [1 : 0] pl_directed_link_width_ep;
  logic pl_directed_link_speed_ep;
  logic pl_directed_link_auton_ep;
  logic pl_upstream_prefer_deemph_ep;
  logic pl_sel_lnk_rate_ep;
  logic [1 : 0] pl_sel_lnk_width_ep;
  logic [5 : 0] pl_ltssm_state_ep;
  logic [1 : 0] pl_lane_reversal_mode_ep;
  logic pl_phy_lnk_up_ep;
  logic [2 : 0] pl_tx_pm_state_ep;
  logic [1 : 0] pl_rx_pm_state_ep;
  logic pl_link_upcfg_cap_ep;
  logic pl_link_gen2_cap_ep;
  logic pl_link_partner_gen2_supported_ep;
  logic [2 : 0] pl_initial_link_width_ep;
  logic pl_directed_change_done_ep;
  logic pl_received_hot_rst_ep;
  logic pl_transmit_hot_rst_ep;
  logic pl_downstream_deemph_source_ep;
  logic [127 : 0] cfg_err_aer_headerlog_ep;
  logic [4 : 0] cfg_aer_interrupt_msgnum_ep;
  logic cfg_err_aer_headerlog_set_ep;
  logic cfg_aer_ecrc_check_en_ep;
  logic cfg_aer_ecrc_gen_en_ep;
  logic [6 : 0] cfg_vc_tcvc_map_ep;

  logic user_clk_out_rp;
  logic user_reset_out_rp;
  logic user_lnk_up_rp;
  logic user_app_rdy_rp;
  logic [5 : 0] tx_buf_av_rp;
  logic tx_cfg_req_rp;
  logic tx_err_drop_rp;
  logic s_axis_tx_tready_rp;
  logic [63 : 0] s_axis_tx_tdata_rp;
  logic [7 : 0] s_axis_tx_tkeep_rp;
  logic s_axis_tx_tlast_rp;
  logic s_axis_tx_tvalid_rp;
  logic [3 : 0] s_axis_tx_tuser_rp;
  logic tx_cfg_gnt_rp;
  logic [63 : 0] m_axis_rx_tdata_rp;
  logic [7 : 0] m_axis_rx_tkeep_rp;
  logic m_axis_rx_tlast_rp;
  logic m_axis_rx_tvalid_rp;
  logic m_axis_rx_tready_rp;
  logic [21 : 0] m_axis_rx_tuser_rp;
  logic rx_np_ok_rp;
  logic rx_np_req_rp;
  logic [11 : 0] fc_cpld_rp;
  logic [7 : 0] fc_cplh_rp;
  logic [11 : 0] fc_npd_rp;
  logic [7 : 0] fc_nph_rp;
  logic [11 : 0] fc_pd_rp;
  logic [7 : 0] fc_ph_rp;
  logic [2 : 0] fc_sel_rp;
  logic [31 : 0] cfg_mgmt_do_rp;
  logic cfg_mgmt_rd_wr_done_rp;
  logic [15 : 0] cfg_status_rp;
  logic [15 : 0] cfg_command_rp;
  logic [15 : 0] cfg_dstatus_rp;
  logic [15 : 0] cfg_dcommand_rp;
  logic [15 : 0] cfg_lstatus_rp;
  logic [15 : 0] cfg_lcommand_rp;
  logic [15 : 0] cfg_dcommand2_rp;
  logic [2 : 0] cfg_pcie_link_state_rp;
  logic cfg_pmcsr_pme_en_rp;
  logic [1 : 0] cfg_pmcsr_powerstate_rp;
  logic cfg_pmcsr_pme_status_rp;
  logic cfg_received_func_lvl_rst_rp;
  logic [31 : 0] cfg_mgmt_di_rp;
  logic [3 : 0] cfg_mgmt_byte_en_rp;
  logic [9 : 0] cfg_mgmt_dwaddr_rp;
  logic cfg_mgmt_wr_en_rp;
  logic cfg_mgmt_rd_en_rp;
  logic cfg_mgmt_wr_readonly_rp;
  logic cfg_err_ecrc_rp;
  logic cfg_err_ur_rp;
  logic cfg_err_cpl_timeout_rp;
  logic cfg_err_cpl_unexpect_rp;
  logic cfg_err_cpl_abort_rp;
  logic cfg_err_posted_rp;
  logic cfg_err_cor_rp;
  logic cfg_err_atomic_egress_blocked_rp;
  logic cfg_err_internal_cor_rp;
  logic cfg_err_malformed_rp;
  logic cfg_err_mc_blocked_rp;
  logic cfg_err_poisoned_rp;
  logic cfg_err_norecovery_rp;
  logic [47 : 0] cfg_err_tlp_cpl_header_rp;
  logic cfg_err_cpl_rdy_rp;
  logic cfg_err_locked_rp;
  logic cfg_err_acs_rp;
  logic cfg_err_internal_uncor_rp;
  logic cfg_trn_pending_rp;
  logic cfg_pm_halt_aspm_l0s_rp;
  logic cfg_pm_halt_aspm_l1_rp;
  logic cfg_pm_force_state_en_rp;
  logic [1 : 0] cfg_pm_force_state_rp;
  logic [63 : 0] cfg_dsn_rp;
  logic cfg_interrupt_rp;
  logic cfg_interrupt_rdy_rp;
  logic cfg_interrupt_assert_rp;
  logic [7 : 0] cfg_interrupt_di_rp;
  logic [7 : 0] cfg_interrupt_do_rp;
  logic [2 : 0] cfg_interrupt_mmenable_rp;
  logic cfg_interrupt_msienable_rp;
  logic cfg_interrupt_msixenable_rp;
  logic cfg_interrupt_msixfm_rp;
  logic cfg_interrupt_stat_rp;
  logic [4 : 0] cfg_pciecap_interrupt_msgnum_rp;
  logic cfg_to_turnoff_rp;
  logic cfg_turnoff_ok_rp;
  logic [7 : 0] cfg_bus_number_rp;
  logic [4 : 0] cfg_device_number_rp;
  logic [2 : 0] cfg_function_number_rp;
  logic cfg_pm_wake_rp;
  logic cfg_pm_send_pme_to_rp;
  logic [7 : 0] cfg_ds_bus_number_rp;
  logic [4 : 0] cfg_ds_device_number_rp;
  logic [2 : 0] cfg_ds_function_number_rp;
  logic cfg_mgmt_wr_rw1c_as_rw_rp;
  logic cfg_msg_received_rp;
  logic [15 : 0] cfg_msg_data_rp;
  logic cfg_bridge_serr_en_rp;
  logic cfg_slot_control_electromech_il_ctl_pulse_rp;
  logic cfg_root_control_syserr_corr_err_en_rp;
  logic cfg_root_control_syserr_non_fatal_err_en_rp;
  logic cfg_root_control_syserr_fatal_err_en_rp;
  logic cfg_root_control_pme_int_en_rp;
  logic cfg_aer_rooterr_corr_err_reporting_en_rp;
  logic cfg_aer_rooterr_non_fatal_err_reporting_en_rp;
  logic cfg_aer_rooterr_fatal_err_reporting_en_rp;
  logic cfg_aer_rooterr_corr_err_received_rp;
  logic cfg_aer_rooterr_non_fatal_err_received_rp;
  logic cfg_aer_rooterr_fatal_err_received_rp;
  logic cfg_msg_received_err_cor_rp;
  logic cfg_msg_received_err_non_fatal_rp;
  logic cfg_msg_received_err_fatal_rp;
  logic cfg_msg_received_pm_as_nak_rp;
  logic cfg_msg_received_pm_pme_rp;
  logic cfg_msg_received_pme_to_ack_rp;
  logic cfg_msg_received_assert_int_a_rp;
  logic cfg_msg_received_assert_int_b_rp;
  logic cfg_msg_received_assert_int_c_rp;
  logic cfg_msg_received_assert_int_d_rp;
  logic cfg_msg_received_deassert_int_a_rp;
  logic cfg_msg_received_deassert_int_b_rp;
  logic cfg_msg_received_deassert_int_c_rp;
  logic cfg_msg_received_deassert_int_d_rp;
  logic cfg_msg_received_setslotpowerlimit_rp;
  logic [1 : 0] pl_directed_link_change_rp;
  logic [1 : 0] pl_directed_link_width_rp;
  logic pl_directed_link_speed_rp;
  logic pl_directed_link_auton_rp;
  logic pl_upstream_prefer_deemph_rp;
  logic pl_sel_lnk_rate_rp;
  logic [1 : 0] pl_sel_lnk_width_rp;
  logic [5 : 0] pl_ltssm_state_rp;
  logic [1 : 0] pl_lane_reversal_mode_rp;
  logic pl_phy_lnk_up_rp;
  logic [2 : 0] pl_tx_pm_state_rp;
  logic [1 : 0] pl_rx_pm_state_rp;
  logic pl_link_upcfg_cap_rp;
  logic pl_link_gen2_cap_rp;
  logic pl_link_partner_gen2_supported_rp;
  logic [2 : 0] pl_initial_link_width_rp;
  logic pl_directed_change_done_rp;
  logic pl_received_hot_rst_rp;
  logic pl_transmit_hot_rst_rp;
  logic pl_downstream_deemph_source_rp;
  logic [127 : 0] cfg_err_aer_headerlog_rp;
  logic [4 : 0] cfg_aer_interrupt_msgnum_rp;
  logic cfg_err_aer_headerlog_set_rp;
  logic cfg_aer_ecrc_check_en_rp;
  logic cfg_aer_ecrc_gen_en_rp;
  logic [6 : 0] cfg_vc_tcvc_map_rp;


  // Basit test: link up kontrolü ve yazma işlemi
  initial begin

    // SYSTEM_INITIALIZATION
    // 1- Wait transaction reset
    // 2- Wait for transaction link up
    // 3- Wait for link speed change and done
    //  // SYSTEM_CONFIGURATION_CHECK
    //  // 4- T0 Configuration read and wait read answer
    //  // 5- Check read data if DATA[19:16] == 1 -> 2.5 GT else 5.0 GT
    //  // 6- Check read data if DATA[23:20] == 4'h4 link width
    //  // 7- T0 Configuration read and wait read answer
    //  // 8- Check read data if Device/Vendor ID DATA[31:16] != 16'h7024 failed
    //  // 9- T0 Configuration read and wait read answer
    //  // 10 - Check read data if CMPS ID DATA[2:0] != 3'd2 failed
    //  // 11 - System Check passed
    //  //  // TSK_BAR_INIT
    //  //  //  // TSK_BAR_SCAN
    //  //  //  // 12 - T0 Configuration write
    //  //  //  // 13 - Determine Range for BAR0
    //  //  //  // 14 - T0 Configuration read and wait read answer
    //  //  //  // 15 - T0 Configuration read and wait read answer
    //  //  //  // 16 - Read BAR0 Range
    //  //  //  // 17 - 18 - 19 - 20 - 21 BAR 1
    //  //  //  // 21 - 22 - 23 - 24 - 21 BAR 2
    //  //  //  // 25 - 26 - 27 - 28 - 21 BAR 3
    //  //  //  // 17 - 29 - 30 - 31 - 32 BAR 4
    //  //  //  // 17 - 33 - 34 - 35 - 36 BAR 5
    //  //  //  // 17 - 37 - 38 - 39 - 40 ROM bar
    //  //  //  // Builde PCIE Map
    //  //  //  // TSK_BAR_PROGRAM PCIE Map

    automatic logic [31:0] dw0;
    automatic logic [31:0] dw1;
    automatic logic [31:0] dw2;
    automatic logic [31:0] payload;
    automatic logic [ 7:0] tag;

    m_axis_rx_tready_rp <= #(1) 1;
    s_axis_tx_tvalid_rp <= #(1) 0;
    s_axis_tx_tlast_rp <= #(1) 0;
    s_axis_tx_tkeep_rp <= #(1) 8'h00;
    s_axis_tx_tuser_rp <= #(1) 4'd4;
    s_axis_tx_tdata_rp <= #(1) 64'h0;

    m_axis_rx_tready_ep <= #(1) 1;
    s_axis_tx_tvalid_ep <= #(1) 0;
    s_axis_tx_tlast_ep <= #(1) 0;
    s_axis_tx_tkeep_ep <= #(1) 8'hff;
    s_axis_tx_tuser_ep <= #(1) 4'b0000;
    s_axis_tx_tdata_ep <= #(1) 64'h0;

    wait (pcie_ep_inst.user_lnk_up && pcie_rp_inst.user_lnk_up);

    $display("✅ PCIe Link is UP at time %t", $time);

    repeat (1000) @(posedge user_clk_out_rp);

    // Burada AXI-ST üzerinden TLP göndereceğiz

    // Basit TLP: Memory Write - 1 double word (64-bit)
    // TLP Format: 3DW Header, 1 DW Data
    // Format: {fmt, type, traffic class, td, ep, attr, length, requester ID, tag, address, data}

    // Link up sonrası yazma okuma işlemi


    // 1- Read Address 0x0 (Device ID - Vendor ID)
    s_axis_tx_tuser_rp <= #(1) 4'd0;
    s_axis_tx_tdata_rp <= #(1) 64'h01af_000f_0400_0001;
    s_axis_tx_tkeep_rp <= #(1) 8'hff;
    s_axis_tx_tlast_rp <= #(1) 0;
    s_axis_tx_tvalid_rp <= #(1) 1;
    @(posedge user_clk_out_rp);
    s_axis_tx_tdata_rp <= #(1) 64'h0000_0000_01a0_0070;
    s_axis_tx_tkeep_rp <= #(1) 8'h0f;
    s_axis_tx_tlast_rp <= #(1) 1;
    @(posedge user_clk_out_rp);
    s_axis_tx_tvalid_rp <= #(1) 0;
    s_axis_tx_tkeep_rp <= #(1) 8'h00;
    s_axis_tx_tlast_rp <= #(1) 0;
    repeat (200) @(posedge user_clk_out_rp);

    s_axis_tx_tuser_rp <= #(1) 4'd0;
    s_axis_tx_tdata_rp <= #(1) 64'h01af_000f_0400_0001;
    s_axis_tx_tkeep_rp <= #(1) 8'hff;
    s_axis_tx_tlast_rp <= #(1) 0;
    s_axis_tx_tvalid_rp <= #(1) 1;
    @(posedge user_clk_out_rp);
    s_axis_tx_tdata_rp <= #(1) 64'h0000_0000_01a0_0000;
    s_axis_tx_tkeep_rp <= #(1) 8'h0f;
    s_axis_tx_tlast_rp <= #(1) 1;
    @(posedge user_clk_out_rp);
    s_axis_tx_tvalid_rp <= #(1) 0;
    s_axis_tx_tkeep_rp <= #(1) 8'h00;
    s_axis_tx_tlast_rp <= #(1) 0;
    repeat (200) @(posedge user_clk_out_rp);



    s_axis_tx_tuser_rp <= #(1) 4'd0;
    s_axis_tx_tdata_rp <= #(1) 64'h01af_000f_0400_0001;
    s_axis_tx_tkeep_rp <= #(1) 8'hff;
    s_axis_tx_tlast_rp <= #(1) 0;
    s_axis_tx_tvalid_rp <= #(1) 1;
    @(posedge user_clk_out_rp);
    s_axis_tx_tdata_rp <= #(1) 64'h0000_0000_01a0_0064;
    s_axis_tx_tkeep_rp <= #(1) 8'h0f;
    s_axis_tx_tlast_rp <= #(1) 1;
    @(posedge user_clk_out_rp);
    s_axis_tx_tvalid_rp <= #(1) 0;
    s_axis_tx_tkeep_rp <= #(1) 8'h00;
    s_axis_tx_tlast_rp <= #(1) 0;
    repeat (200) @(posedge user_clk_out_rp);

    s_axis_tx_tuser_rp <= #(1) 4'd0;
    s_axis_tx_tdata_rp <= #(1) 64'h01af_000f_4400_0001;
    s_axis_tx_tkeep_rp <= #(1) 8'hff;
    s_axis_tx_tlast_rp <= #(1) 0;
    s_axis_tx_tvalid_rp <= #(1) 1;
    @(posedge user_clk_out_rp);
    s_axis_tx_tdata_rp <= #(1) 64'hffff_ffff_01a0_0010;
    s_axis_tx_tkeep_rp <= #(1) 8'hff;
    s_axis_tx_tlast_rp <= #(1) 1;
    @(posedge user_clk_out_rp);
    s_axis_tx_tvalid_rp <= #(1) 0;
    s_axis_tx_tkeep_rp <= #(1) 8'h00;
    s_axis_tx_tlast_rp <= #(1) 0;
    repeat (200) @(posedge user_clk_out_rp);


    s_axis_tx_tuser_rp <= #(1) 4'd0;
    s_axis_tx_tdata_rp <= #(1) 64'h01af_010f_0400_0001;
    s_axis_tx_tkeep_rp <= #(1) 8'hff;
    s_axis_tx_tlast_rp <= #(1) 0;
    s_axis_tx_tvalid_rp <= #(1) 1;
    @(posedge user_clk_out_rp);
    s_axis_tx_tdata_rp <= #(1) 64'h0000_0000_01a0_0010;
    s_axis_tx_tkeep_rp <= #(1) 8'h0f;
    s_axis_tx_tlast_rp <= #(1) 1;
    @(posedge user_clk_out_rp);
    s_axis_tx_tvalid_rp <= #(1) 0;
    s_axis_tx_tkeep_rp <= #(1) 8'h00;
    s_axis_tx_tlast_rp <= #(1) 0;
    repeat (200) @(posedge user_clk_out_rp);

    s_axis_tx_tuser_rp <= #(1) 4'd0;
    s_axis_tx_tdata_rp <= #(1) 64'h01af_020f_4400_0001;
    s_axis_tx_tkeep_rp <= #(1) 8'hff;
    s_axis_tx_tlast_rp <= #(1) 0;
    s_axis_tx_tvalid_rp <= #(1) 1;
    @(posedge user_clk_out_rp);
    s_axis_tx_tdata_rp <= #(1) 64'hffff_ffff_01a0_0014;
    s_axis_tx_tkeep_rp <= #(1) 8'hff;
    s_axis_tx_tlast_rp <= #(1) 1;
    @(posedge user_clk_out_rp);
    s_axis_tx_tvalid_rp <= #(1) 0;
    s_axis_tx_tkeep_rp <= #(1) 8'h00;
    s_axis_tx_tlast_rp <= #(1) 0;
    repeat (200) @(posedge user_clk_out_rp);

    s_axis_tx_tuser_rp <= #(1) 4'd0;
    s_axis_tx_tdata_rp <= #(1) 64'h01af_030f_0400_0001;
    s_axis_tx_tkeep_rp <= #(1) 8'hff;
    s_axis_tx_tlast_rp <= #(1) 0;
    s_axis_tx_tvalid_rp <= #(1) 1;
    @(posedge user_clk_out_rp);
    s_axis_tx_tdata_rp <= #(1) 64'h0000_0000_01a0_0014;
    s_axis_tx_tkeep_rp <= #(1) 8'h0f;
    s_axis_tx_tlast_rp <= #(1) 1;
    @(posedge user_clk_out_rp);
    s_axis_tx_tvalid_rp <= #(1) 0;
    s_axis_tx_tkeep_rp <= #(1) 8'h00;
    s_axis_tx_tlast_rp <= #(1) 0;
    repeat (200) @(posedge user_clk_out_rp);



    s_axis_tx_tuser_rp <= #(1) 4'd0;
    s_axis_tx_tdata_rp <= #(1) 64'h01af_040f_4400_0001;
    s_axis_tx_tkeep_rp <= #(1) 8'hff;
    s_axis_tx_tlast_rp <= #(1) 0;
    s_axis_tx_tvalid_rp <= #(1) 1;
    @(posedge user_clk_out_rp);
    s_axis_tx_tdata_rp <= #(1) 64'hffff_ffff_01a0_0018;
    s_axis_tx_tkeep_rp <= #(1) 8'hff;
    s_axis_tx_tlast_rp <= #(1) 1;
    @(posedge user_clk_out_rp);
    s_axis_tx_tvalid_rp <= #(1) 0;
    s_axis_tx_tkeep_rp <= #(1) 8'h00;
    s_axis_tx_tlast_rp <= #(1) 0;
    repeat (200) @(posedge user_clk_out_rp);

    s_axis_tx_tuser_rp <= #(1) 4'd0;
    s_axis_tx_tdata_rp <= #(1) 64'h01af_050f_0400_0001;
    s_axis_tx_tkeep_rp <= #(1) 8'hff;
    s_axis_tx_tlast_rp <= #(1) 0;
    s_axis_tx_tvalid_rp <= #(1) 1;
    @(posedge user_clk_out_rp);
    s_axis_tx_tdata_rp <= #(1) 64'h0000_0000_01a0_0018;
    s_axis_tx_tkeep_rp <= #(1) 8'h0f;
    s_axis_tx_tlast_rp <= #(1) 1;
    @(posedge user_clk_out_rp);
    s_axis_tx_tvalid_rp <= #(1) 0;
    s_axis_tx_tkeep_rp <= #(1) 8'h00;
    s_axis_tx_tlast_rp <= #(1) 0;
    repeat (200) @(posedge user_clk_out_rp);


    s_axis_tx_tuser_rp <= #(1) 4'd0;
    s_axis_tx_tdata_rp <= #(1) 64'h01af_060f_4400_0001;
    s_axis_tx_tkeep_rp <= #(1) 8'hff;
    s_axis_tx_tlast_rp <= #(1) 0;
    s_axis_tx_tvalid_rp <= #(1) 1;
    @(posedge user_clk_out_rp);
    s_axis_tx_tdata_rp <= #(1) 64'hffff_ffff_01a0_001c;
    s_axis_tx_tkeep_rp <= #(1) 8'hff;
    s_axis_tx_tlast_rp <= #(1) 1;
    @(posedge user_clk_out_rp);
    s_axis_tx_tvalid_rp <= #(1) 0;
    s_axis_tx_tkeep_rp <= #(1) 8'h00;
    s_axis_tx_tlast_rp <= #(1) 0;
    repeat (200) @(posedge user_clk_out_rp);

    s_axis_tx_tuser_rp <= #(1) 4'd0;
    s_axis_tx_tdata_rp <= #(1) 64'h01af_070f_0400_0001;
    s_axis_tx_tkeep_rp <= #(1) 8'hff;
    s_axis_tx_tlast_rp <= #(1) 0;
    s_axis_tx_tvalid_rp <= #(1) 1;
    @(posedge user_clk_out_rp);
    s_axis_tx_tdata_rp <= #(1) 64'h0000_0000_01a0_001c;
    s_axis_tx_tkeep_rp <= #(1) 8'h0f;
    s_axis_tx_tlast_rp <= #(1) 1;
    @(posedge user_clk_out_rp);
    s_axis_tx_tvalid_rp <= #(1) 0;
    s_axis_tx_tkeep_rp <= #(1) 8'h00;
    s_axis_tx_tlast_rp <= #(1) 0;
    repeat (200) @(posedge user_clk_out_rp);


    s_axis_tx_tuser_rp <= #(1) 4'd0;
    s_axis_tx_tdata_rp <= #(1) 64'h01af_080f_4400_0001;
    s_axis_tx_tkeep_rp <= #(1) 8'hff;
    s_axis_tx_tlast_rp <= #(1) 0;
    s_axis_tx_tvalid_rp <= #(1) 1;
    @(posedge user_clk_out_rp);
    s_axis_tx_tdata_rp <= #(1) 64'hffff_ffff_01a0_0020;
    s_axis_tx_tkeep_rp <= #(1) 8'hff;
    s_axis_tx_tlast_rp <= #(1) 1;
    @(posedge user_clk_out_rp);
    s_axis_tx_tvalid_rp <= #(1) 0;
    s_axis_tx_tkeep_rp <= #(1) 8'h00;
    s_axis_tx_tlast_rp <= #(1) 0;
    repeat (200) @(posedge user_clk_out_rp);

    s_axis_tx_tuser_rp <= #(1) 4'd0;
    s_axis_tx_tdata_rp <= #(1) 64'h01af_090f_0400_0001;
    s_axis_tx_tkeep_rp <= #(1) 8'hff;
    s_axis_tx_tlast_rp <= #(1) 0;
    s_axis_tx_tvalid_rp <= #(1) 1;
    @(posedge user_clk_out_rp);
    s_axis_tx_tdata_rp <= #(1) 64'h0000_0000_01a0_0020;
    s_axis_tx_tkeep_rp <= #(1) 8'h0f;
    s_axis_tx_tlast_rp <= #(1) 1;
    @(posedge user_clk_out_rp);
    s_axis_tx_tvalid_rp <= #(1) 0;
    s_axis_tx_tkeep_rp <= #(1) 8'h00;
    s_axis_tx_tlast_rp <= #(1) 0;
    repeat (200) @(posedge user_clk_out_rp);



    s_axis_tx_tuser_rp <= #(1) 4'd0;
    s_axis_tx_tdata_rp <= #(1) 64'h01af_0a0f_4400_0001;
    s_axis_tx_tkeep_rp <= #(1) 8'hff;
    s_axis_tx_tlast_rp <= #(1) 0;
    s_axis_tx_tvalid_rp <= #(1) 1;
    @(posedge user_clk_out_rp);
    s_axis_tx_tdata_rp <= #(1) 64'hffff_ffff_01a0_0024;
    s_axis_tx_tkeep_rp <= #(1) 8'hff;
    s_axis_tx_tlast_rp <= #(1) 1;
    @(posedge user_clk_out_rp);
    s_axis_tx_tvalid_rp <= #(1) 0;
    s_axis_tx_tkeep_rp <= #(1) 8'h00;
    s_axis_tx_tlast_rp <= #(1) 0;
    repeat (200) @(posedge user_clk_out_rp);

    s_axis_tx_tuser_rp <= #(1) 4'd0;
    s_axis_tx_tdata_rp <= #(1) 64'h01af_0b0f_0400_0001;
    s_axis_tx_tkeep_rp <= #(1) 8'hff;
    s_axis_tx_tlast_rp <= #(1) 0;
    s_axis_tx_tvalid_rp <= #(1) 1;
    @(posedge user_clk_out_rp);
    s_axis_tx_tdata_rp <= #(1) 64'h0000_0000_01a0_0024;
    s_axis_tx_tkeep_rp <= #(1) 8'h0f;
    s_axis_tx_tlast_rp <= #(1) 1;
    @(posedge user_clk_out_rp);
    s_axis_tx_tvalid_rp <= #(1) 0;
    s_axis_tx_tkeep_rp <= #(1) 8'h00;
    s_axis_tx_tlast_rp <= #(1) 0;
    repeat (200) @(posedge user_clk_out_rp);



    s_axis_tx_tuser_rp <= #(1) 4'd0;
    s_axis_tx_tdata_rp <= #(1) 64'h01af_0c0f_4400_0001;
    s_axis_tx_tkeep_rp <= #(1) 8'hff;
    s_axis_tx_tlast_rp <= #(1) 0;
    s_axis_tx_tvalid_rp <= #(1) 1;
    @(posedge user_clk_out_rp);
    s_axis_tx_tdata_rp <= #(1) 64'hffff_ffff_01a0_0030;
    s_axis_tx_tkeep_rp <= #(1) 8'hff;
    s_axis_tx_tlast_rp <= #(1) 1;
    @(posedge user_clk_out_rp);
    s_axis_tx_tvalid_rp <= #(1) 0;
    s_axis_tx_tkeep_rp <= #(1) 8'h00;
    s_axis_tx_tlast_rp <= #(1) 0;
    repeat (200) @(posedge user_clk_out_rp);

    s_axis_tx_tuser_rp <= #(1) 4'd0;
    s_axis_tx_tdata_rp <= #(1) 64'h01af_0d0f_0400_0001;
    s_axis_tx_tkeep_rp <= #(1) 8'hff;
    s_axis_tx_tlast_rp <= #(1) 0;
    s_axis_tx_tvalid_rp <= #(1) 1;
    @(posedge user_clk_out_rp);
    s_axis_tx_tdata_rp <= #(1) 64'h0000_0000_01a0_0030;
    s_axis_tx_tkeep_rp <= #(1) 8'h0f;
    s_axis_tx_tlast_rp <= #(1) 1;
    @(posedge user_clk_out_rp);
    s_axis_tx_tvalid_rp <= #(1) 0;
    s_axis_tx_tkeep_rp <= #(1) 8'h00;
    s_axis_tx_tlast_rp <= #(1) 0;
    repeat (200) @(posedge user_clk_out_rp);




    s_axis_tx_tuser_rp <= #(1) 4'd0;
    s_axis_tx_tdata_rp <= #(1) 64'h01af_000f_4400_0001;
    s_axis_tx_tkeep_rp <= #(1) 8'hff;
    s_axis_tx_tlast_rp <= #(1) 0;
    s_axis_tx_tvalid_rp <= #(1) 1;
    @(posedge user_clk_out_rp);
    s_axis_tx_tdata_rp <= #(1) 64'h0000_0000_01a0_0010;
    s_axis_tx_tkeep_rp <= #(1) 8'hff;
    s_axis_tx_tlast_rp <= #(1) 1;
    @(posedge user_clk_out_rp);
    s_axis_tx_tvalid_rp <= #(1) 0;
    s_axis_tx_tkeep_rp <= #(1) 8'h00;
    s_axis_tx_tlast_rp <= #(1) 0;
    repeat (200) @(posedge user_clk_out_rp);


    s_axis_tx_tuser_rp <= #(1) 4'd0;
    s_axis_tx_tdata_rp <= #(1) 64'h01af_010f_4400_0001;
    s_axis_tx_tkeep_rp <= #(1) 8'hff;
    s_axis_tx_tlast_rp <= #(1) 0;
    s_axis_tx_tvalid_rp <= #(1) 1;
    @(posedge user_clk_out_rp);
    s_axis_tx_tdata_rp <= #(1) 64'h0000_0000_01a0_0014;
    s_axis_tx_tkeep_rp <= #(1) 8'hff;
    s_axis_tx_tlast_rp <= #(1) 1;
    @(posedge user_clk_out_rp);
    s_axis_tx_tvalid_rp <= #(1) 0;
    s_axis_tx_tkeep_rp <= #(1) 8'h00;
    s_axis_tx_tlast_rp <= #(1) 0;
    repeat (200) @(posedge user_clk_out_rp);

    s_axis_tx_tuser_rp <= #(1) 4'd0;
    s_axis_tx_tdata_rp <= #(1) 64'h01af_020f_4400_0001;
    s_axis_tx_tkeep_rp <= #(1) 8'hff;
    s_axis_tx_tlast_rp <= #(1) 0;
    s_axis_tx_tvalid_rp <= #(1) 1;
    @(posedge user_clk_out_rp);
    s_axis_tx_tdata_rp <= #(1) 64'h0000_0000_01a0_0018;
    s_axis_tx_tkeep_rp <= #(1) 8'hff;
    s_axis_tx_tlast_rp <= #(1) 1;
    @(posedge user_clk_out_rp);
    s_axis_tx_tvalid_rp <= #(1) 0;
    s_axis_tx_tkeep_rp <= #(1) 8'h00;
    s_axis_tx_tlast_rp <= #(1) 0;
    repeat (200) @(posedge user_clk_out_rp);

    s_axis_tx_tuser_rp <= #(1) 4'd0;
    s_axis_tx_tdata_rp <= #(1) 64'h01af_030f_4400_0001;
    s_axis_tx_tkeep_rp <= #(1) 8'hff;
    s_axis_tx_tlast_rp <= #(1) 0;
    s_axis_tx_tvalid_rp <= #(1) 1;
    @(posedge user_clk_out_rp);
    s_axis_tx_tdata_rp <= #(1) 64'h0000_0000_01a0_001c;
    s_axis_tx_tkeep_rp <= #(1) 8'hff;
    s_axis_tx_tlast_rp <= #(1) 1;
    @(posedge user_clk_out_rp);
    s_axis_tx_tvalid_rp <= #(1) 0;
    s_axis_tx_tkeep_rp <= #(1) 8'h00;
    s_axis_tx_tlast_rp <= #(1) 0;
    repeat (200) @(posedge user_clk_out_rp);

    s_axis_tx_tuser_rp <= #(1) 4'd0;
    s_axis_tx_tdata_rp <= #(1) 64'h01af_040f_4400_0001;
    s_axis_tx_tkeep_rp <= #(1) 8'hff;
    s_axis_tx_tlast_rp <= #(1) 0;
    s_axis_tx_tvalid_rp <= #(1) 1;
    @(posedge user_clk_out_rp);
    s_axis_tx_tdata_rp <= #(1) 64'h0000_0000_01a0_0020;
    s_axis_tx_tkeep_rp <= #(1) 8'hff;
    s_axis_tx_tlast_rp <= #(1) 1;
    @(posedge user_clk_out_rp);
    s_axis_tx_tvalid_rp <= #(1) 0;
    s_axis_tx_tkeep_rp <= #(1) 8'h00;
    s_axis_tx_tlast_rp <= #(1) 0;
    repeat (200) @(posedge user_clk_out_rp);

    s_axis_tx_tuser_rp <= #(1) 4'd0;
    s_axis_tx_tdata_rp <= #(1) 64'h01af_050f_4400_0001;
    s_axis_tx_tkeep_rp <= #(1) 8'hff;
    s_axis_tx_tlast_rp <= #(1) 0;
    s_axis_tx_tvalid_rp <= #(1) 1;
    @(posedge user_clk_out_rp);
    s_axis_tx_tdata_rp <= #(1) 64'h0000_0000_01a0_0024;
    s_axis_tx_tkeep_rp <= #(1) 8'hff;
    s_axis_tx_tlast_rp <= #(1) 1;
    @(posedge user_clk_out_rp);
    s_axis_tx_tvalid_rp <= #(1) 0;
    s_axis_tx_tkeep_rp <= #(1) 8'h00;
    s_axis_tx_tlast_rp <= #(1) 0;
    repeat (200) @(posedge user_clk_out_rp);

    s_axis_tx_tuser_rp <= #(1) 4'd0;
    s_axis_tx_tdata_rp <= #(1) 64'h01af_060f_4400_0001;
    s_axis_tx_tkeep_rp <= #(1) 8'hff;
    s_axis_tx_tlast_rp <= #(1) 0;
    s_axis_tx_tvalid_rp <= #(1) 1;
    @(posedge user_clk_out_rp);
    s_axis_tx_tdata_rp <= #(1) 64'h0000_0000_01a0_0030;
    s_axis_tx_tkeep_rp <= #(1) 8'hff;
    s_axis_tx_tlast_rp <= #(1) 1;
    @(posedge user_clk_out_rp);
    s_axis_tx_tvalid_rp <= #(1) 0;
    s_axis_tx_tkeep_rp <= #(1) 8'h00;
    s_axis_tx_tlast_rp <= #(1) 0;
    repeat (200) @(posedge user_clk_out_rp);

    s_axis_tx_tuser_rp <= #(1) 4'd0;
    s_axis_tx_tdata_rp <= #(1) 64'h01af_0701_4400_0001;
    s_axis_tx_tkeep_rp <= #(1) 8'hff;
    s_axis_tx_tlast_rp <= #(1) 0;
    s_axis_tx_tvalid_rp <= #(1) 1;
    @(posedge user_clk_out_rp);
    s_axis_tx_tdata_rp <= #(1) 64'h0300_0000_01a0_0004;
    s_axis_tx_tkeep_rp <= #(1) 8'hff;
    s_axis_tx_tlast_rp <= #(1) 1;
    @(posedge user_clk_out_rp);
    s_axis_tx_tvalid_rp <= #(1) 0;
    s_axis_tx_tkeep_rp <= #(1) 8'h00;
    s_axis_tx_tlast_rp <= #(1) 0;
    repeat (200) @(posedge user_clk_out_rp);

    s_axis_tx_tuser_rp <= #(1) 4'd0;
    s_axis_tx_tdata_rp <= #(1) 64'h01af_0801_4400_0001;
    s_axis_tx_tkeep_rp <= #(1) 8'hff;
    s_axis_tx_tlast_rp <= #(1) 0;
    s_axis_tx_tvalid_rp <= #(1) 1;
    @(posedge user_clk_out_rp);
    s_axis_tx_tdata_rp <= #(1) 64'h5f00_0000_01a0_0008;
    s_axis_tx_tkeep_rp <= #(1) 8'hff;
    s_axis_tx_tlast_rp <= #(1) 1;
    @(posedge user_clk_out_rp);
    s_axis_tx_tvalid_rp <= #(1) 0;
    s_axis_tx_tkeep_rp <= #(1) 8'h00;
    s_axis_tx_tlast_rp <= #(1) 0;
    repeat (500) @(posedge user_clk_out_rp);
    //------------------------------------------
    // 1. MEMORY WRITE: 0xABCD1234 -> 0x00100000
    //------------------------------------------


    s_axis_tx_tuser_rp <= #(1) 4'd0;
    s_axis_tx_tdata_rp <= #(1) 64'h01a0_170f_4000_0001;
    s_axis_tx_tkeep_rp <= #(1) 8'hff;
    s_axis_tx_tlast_rp <= #(1) 0;
    s_axis_tx_tvalid_rp <= #(1) 1;
    @(posedge user_clk_out_rp);
    s_axis_tx_tdata_rp <= #(1) 64'h0a0b_0c0d_0000_0010;
    s_axis_tx_tkeep_rp <= #(1) 8'hff;
    s_axis_tx_tlast_rp <= #(1) 1;
    @(posedge user_clk_out_rp);
    s_axis_tx_tvalid_rp <= #(1) 0;
    s_axis_tx_tkeep_rp <= #(1) 8'h00;
    s_axis_tx_tlast_rp <= #(1) 0;
    repeat (200) @(posedge user_clk_out_rp);


    s_axis_tx_tuser_rp <= #(1) 4'd0;
    s_axis_tx_tdata_rp <= #(1) 64'h01a0_180f_0000_0001;
    s_axis_tx_tkeep_rp <= #(1) 8'hff;
    s_axis_tx_tlast_rp <= #(1) 0;
    s_axis_tx_tvalid_rp <= #(1) 1;
    @(posedge user_clk_out_rp);
    s_axis_tx_tdata_rp <= #(1) 64'h0000_0000_0000_0010;
    s_axis_tx_tkeep_rp <= #(1) 8'h0f;
    s_axis_tx_tlast_rp <= #(1) 1;
    @(posedge user_clk_out_rp);
    s_axis_tx_tvalid_rp <= #(1) 0;
    s_axis_tx_tkeep_rp <= #(1) 8'h00;
    s_axis_tx_tlast_rp <= #(1) 0;
    repeat (200) @(posedge user_clk_out_rp);




    s_axis_tx_tuser_ep <= #(1) 4'd0;
    s_axis_tx_tdata_ep <= #(1) 64'h01a0_0004_4a00_0001;
    s_axis_tx_tkeep_ep <= #(1) 8'hff;
    s_axis_tx_tlast_ep <= #(1) 0;
    s_axis_tx_tvalid_ep <= #(1) 1;
    @(posedge user_clk_out_rp);
    s_axis_tx_tdata_ep <= #(1) 64'h0a0b_0c0d_01a0_1810;
    s_axis_tx_tkeep_ep <= #(1) 8'hff;
    s_axis_tx_tlast_ep <= #(1) 1;
    @(posedge user_clk_out_rp);
    s_axis_tx_tvalid_ep <= #(1) 0;
    s_axis_tx_tkeep_ep <= #(1) 8'h00;
    s_axis_tx_tlast_ep <= #(1) 0;
    repeat (200) @(posedge user_clk_out_rp);




    dw0 = build_dw0(2'b10, 5'b00000, 10'b1); // baştaki 3 bit 6 olmalı 3 DW +Data, MemWr
    dw1 = build_dw1(16'hFACE, 8'h02, 4'h0, 4'hF); // 3 DW +Data, MemWr
    dw2 = 32'h8000_0000; // h0000_00FF
    payload = 32'hFEED_FACE;

    // Write - cycle - 1
    s_axis_tx_tuser_rp <= #(1) 4'd4;
    s_axis_tx_tdata_rp <= #(1) {dw1, dw0};
    s_axis_tx_tkeep_rp <= #(1) 8'hff;
    s_axis_tx_tlast_rp <= #(1) 0;
    s_axis_tx_tvalid_rp <= #(1) 1;
    @(posedge user_clk_out_rp);

    // Write - cycle - 2
    s_axis_tx_tdata_rp <= #(1) {payload, dw2};
    s_axis_tx_tkeep_rp <= #(1) 8'hff;
    s_axis_tx_tlast_rp <= #(1) 1;
    @(posedge user_clk_out_rp);

    s_axis_tx_tvalid_rp <= #(1) 0;
    s_axis_tx_tkeep_rp <= #(1) 8'h00;
    s_axis_tx_tlast_rp <= #(1) 0;
    $display("[INFO] Memory Write is sent");

    repeat (500) @(posedge user_clk_out_rp);

    //------------------------------------------
    // 1. MEMORY READ: address 0 0x00100000
    //------------------------------------------
    tag = 8'h03;
    dw0 = build_dw0(2'b00, 5'b00000, 10'b1); // 3 DW +Data, MemWr
    dw1 = build_dw1(16'hFACE, tag, 4'h0, 4'hF); // 3 DW +Data, MemWr
    dw2 = 32'h8000_0000;

    // Read - cycle - 1
    s_axis_tx_tvalid_rp <= #(1) 1;
    s_axis_tx_tlast_rp <= #(1) 0;
    s_axis_tx_tkeep_rp <= #(1) 8'hff;
    s_axis_tx_tuser_rp <= #(1) 4'b0000;
    s_axis_tx_tdata_rp <= #(1) {dw1, dw0};
    @(posedge user_clk_out_rp);

    // Read - cycle - 2
    s_axis_tx_tvalid_rp <= #(1) 1;
    s_axis_tx_tlast_rp <= #(1) 1;
    s_axis_tx_tkeep_rp <= #(1) 8'h0f;
    s_axis_tx_tdata_rp <= #(1) {32'h0, dw2};
    @(posedge user_clk_out_rp);

    s_axis_tx_tvalid_rp <= #(1) 0;
    s_axis_tx_tlast_rp <= #(1) 0;
    $display("[INFO] Memory Read is sent");

    @(posedge user_clk_out_rp);
    /*
    // Read - cycle - 1
    s_axis_tx_tvalid_ep <= 1;
    s_axis_tx_tlast_ep <= 0;
    s_axis_tx_tkeep_ep <= 8'hff;
    s_axis_tx_tuser_ep <= 4'b0000;
    s_axis_tx_tdata_ep <= {dw1, dw0};
    @(posedge user_clk_out_ep);

    // Read - cycle - 2
    s_axis_tx_tvalid_ep <= 1;
    s_axis_tx_tlast_ep <= 1;
    s_axis_tx_tdata_ep <= {32'h0, dw2};
    @(posedge user_clk_out_ep);

    s_axis_tx_tvalid_ep <= 0;
    s_axis_tx_tlast_ep <= 0;
*/
    wait (m_axis_rx_tvalid_rp);
    $display("[INFO] Completion received at %0t", $time);
    $display("[INFO] Data = %0h", m_axis_rx_tdata_rp);

    repeat (100) @(posedge user_clk_out_rp);

  end

  function automatic logic [31:0] build_dw0(input bit [1:0] fmt, input bit [4:0] type_,
                                            input bit [9:0] length);
    build_dw0 = {1'b0, fmt, type_, 1'b0, 3'b000, 4'b0000, 1'b0, 1'b0, 2'b00, 2'b00, length};
  endfunction

  function automatic logic [31:0] build_dw1(input bit [15:0] requestor_id, input bit [7:0] tag,
                                            input bit [3:0] last_be, input bit [3:0] first_be);
    build_dw1 = {requestor_id, tag, last_be, first_be};
  endfunction

  assign rx_np_ok_ep = 1'b1;
  assign rx_np_req_ep = 1'b0;
  assign tx_cfg_gnt_ep = 1'b1;
  // Management interface (bypass edilecek)
  assign cfg_mgmt_di_ep = 32'h0;
  assign cfg_mgmt_byte_en_ep = 4'hF;
  assign cfg_mgmt_dwaddr_ep = 10'h0;
  assign cfg_mgmt_wr_en_ep = 1'b0;
  assign cfg_mgmt_rd_en_ep = 1'b0;
  assign cfg_mgmt_wr_readonly_ep = 1'b0;
  // Error inputs (disable all errors)
  assign cfg_err_ecrc_ep = 1'b0;
  assign cfg_err_ur_ep = 1'b0;
  assign cfg_err_cpl_timeout_ep = 1'b0;
  assign cfg_err_cpl_unexpect_ep = 1'b0;
  assign cfg_err_cpl_abort_ep = 1'b0;
  assign cfg_err_posted_ep = 1'b0;
  assign cfg_err_cor_ep = 1'b0;
  assign cfg_err_atomic_egress_blocked_ep = 1'b0;
  assign cfg_err_internal_cor_ep = 1'b0;
  assign cfg_err_malformed_ep = 1'b0;
  assign cfg_err_mc_blocked_ep = 1'b0;
  assign cfg_err_poisoned_ep = 1'b0;
  assign cfg_err_norecovery_ep = 1'b0;
  assign cfg_err_tlp_cpl_header_ep = 48'h0;
  assign cfg_err_locked_ep = 1'b0;
  assign cfg_err_acs_ep = 1'b0;
  assign cfg_err_internal_uncor_ep = 1'b0;
  // Power management ve diğer advanced kontroller
  assign cfg_pm_halt_aspm_l0s_ep = 1'b0;
  assign cfg_pm_halt_aspm_l1_ep = 1'b0;
  assign cfg_pm_force_state_en_ep = 1'b0;
  assign cfg_pm_force_state_ep = 2'b00;
  assign cfg_pm_wake_ep = 1'b0;
  assign cfg_pm_send_pme_to_ep = 1'b0;
  assign cfg_ds_bus_number_ep = 8'h00;
  assign cfg_ds_device_number_ep = 5'h00;
  assign cfg_ds_function_number_ep = 3'h00;
  assign cfg_interrupt_ep = 1'b0;
  assign cfg_interrupt_assert_ep = 1'b0;
  assign cfg_interrupt_di_ep = 8'h00;
  assign cfg_interrupt_stat_ep = 1'b0;
  assign cfg_pciecap_interrupt_msgnum_ep = 5'h00;
  assign fc_sel_ep = 3'b0;
  assign pl_directed_link_change_ep = 2'b00;
  assign pl_directed_link_width_ep = 2'b00;
  assign pl_directed_link_speed_ep = 1'b0;
  assign pl_directed_link_auton_ep = 1'b0;
  assign pl_upstream_prefer_deemph_ep = 1'b0;
  assign pl_transmit_hot_rst_ep = 1'b0;
  assign pl_downstream_deemph_source_ep = 1'b0;
  assign cfg_err_aer_headerlog_ep = 128'h0;
  assign cfg_aer_interrupt_msgnum_ep = 5'h0;
  assign cfg_mgmt_wr_rw1c_as_rw_ep = 1'b0;


  assign rx_np_ok_rp = 1'b1;
  assign rx_np_req_rp = 1'b0;
  assign tx_cfg_gnt_rp = 1'b1;
  // Management interface (bypass edilecek)
  assign cfg_mgmt_di_rp = 32'h0;
  assign cfg_mgmt_byte_en_rp = 4'hF;
  assign cfg_mgmt_dwaddr_rp = 10'h0;
  assign cfg_mgmt_wr_en_rp = 1'b0;
  assign cfg_mgmt_rd_en_rp = 1'b0;
  assign cfg_mgmt_wr_readonly_rp = 1'b0;
  // Error inputs (disable all errors)
  assign cfg_err_ecrc_rp = 1'b0;
  assign cfg_err_ur_rp = 1'b0;
  assign cfg_err_cpl_timeout_rp = 1'b0;
  assign cfg_err_cpl_unexpect_rp = 1'b0;
  assign cfg_err_cpl_abort_rp = 1'b0;
  assign cfg_err_posted_rp = 1'b0;
  assign cfg_err_cor_rp = 1'b0;
  assign cfg_err_atomic_egress_blocked_rp = 1'b0;
  assign cfg_err_internal_cor_rp = 1'b0;
  assign cfg_err_malformed_rp = 1'b0;
  assign cfg_err_mc_blocked_rp = 1'b0;
  assign cfg_err_poisoned_rp = 1'b0;
  assign cfg_err_norecovery_rp = 1'b0;
  assign cfg_err_tlp_cpl_header_rp = 48'h0;
  assign cfg_err_locked_rp = 1'b0;
  assign cfg_err_acs_rp = 1'b0;
  assign cfg_err_internal_uncor_rp = 1'b0;
  // Power management ve diğer advanced kontroller
  assign cfg_pm_halt_aspm_l0s_rp = 1'b0;
  assign cfg_pm_halt_aspm_l1_rp = 1'b0;
  assign cfg_pm_force_state_en_rp = 1'b0;
  assign cfg_pm_force_state_rp = 2'b00;
  assign cfg_pm_wake_rp = 1'b0;
  assign cfg_pm_send_pme_to_rp = 1'b0;
  assign cfg_ds_bus_number_rp = 8'h00;
  assign cfg_ds_device_number_rp = 5'h00;
  assign cfg_ds_function_number_rp = 3'h00;
  assign cfg_interrupt_rp = 1'b0;
  assign cfg_interrupt_assert_rp = 1'b0;
  assign cfg_interrupt_di_rp = 8'h00;
  assign cfg_interrupt_stat_rp = 1'b0;
  assign cfg_pciecap_interrupt_msgnum_rp = 5'h00;
  assign fc_sel_rp = 3'b0;
  assign pl_directed_link_change_rp = 2'b00;
  assign pl_directed_link_width_rp = 2'b00;
  assign pl_directed_link_speed_rp = 1'b0;
  assign pl_directed_link_auton_rp = 1'b0;
  assign pl_upstream_prefer_deemph_rp = 1'b0;
  assign pl_transmit_hot_rst_rp = 1'b0;
  assign pl_downstream_deemph_source_rp = 1'b0;
  assign cfg_err_aer_headerlog_rp = 128'h0;
  assign cfg_aer_interrupt_msgnum_rp = 5'h0;
  assign cfg_mgmt_wr_rw1c_as_rw_rp = 1'b0;

  pcie_7x_0 pcie_ep_inst (
    .pci_exp_txp(ep_pci_exp_txp),  //  logic [3 : 0] pci_exp_txp
    .pci_exp_txn(ep_pci_exp_txn),  //  logic [3 : 0] pci_exp_txn
    .pci_exp_rxp(ep_pci_exp_rxp),  //  logic [3 : 0] pci_exp_rxp
    .pci_exp_rxn(ep_pci_exp_rxn),  //  logic [3 : 0] pci_exp_rxn
    .user_clk_out(user_clk_out_ep),  //  logic user_clk_out
    .user_reset_out(user_reset_out_ep),  //  logic user_reset_out
    .user_lnk_up(user_lnk_up_ep),  //  logic user_lnk_up
    .user_app_rdy(user_app_rdy_ep),  //  logic user_app_rdy
    .tx_buf_av(tx_buf_av_ep),  //  logic [5 : 0] tx_buf_av
    .tx_cfg_req(tx_cfg_req_ep),  //  logic tx_cfg_req
    .tx_err_drop(tx_err_drop_ep),  //  logic tx_err_drop
    .s_axis_tx_tready(s_axis_tx_tready_ep),  //  logic s_axis_tx_tready
    .s_axis_tx_tdata(s_axis_tx_tdata_ep),  //  logic [63 : 0] s_axis_tx_tdata
    .s_axis_tx_tkeep(s_axis_tx_tkeep_ep),  //  logic [7 : 0] s_axis_tx_tkeep
    .s_axis_tx_tlast(s_axis_tx_tlast_ep),  //  logic s_axis_tx_tlast
    .s_axis_tx_tvalid(s_axis_tx_tvalid_ep),  //  logic s_axis_tx_tvalid
    .s_axis_tx_tuser(s_axis_tx_tuser_ep),  //  logic [3 : 0] s_axis_tx_tuser
    .tx_cfg_gnt(tx_cfg_gnt_ep),  //  logic tx_cfg_gnt
    .m_axis_rx_tdata(m_axis_rx_tdata_ep),  //  logic [63 : 0] m_axis_rx_tdata
    .m_axis_rx_tkeep(m_axis_rx_tkeep_ep),  //  logic [7 : 0] m_axis_rx_tkeep
    .m_axis_rx_tlast(m_axis_rx_tlast_ep),  //  logic m_axis_rx_tlast
    .m_axis_rx_tvalid(m_axis_rx_tvalid_ep),  //  logic m_axis_rx_tvalid
    .m_axis_rx_tready(m_axis_rx_tready_ep),  //  logic m_axis_rx_tready
    .m_axis_rx_tuser(m_axis_rx_tuser_ep),  //  logic [21 : 0] m_axis_rx_tuser
    .rx_np_ok(rx_np_ok_ep),  //  logic rx_np_ok
    .rx_np_req(rx_np_req_ep),  //  logic rx_np_req
    .fc_cpld(fc_cpld_ep),  //  logic [11 : 0] fc_cpld
    .fc_cplh(fc_cplh_ep),  //  logic [7 : 0] fc_cplh
    .fc_npd(fc_npd_ep),  //  logic [11 : 0] fc_npd
    .fc_nph(fc_nph_ep),  //  logic [7 : 0] fc_nph
    .fc_pd(fc_pd_ep),  //  logic [11 : 0] fc_pd
    .fc_ph(fc_ph_ep),  //  logic [7 : 0] fc_ph
    .fc_sel(fc_sel_ep),  //  logic [2 : 0] fc_sel
    .cfg_mgmt_do(cfg_mgmt_do_ep),  //  logic [31 : 0] cfg_mgmt_do
    .cfg_mgmt_rd_wr_done(cfg_mgmt_rd_wr_done_ep),  //  logic cfg_mgmt_rd_wr_done
    .cfg_status(cfg_status_ep),  //  logic [15 : 0] cfg_status
    .cfg_command(cfg_command_ep),  //  logic [15 : 0] cfg_command
    .cfg_dstatus(cfg_dstatus_ep),  //  logic [15 : 0] cfg_dstatus
    .cfg_dcommand(cfg_dcommand_ep),  //  logic [15 : 0] cfg_dcommand
    .cfg_lstatus(cfg_lstatus_ep),  //  logic [15 : 0] cfg_lstatus
    .cfg_lcommand(cfg_lcommand_ep),  //  logic [15 : 0] cfg_lcommand
    .cfg_dcommand2(cfg_dcommand2_ep),  //  logic [15 : 0] cfg_dcommand2
    .cfg_pcie_link_state(cfg_pcie_link_state_ep),  //  logic [2 : 0] cfg_pcie_link_state
    .cfg_pmcsr_pme_en(cfg_pmcsr_pme_en_ep),  //  logic cfg_pmcsr_pme_en
    .cfg_pmcsr_powerstate(cfg_pmcsr_powerstate_ep),  //  logic [1 : 0] cfg_pmcsr_powerstate
    .cfg_pmcsr_pme_status(cfg_pmcsr_pme_status_ep),  //  logic cfg_pmcsr_pme_status
    .cfg_received_func_lvl_rst(cfg_received_func_lvl_rst_ep),  //  logic cfg_received_func_lvl_rst
    .cfg_mgmt_di(cfg_mgmt_di_ep),  //  logic [31 : 0] cfg_mgmt_di
    .cfg_mgmt_byte_en(cfg_mgmt_byte_en_ep),  //  logic [3 : 0] cfg_mgmt_byte_en
    .cfg_mgmt_dwaddr(cfg_mgmt_dwaddr_ep),  //  logic [9 : 0] cfg_mgmt_dwaddr
    .cfg_mgmt_wr_en(cfg_mgmt_wr_en_ep),  //  logic cfg_mgmt_wr_en
    .cfg_mgmt_rd_en(cfg_mgmt_rd_en_ep),  //  logic cfg_mgmt_rd_en
    .cfg_mgmt_wr_readonly(cfg_mgmt_wr_readonly_ep),  //  logic cfg_mgmt_wr_readonly
    .cfg_err_ecrc(cfg_err_ecrc_ep),  //  logic cfg_err_ecrc
    .cfg_err_ur(cfg_err_ur_ep),  //  logic cfg_err_ur
    .cfg_err_cpl_timeout(cfg_err_cpl_timeout_ep),  //  logic cfg_err_cpl_timeout
    .cfg_err_cpl_unexpect(cfg_err_cpl_unexpect_ep),  //  logic cfg_err_cpl_unexpect
    .cfg_err_cpl_abort(cfg_err_cpl_abort_ep),  //  logic cfg_err_cpl_abort
    .cfg_err_posted(cfg_err_posted_ep),  //  logic cfg_err_posted
    .cfg_err_cor(cfg_err_cor_ep),  //  logic cfg_err_cor
    .cfg_err_atomic_egress_blocked(cfg_err_atomic_egress_blocked_ep),                            //  logic cfg_err_atomic_egress_blocked
    .cfg_err_internal_cor(cfg_err_internal_cor_ep),  //  logic cfg_err_internal_cor
    .cfg_err_malformed(cfg_err_malformed_ep),  //  logic cfg_err_malformed
    .cfg_err_mc_blocked(cfg_err_mc_blocked_ep),  //  logic cfg_err_mc_blocked
    .cfg_err_poisoned(cfg_err_poisoned_ep),  //  logic cfg_err_poisoned
    .cfg_err_norecovery(cfg_err_norecovery_ep),  //  logic cfg_err_norecovery
    .cfg_err_tlp_cpl_header(cfg_err_tlp_cpl_header_ep),  //  logic [47 : 0] cfg_err_tlp_cpl_header
    .cfg_err_cpl_rdy(cfg_err_cpl_rdy_ep),  //  logic cfg_err_cpl_rdy
    .cfg_err_locked(cfg_err_locked_ep),  //  logic cfg_err_locked
    .cfg_err_acs(cfg_err_acs_ep),  //  logic cfg_err_acs
    .cfg_err_internal_uncor(cfg_err_internal_uncor_ep),  //  logic cfg_err_internal_uncor
    .cfg_trn_pending(cfg_trn_pending_ep),  //  logic cfg_trn_pending
    .cfg_pm_halt_aspm_l0s(cfg_pm_halt_aspm_l0s_ep),  //  logic cfg_pm_halt_aspm_l0s
    .cfg_pm_halt_aspm_l1(cfg_pm_halt_aspm_l1_ep),  //  logic cfg_pm_halt_aspm_l1
    .cfg_pm_force_state_en(cfg_pm_force_state_en_ep),  //  logic cfg_pm_force_state_en
    .cfg_pm_force_state(cfg_pm_force_state_ep),  //  logic [1 : 0] cfg_pm_force_state
    .cfg_dsn(cfg_dsn_ep),  //  logic [63 : 0] cfg_dsn
    .cfg_interrupt(cfg_interrupt_ep),  //  logic cfg_interrupt
    .cfg_interrupt_rdy(cfg_interrupt_rdy_ep),  //  logic cfg_interrupt_rdy
    .cfg_interrupt_assert(cfg_interrupt_assert_ep),  //  logic cfg_interrupt_assert
    .cfg_interrupt_di(cfg_interrupt_di_ep),  //  logic [7 : 0] cfg_interrupt_di
    .cfg_interrupt_do(cfg_interrupt_do_ep),  //  logic [7 : 0] cfg_interrupt_do
    .cfg_interrupt_mmenable(cfg_interrupt_mmenable_ep),  //  logic [2 : 0] cfg_interrupt_mmenable
    .cfg_interrupt_msienable(cfg_interrupt_msienable_ep),  //  logic cfg_interrupt_msienable
    .cfg_interrupt_msixenable(cfg_interrupt_msixenable_ep),  //  logic cfg_interrupt_msixenable
    .cfg_interrupt_msixfm(cfg_interrupt_msixfm_ep),  //  logic cfg_interrupt_msixfm
    .cfg_interrupt_stat(cfg_interrupt_stat_ep),  //  logic cfg_interrupt_stat
    .cfg_pciecap_interrupt_msgnum(cfg_pciecap_interrupt_msgnum_ep),                              //  logic [4 : 0] cfg_pciecap_interrupt_msgnum
    .cfg_to_turnoff(cfg_to_turnoff_ep),  //  logic cfg_to_turnoff
    .cfg_turnoff_ok(cfg_turnoff_ok_ep),  //  logic cfg_turnoff_ok
    .cfg_bus_number(cfg_bus_number_ep),  //  logic [7 : 0] cfg_bus_number
    .cfg_device_number(cfg_device_number_ep),  //  logic [4 : 0] cfg_device_number
    .cfg_function_number(cfg_function_number_ep),  //  logic [2 : 0] cfg_function_number
    .cfg_pm_wake(cfg_pm_wake_ep),  //  logic cfg_pm_wake
    .cfg_pm_send_pme_to(cfg_pm_send_pme_to_ep),  //  logic cfg_pm_send_pme_to
    .cfg_ds_bus_number(cfg_ds_bus_number_ep),  //  logic [7 : 0] cfg_ds_bus_number
    .cfg_ds_device_number(cfg_ds_device_number_ep),  //  logic [4 : 0] cfg_ds_device_number
    .cfg_ds_function_number(cfg_ds_function_number_ep),  //  logic [2 : 0] cfg_ds_function_number
    .cfg_mgmt_wr_rw1c_as_rw(cfg_mgmt_wr_rw1c_as_rw_ep),  //  logic cfg_mgmt_wr_rw1c_as_rw
    .cfg_msg_received(cfg_msg_received_ep),  //  logic cfg_msg_received
    .cfg_msg_data(cfg_msg_data_ep),  //  logic [15 : 0] cfg_msg_data
    .cfg_bridge_serr_en(cfg_bridge_serr_en_ep),  //  logic cfg_bridge_serr_en
    .cfg_slot_control_electromech_il_ctl_pulse(cfg_slot_control_electromech_il_ctl_pulse_ep),    //  logic cfg_slot_control_electromech_il_ctl_pulse
    .cfg_root_control_syserr_corr_err_en(cfg_root_control_syserr_corr_err_en_ep),                //  logic cfg_root_control_syserr_corr_err_en
    .cfg_root_control_syserr_non_fatal_err_en(cfg_root_control_syserr_non_fatal_err_en_ep),      //  logic cfg_root_control_syserr_non_fatal_err_en
    .cfg_root_control_syserr_fatal_err_en(cfg_root_control_syserr_fatal_err_en_ep),              //  logic cfg_root_control_syserr_fatal_err_en
    .cfg_root_control_pme_int_en(cfg_root_control_pme_int_en_ep),                                //  logic cfg_root_control_pme_int_en
    .cfg_aer_rooterr_corr_err_reporting_en(cfg_aer_rooterr_corr_err_reporting_en_ep),            //  logic cfg_aer_rooterr_corr_err_reporting_en
    .cfg_aer_rooterr_non_fatal_err_reporting_en(cfg_aer_rooterr_non_fatal_err_reporting_en_ep),  //  logic cfg_aer_rooterr_non_fatal_err_reporting_en
    .cfg_aer_rooterr_fatal_err_reporting_en(cfg_aer_rooterr_fatal_err_reporting_en_ep),          //  logic cfg_aer_rooterr_fatal_err_reporting_en
    .cfg_aer_rooterr_corr_err_received(cfg_aer_rooterr_corr_err_received_ep),                    //  logic cfg_aer_rooterr_corr_err_received
    .cfg_aer_rooterr_non_fatal_err_received(cfg_aer_rooterr_non_fatal_err_received_ep),          //  logic cfg_aer_rooterr_non_fatal_err_received
    .cfg_aer_rooterr_fatal_err_received(cfg_aer_rooterr_fatal_err_received_ep),                  //  logic cfg_aer_rooterr_fatal_err_received
    .cfg_msg_received_err_cor(cfg_msg_received_err_cor_ep),  //  logic cfg_msg_received_err_cor
    .cfg_msg_received_err_non_fatal(cfg_msg_received_err_non_fatal_ep),                          //  logic cfg_msg_received_err_non_fatal
    .cfg_msg_received_err_fatal(cfg_msg_received_err_fatal_ep),                                  //  logic cfg_msg_received_err_fatal
    .cfg_msg_received_pm_as_nak(cfg_msg_received_pm_as_nak_ep),                                  //  logic cfg_msg_received_pm_as_nak
    .cfg_msg_received_pm_pme(cfg_msg_received_pm_pme_ep),  //  logic cfg_msg_received_pm_pme
    .cfg_msg_received_pme_to_ack(cfg_msg_received_pme_to_ack_ep),                                //  logic cfg_msg_received_pme_to_ack
    .cfg_msg_received_assert_int_a(cfg_msg_received_assert_int_a_ep),                            //  logic cfg_msg_received_assert_int_a
    .cfg_msg_received_assert_int_b(cfg_msg_received_assert_int_b_ep),                            //  logic cfg_msg_received_assert_int_b
    .cfg_msg_received_assert_int_c(cfg_msg_received_assert_int_c_ep),                            //  logic cfg_msg_received_assert_int_c
    .cfg_msg_received_assert_int_d(cfg_msg_received_assert_int_d_ep),                            //  logic cfg_msg_received_assert_int_d
    .cfg_msg_received_deassert_int_a(cfg_msg_received_deassert_int_a_ep),                        //  logic cfg_msg_received_deassert_int_a
    .cfg_msg_received_deassert_int_b(cfg_msg_received_deassert_int_b_ep),                        //  logic cfg_msg_received_deassert_int_b
    .cfg_msg_received_deassert_int_c(cfg_msg_received_deassert_int_c_ep),                        //  logic cfg_msg_received_deassert_int_c
    .cfg_msg_received_deassert_int_d(cfg_msg_received_deassert_int_d_ep),                        //  logic cfg_msg_received_deassert_int_d
    .cfg_msg_received_setslotpowerlimit(cfg_msg_received_setslotpowerlimit_ep),                  //  logic cfg_msg_received_setslotpowerlimit
    .pl_directed_link_change(pl_directed_link_change_ep),  //  logic [1 : 0] pl_directed_link_change
    .pl_directed_link_width(pl_directed_link_width_ep),  //  logic [1 : 0] pl_directed_link_width
    .pl_directed_link_speed(pl_directed_link_speed_ep),  //  logic pl_directed_link_speed
    .pl_directed_link_auton(pl_directed_link_auton_ep),  //  logic pl_directed_link_auton
    .pl_upstream_prefer_deemph(pl_upstream_prefer_deemph_ep),  //  logic pl_upstream_prefer_deemph
    .pl_sel_lnk_rate(pl_sel_lnk_rate_ep),  //  logic pl_sel_lnk_rate
    .pl_sel_lnk_width(pl_sel_lnk_width_ep),  //  logic [1 : 0] pl_sel_lnk_width
    .pl_ltssm_state(pl_ltssm_state_ep),  //  logic [5 : 0] pl_ltssm_state
    .pl_lane_reversal_mode(pl_lane_reversal_mode_ep),  //  logic [1 : 0] pl_lane_reversal_mode
    .pl_phy_lnk_up(pl_phy_lnk_up_ep),  //  logic pl_phy_lnk_up
    .pl_tx_pm_state(pl_tx_pm_state_ep),  //  logic [2 : 0] pl_tx_pm_state
    .pl_rx_pm_state(pl_rx_pm_state_ep),  //  logic [1 : 0] pl_rx_pm_state
    .pl_link_upcfg_cap(pl_link_upcfg_cap_ep),  //  logic pl_link_upcfg_cap
    .pl_link_gen2_cap(pl_link_gen2_cap_ep),  //  logic pl_link_gen2_cap
    .pl_link_partner_gen2_supported(pl_link_partner_gen2_supported_ep),                          //  logic pl_link_partner_gen2_supported
    .pl_initial_link_width(pl_initial_link_width_ep),  //  logic [2 : 0] pl_initial_link_width
    .pl_directed_change_done(pl_directed_change_done_ep),  //  logic pl_directed_change_done
    .pl_received_hot_rst(pl_received_hot_rst_ep),  //  logic pl_received_hot_rst
    .pl_transmit_hot_rst(pl_transmit_hot_rst_ep),  //  logic pl_transmit_hot_rst
    .pl_downstream_deemph_source(pl_downstream_deemph_source_ep),                                //  logic pl_downstream_deemph_source
    .cfg_err_aer_headerlog(cfg_err_aer_headerlog_ep),  //  logic [127 : 0] cfg_err_aer_headerlog
    .cfg_aer_interrupt_msgnum(cfg_aer_interrupt_msgnum_ep),                                      //  logic [4 : 0] cfg_aer_interrupt_msgnum
    .cfg_err_aer_headerlog_set(cfg_err_aer_headerlog_set_ep),  //  logic cfg_err_aer_headerlog_set
    .cfg_aer_ecrc_check_en(cfg_aer_ecrc_check_en_ep),  //  logic cfg_aer_ecrc_check_en
    .cfg_aer_ecrc_gen_en(cfg_aer_ecrc_gen_en_ep),  //  logic cfg_aer_ecrc_gen_en
    .cfg_vc_tcvc_map(cfg_vc_tcvc_map_ep),  //  logic [6 : 0] cfg_vc_tcvc_map
    .sys_clk(sys_clk),  //  logic sys_clk
    .sys_rst_n(sys_rst_n)  //  logic sys_rst_n
  );


  pcie_7x_1 pcie_rp_inst (
    .pci_exp_txp(rp_pci_exp_txp),  //  logic [3 : 0] pci_exp_txp
    .pci_exp_txn(rp_pci_exp_txn),  //  logic [3 : 0] pci_exp_txn
    .pci_exp_rxp(rp_pci_exp_rxp),  //  logic [3 : 0] pci_exp_rxp
    .pci_exp_rxn(rp_pci_exp_rxn),  //  logic [3 : 0] pci_exp_rxn
    .user_clk_out(user_clk_out_rp),  //  logic user_clk_out
    .user_reset_out(user_reset_out_rp),  //  logic user_reset_out
    .user_lnk_up(user_lnk_up_rp),  //  logic user_lnk_up
    .user_app_rdy(user_app_rdy_rp),  //  logic user_app_rdy
    .tx_buf_av(tx_buf_av_rp),  //  logic [5 : 0] tx_buf_av
    .tx_cfg_req(tx_cfg_req_rp),  //  logic tx_cfg_req
    .tx_err_drop(tx_err_drop_rp),  //  logic tx_err_drop
    .s_axis_tx_tready(s_axis_tx_tready_rp),  //  logic s_axis_tx_tready
    .s_axis_tx_tdata(s_axis_tx_tdata_rp),  //  logic [63 : 0] s_axis_tx_tdata
    .s_axis_tx_tkeep(s_axis_tx_tkeep_rp),  //  logic [7 : 0] s_axis_tx_tkeep
    .s_axis_tx_tlast(s_axis_tx_tlast_rp),  //  logic s_axis_tx_tlast
    .s_axis_tx_tvalid(s_axis_tx_tvalid_rp),  //  logic s_axis_tx_tvalid
    .s_axis_tx_tuser(s_axis_tx_tuser_rp),  //  logic [3 : 0] s_axis_tx_tuser
    .tx_cfg_gnt(tx_cfg_gnt_rp),  //  logic tx_cfg_gnt
    .m_axis_rx_tdata(m_axis_rx_tdata_rp),  //  logic [63 : 0] m_axis_rx_tdata
    .m_axis_rx_tkeep(m_axis_rx_tkeep_rp),  //  logic [7 : 0] m_axis_rx_tkeep
    .m_axis_rx_tlast(m_axis_rx_tlast_rp),  //  logic m_axis_rx_tlast
    .m_axis_rx_tvalid(m_axis_rx_tvalid_rp),  //  logic m_axis_rx_tvalid
    .m_axis_rx_tready(m_axis_rx_tready_rp),  //  logic m_axis_rx_tready
    .m_axis_rx_tuser(m_axis_rx_tuser_rp),  //  logic [21 : 0] m_axis_rx_tuser
    .rx_np_ok(rx_np_ok_rp),  //  logic rx_np_ok
    .rx_np_req(rx_np_req_rp),  //  logic rx_np_req
    .fc_cpld(fc_cpld_rp),  //  logic [11 : 0] fc_cpld
    .fc_cplh(fc_cplh_rp),  //  logic [7 : 0] fc_cplh
    .fc_npd(fc_npd_rp),  //  logic [11 : 0] fc_npd
    .fc_nph(fc_nph_rp),  //  logic [7 : 0] fc_nph
    .fc_pd(fc_pd_rp),  //  logic [11 : 0] fc_pd
    .fc_ph(fc_ph_rp),  //  logic [7 : 0] fc_ph
    .fc_sel(fc_sel_rp),  //  logic [2 : 0] fc_sel
    .cfg_mgmt_do(cfg_mgmt_do_rp),  //  logic [31 : 0] cfg_mgmt_do
    .cfg_mgmt_rd_wr_done(cfg_mgmt_rd_wr_done_rp),  //  logic cfg_mgmt_rd_wr_done
    .cfg_status(cfg_status_rp),  //  logic [15 : 0] cfg_status
    .cfg_command(cfg_command_rp),  //  logic [15 : 0] cfg_command
    .cfg_dstatus(cfg_dstatus_rp),  //  logic [15 : 0] cfg_dstatus
    .cfg_dcommand(cfg_dcommand_rp),  //  logic [15 : 0] cfg_dcommand
    .cfg_lstatus(cfg_lstatus_rp),  //  logic [15 : 0] cfg_lstatus
    .cfg_lcommand(cfg_lcommand_rp),  //  logic [15 : 0] cfg_lcommand
    .cfg_dcommand2(cfg_dcommand2_rp),  //  logic [15 : 0] cfg_dcommand2
    .cfg_pcie_link_state(cfg_pcie_link_state_rp),  //  logic [2 : 0] cfg_pcie_link_state
    .cfg_pmcsr_pme_en(cfg_pmcsr_pme_en_rp),  //  logic cfg_pmcsr_pme_en
    .cfg_pmcsr_powerstate(cfg_pmcsr_powerstate_rp),  //  logic [1 : 0] cfg_pmcsr_powerstate
    .cfg_pmcsr_pme_status(cfg_pmcsr_pme_status_rp),  //  logic cfg_pmcsr_pme_status
    .cfg_received_func_lvl_rst(cfg_received_func_lvl_rst_rp),  //  logic cfg_received_func_lvl_rst
    .cfg_mgmt_di(cfg_mgmt_di_rp),  //  logic [31 : 0] cfg_mgmt_di
    .cfg_mgmt_byte_en(cfg_mgmt_byte_en_rp),  //  logic [3 : 0] cfg_mgmt_byte_en
    .cfg_mgmt_dwaddr(cfg_mgmt_dwaddr_rp),  //  logic [9 : 0] cfg_mgmt_dwaddr
    .cfg_mgmt_wr_en(cfg_mgmt_wr_en_rp),  //  logic cfg_mgmt_wr_en
    .cfg_mgmt_rd_en(cfg_mgmt_rd_en_rp),  //  logic cfg_mgmt_rd_en
    .cfg_mgmt_wr_readonly(cfg_mgmt_wr_readonly_rp),  //  logic cfg_mgmt_wr_readonly
    .cfg_err_ecrc(cfg_err_ecrc_rp),  //  logic cfg_err_ecrc
    .cfg_err_ur(cfg_err_ur_rp),  //  logic cfg_err_ur
    .cfg_err_cpl_timeout(cfg_err_cpl_timeout_rp),  //  logic cfg_err_cpl_timeout
    .cfg_err_cpl_unexpect(cfg_err_cpl_unexpect_rp),  //  logic cfg_err_cpl_unexpect
    .cfg_err_cpl_abort(cfg_err_cpl_abort_rp),  //  logic cfg_err_cpl_abort
    .cfg_err_posted(cfg_err_posted_rp),  //  logic cfg_err_posted
    .cfg_err_cor(cfg_err_cor_rp),  //  logic cfg_err_cor
    .cfg_err_atomic_egress_blocked(cfg_err_atomic_egress_blocked_rp),                            //  logic cfg_err_atomic_egress_blocked
    .cfg_err_internal_cor(cfg_err_internal_cor_rp),  //  logic cfg_err_internal_cor
    .cfg_err_malformed(cfg_err_malformed_rp),  //  logic cfg_err_malformed
    .cfg_err_mc_blocked(cfg_err_mc_blocked_rp),  //  logic cfg_err_mc_blocked
    .cfg_err_poisoned(cfg_err_poisoned_rp),  //  logic cfg_err_poisoned
    .cfg_err_norecovery(cfg_err_norecovery_rp),  //  logic cfg_err_norecovery
    .cfg_err_tlp_cpl_header(cfg_err_tlp_cpl_header_rp),  //  logic [47 : 0] cfg_err_tlp_cpl_header
    .cfg_err_cpl_rdy(cfg_err_cpl_rdy_rp),  //  logic cfg_err_cpl_rdy
    .cfg_err_locked(cfg_err_locked_rp),  //  logic cfg_err_locked
    .cfg_err_acs(cfg_err_acs_rp),  //  logic cfg_err_acs
    .cfg_err_internal_uncor(cfg_err_internal_uncor_rp),  //  logic cfg_err_internal_uncor
    .cfg_trn_pending(cfg_trn_pending_rp),  //  logic cfg_trn_pending
    .cfg_pm_halt_aspm_l0s(cfg_pm_halt_aspm_l0s_rp),  //  logic cfg_pm_halt_aspm_l0s
    .cfg_pm_halt_aspm_l1(cfg_pm_halt_aspm_l1_rp),  //  logic cfg_pm_halt_aspm_l1
    .cfg_pm_force_state_en(cfg_pm_force_state_en_rp),  //  logic cfg_pm_force_state_en
    .cfg_pm_force_state(cfg_pm_force_state_rp),  //  logic [1 : 0] cfg_pm_force_state
    .cfg_dsn(cfg_dsn_rp),  //  logic [63 : 0] cfg_dsn
    .cfg_interrupt(cfg_interrupt_rp),  //  logic cfg_interrupt
    .cfg_interrupt_rdy(cfg_interrupt_rdy_rp),  //  logic cfg_interrupt_rdy
    .cfg_interrupt_assert(cfg_interrupt_assert_rp),  //  logic cfg_interrupt_assert
    .cfg_interrupt_di(cfg_interrupt_di_rp),  //  logic [7 : 0] cfg_interrupt_di
    .cfg_interrupt_do(cfg_interrupt_do_rp),  //  logic [7 : 0] cfg_interrupt_do
    .cfg_interrupt_mmenable(cfg_interrupt_mmenable_rp),  //  logic [2 : 0] cfg_interrupt_mmenable
    .cfg_interrupt_msienable(cfg_interrupt_msienable_rp),  //  logic cfg_interrupt_msienable
    .cfg_interrupt_msixenable(cfg_interrupt_msixenable_rp),  //  logic cfg_interrupt_msixenable
    .cfg_interrupt_msixfm(cfg_interrupt_msixfm_rp),  //  logic cfg_interrupt_msixfm
    .cfg_interrupt_stat(cfg_interrupt_stat_rp),  //  logic cfg_interrupt_stat
    .cfg_pciecap_interrupt_msgnum(cfg_pciecap_interrupt_msgnum_rp),                              //  logic [4 : 0] cfg_pciecap_interrupt_msgnum
    .cfg_to_turnoff(cfg_to_turnoff_rp),  //  logic cfg_to_turnoff
    .cfg_turnoff_ok(cfg_turnoff_ok_rp),  //  logic cfg_turnoff_ok
    .cfg_bus_number(cfg_bus_number_rp),  //  logic [7 : 0] cfg_bus_number
    .cfg_device_number(cfg_device_number_rp),  //  logic [4 : 0] cfg_device_number
    .cfg_function_number(cfg_function_number_rp),  //  logic [2 : 0] cfg_function_number
    .cfg_pm_wake(cfg_pm_wake_rp),  //  logic cfg_pm_wake
    .cfg_pm_send_pme_to(cfg_pm_send_pme_to_rp),  //  logic cfg_pm_send_pme_to
    .cfg_ds_bus_number(cfg_ds_bus_number_rp),  //  logic [7 : 0] cfg_ds_bus_number
    .cfg_ds_device_number(cfg_ds_device_number_rp),  //  logic [4 : 0] cfg_ds_device_number
    .cfg_ds_function_number(cfg_ds_function_number_rp),  //  logic [2 : 0] cfg_ds_function_number
    .cfg_mgmt_wr_rw1c_as_rw(cfg_mgmt_wr_rw1c_as_rw_rp),  //  logic cfg_mgmt_wr_rw1c_as_rw
    .cfg_msg_received(cfg_msg_received_rp),  //  logic cfg_msg_received
    .cfg_msg_data(cfg_msg_data_rp),  //  logic [15 : 0] cfg_msg_data
    .cfg_bridge_serr_en(cfg_bridge_serr_en_rp),  //  logic cfg_bridge_serr_en
    .cfg_slot_control_electromech_il_ctl_pulse(cfg_slot_control_electromech_il_ctl_pulse_rp),    //  logic cfg_slot_control_electromech_il_ctl_pulse
    .cfg_root_control_syserr_corr_err_en(cfg_root_control_syserr_corr_err_en_rp),                //  logic cfg_root_control_syserr_corr_err_en
    .cfg_root_control_syserr_non_fatal_err_en(cfg_root_control_syserr_non_fatal_err_en_rp),      //  logic cfg_root_control_syserr_non_fatal_err_en
    .cfg_root_control_syserr_fatal_err_en(cfg_root_control_syserr_fatal_err_en_rp),              //  logic cfg_root_control_syserr_fatal_err_en
    .cfg_root_control_pme_int_en(cfg_root_control_pme_int_en_rp),                                //  logic cfg_root_control_pme_int_en
    .cfg_aer_rooterr_corr_err_reporting_en(cfg_aer_rooterr_corr_err_reporting_en_rp),            //  logic cfg_aer_rooterr_corr_err_reporting_en
    .cfg_aer_rooterr_non_fatal_err_reporting_en(cfg_aer_rooterr_non_fatal_err_reporting_en_rp),  //  logic cfg_aer_rooterr_non_fatal_err_reporting_en
    .cfg_aer_rooterr_fatal_err_reporting_en(cfg_aer_rooterr_fatal_err_reporting_en_rp),          //  logic cfg_aer_rooterr_fatal_err_reporting_en
    .cfg_aer_rooterr_corr_err_received(cfg_aer_rooterr_corr_err_received_rp),                    //  logic cfg_aer_rooterr_corr_err_received
    .cfg_aer_rooterr_non_fatal_err_received(cfg_aer_rooterr_non_fatal_err_received_rp),          //  logic cfg_aer_rooterr_non_fatal_err_received
    .cfg_aer_rooterr_fatal_err_received(cfg_aer_rooterr_fatal_err_received_rp),                  //  logic cfg_aer_rooterr_fatal_err_received
    .cfg_msg_received_err_cor(cfg_msg_received_err_cor_rp),  //  logic cfg_msg_received_err_cor
    .cfg_msg_received_err_non_fatal(cfg_msg_received_err_non_fatal_rp),                          //  logic cfg_msg_received_err_non_fatal
    .cfg_msg_received_err_fatal(cfg_msg_received_err_fatal_rp),                                  //  logic cfg_msg_received_err_fatal
    .cfg_msg_received_pm_as_nak(cfg_msg_received_pm_as_nak_rp),                                  //  logic cfg_msg_received_pm_as_nak
    .cfg_msg_received_pm_pme(cfg_msg_received_pm_pme_rp),  //  logic cfg_msg_received_pm_pme
    .cfg_msg_received_pme_to_ack(cfg_msg_received_pme_to_ack_rp),                                //  logic cfg_msg_received_pme_to_ack
    .cfg_msg_received_assert_int_a(cfg_msg_received_assert_int_a_rp),                            //  logic cfg_msg_received_assert_int_a
    .cfg_msg_received_assert_int_b(cfg_msg_received_assert_int_b_rp),                            //  logic cfg_msg_received_assert_int_b
    .cfg_msg_received_assert_int_c(cfg_msg_received_assert_int_c_rp),                            //  logic cfg_msg_received_assert_int_c
    .cfg_msg_received_assert_int_d(cfg_msg_received_assert_int_d_rp),                            //  logic cfg_msg_received_assert_int_d
    .cfg_msg_received_deassert_int_a(cfg_msg_received_deassert_int_a_rp),                        //  logic cfg_msg_received_deassert_int_a
    .cfg_msg_received_deassert_int_b(cfg_msg_received_deassert_int_b_rp),                        //  logic cfg_msg_received_deassert_int_b
    .cfg_msg_received_deassert_int_c(cfg_msg_received_deassert_int_c_rp),                        //  logic cfg_msg_received_deassert_int_c
    .cfg_msg_received_deassert_int_d(cfg_msg_received_deassert_int_d_rp),                        //  logic cfg_msg_received_deassert_int_d
    .cfg_msg_received_setslotpowerlimit(cfg_msg_received_setslotpowerlimit_rp),                  //  logic cfg_msg_received_setslotpowerlimit
    .pl_directed_link_change(pl_directed_link_change_rp),  //  logic [1 : 0] pl_directed_link_change
    .pl_directed_link_width(pl_directed_link_width_rp),  //  logic [1 : 0] pl_directed_link_width
    .pl_directed_link_speed(pl_directed_link_speed_rp),  //  logic pl_directed_link_speed
    .pl_directed_link_auton(pl_directed_link_auton_rp),  //  logic pl_directed_link_auton
    .pl_upstream_prefer_deemph(pl_upstream_prefer_deemph_rp),  //  logic pl_upstream_prefer_deemph
    .pl_sel_lnk_rate(pl_sel_lnk_rate_rp),  //  logic pl_sel_lnk_rate
    .pl_sel_lnk_width(pl_sel_lnk_width_rp),  //  logic [1 : 0] pl_sel_lnk_width
    .pl_ltssm_state(pl_ltssm_state_rp),  //  logic [5 : 0] pl_ltssm_state
    .pl_lane_reversal_mode(pl_lane_reversal_mode_rp),  //  logic [1 : 0] pl_lane_reversal_mode
    .pl_phy_lnk_up(pl_phy_lnk_up_rp),  //  logic pl_phy_lnk_up
    .pl_tx_pm_state(pl_tx_pm_state_rp),  //  logic [2 : 0] pl_tx_pm_state
    .pl_rx_pm_state(pl_rx_pm_state_rp),  //  logic [1 : 0] pl_rx_pm_state
    .pl_link_upcfg_cap(pl_link_upcfg_cap_rp),  //  logic pl_link_upcfg_cap
    .pl_link_gen2_cap(pl_link_gen2_cap_rp),  //  logic pl_link_gen2_cap
    .pl_link_partner_gen2_supported(pl_link_partner_gen2_supported_rp),                          //  logic pl_link_partner_gen2_supported
    .pl_initial_link_width(pl_initial_link_width_rp),  //  logic [2 : 0] pl_initial_link_width
    .pl_directed_change_done(pl_directed_change_done_rp),  //  logic pl_directed_change_done
    .pl_received_hot_rst(pl_received_hot_rst_rp),  //  logic pl_received_hot_rst
    .pl_transmit_hot_rst(pl_transmit_hot_rst_rp),  //  logic pl_transmit_hot_rst
    .pl_downstream_deemph_source(pl_downstream_deemph_source_rp),                                //  logic pl_downstream_deemph_source
    .cfg_err_aer_headerlog(cfg_err_aer_headerlog_rp),  //  logic [127 : 0] cfg_err_aer_headerlog
    .cfg_aer_interrupt_msgnum(cfg_aer_interrupt_msgnum_rp),                                      //  logic [4 : 0] cfg_aer_interrupt_msgnum
    .cfg_err_aer_headerlog_set(cfg_err_aer_headerlog_set_rp),  //  logic cfg_err_aer_headerlog_set
    .cfg_aer_ecrc_check_en(cfg_aer_ecrc_check_en_rp),  //  logic cfg_aer_ecrc_check_en
    .cfg_aer_ecrc_gen_en(cfg_aer_ecrc_gen_en_rp),  //  logic cfg_aer_ecrc_gen_en
    .cfg_vc_tcvc_map(cfg_vc_tcvc_map_rp),  //  logic [6 : 0] cfg_vc_tcvc_map
    .sys_clk(sys_clk),
    .sys_rst_n(sys_rst_n)  //  logic sys_rst_n
  );

endmodule
