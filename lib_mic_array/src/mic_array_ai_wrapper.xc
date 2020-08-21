#include <xs1.h>
#include <platform.h>
#include <print.h>
#include "mic_array.h"
#include "mic_array_ai.h"

on tile[1]: in port p_mclk_in = XS1_PORT_1D;
on tile[1]: out port p_pdm_clk = XS1_PORT_1G;
on tile[1]: clock pdm_clk = XS1_CLKBLK_1;
on tile[1]: clock pdm_clk6 = XS1_CLKBLK_2;

void setup_ddr_mic_array(in buffered port:32 mics)
{
    configure_port_clock_output(p_pdm_clk, pdm_clk);
    configure_in_port(mics, pdm_clk6);

    start_clock(pdm_clk6); /* start the faster capture clock */
    partin(mics, 4); /* wait for a rising edge on the capture clock */
    start_clock(pdm_clk); /* start the slower output clock */

    /*
     * this results in the rising edge of the capture clock
     * leading the rising edge of the output clock by one period
     * of p_mclk_in, which is about 40.7 ns for the typical frequency
     * of 24.576 megahertz.
     * This should fall within the data valid window.
     */
}

void audio_frontend_init(in buffered port:32 mics)
{
    int mclk_in_to_pdm_clk_divider = 4/2; // 24.576 / 4 = 6.144

    // We are I2S slave so must be _INT build, use ext MCLK
    int divider_ddr = mclk_in_to_pdm_clk_divider;
    int divider_sdr = mclk_in_to_pdm_clk_divider == 0 ? 1 : mclk_in_to_pdm_clk_divider * 2;

    printintln(divider_ddr);
    printintln(divider_sdr);

    configure_clock_src_divide(pdm_clk6, p_mclk_in, divider_ddr); // 6.144MHz
    configure_clock_src_divide(pdm_clk, p_mclk_in, divider_sdr); // 3.072MHz
    
    setup_ddr_mic_array(mics);
}

void mic_dual_pdm_rx_decimate_ai(buffered in port:32 p_pdm_mic, streaming chanend c_2x_pdm_mic, streaming chanend c_ref_audio[]){
    audio_frontend_init(p_pdm_mic);
    mic_dual_pdm_rx_decimate(p_pdm_mic, c_2x_pdm_mic, c_ref_audio);
}

