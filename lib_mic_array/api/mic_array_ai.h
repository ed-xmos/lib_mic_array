// Copyright (c) 2020, XMOS Ltd, All rights reserved
#ifndef _MIC_ARRAY_AI_H_
#define _MIC_ARRAY_AI_H_

#include <stdint.h>
#include "mic_array_frame.h"

#ifdef __XC__
void mic_dual_pdm_rx_decimate(
        buffered in port:32 p_pdm_mics,
        streaming chanend c_2x_pdm_mic,
        streaming chanend c_ref_audio[]);
#else
void mic_dual_pdm_rx_decimate(
        port_t p_pdm_mics,
        chanend_t c_2x_pdm_mic,
        chanend_t c_ref_audio[]);
#endif



#endif /* _MIC_ARRAY_AI_H_ */
