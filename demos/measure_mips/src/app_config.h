// Copyright 2022 XMOS LIMITED.
// This Software is subject to the terms of the XMOS Public Licence: Version 1.

#pragma once


#ifndef APP_USE_PDM_RX_ISR
#  error "APP_USE_PDM_RX_ISR not defined."
#endif

#define SAMPLES_PER_FRAME         1

#define APP_AUDIO_CLOCK_FREQUENCY        24576000
#define APP_PDM_CLOCK_FREQUENCY          3072000
#define APP_I2S_AUDIO_SAMPLE_RATE        32000

#define MIC_ARRAY_CONFIG_MIC_IN_COUNT           8   // We use an 8b port
#define MIC_ARRAY_CONFIG_MIC_COUNT              6   // Of which we care about 4b

#define MIC_ARRAY_CLK1  XS1_CLKBLK_1
#define MIC_ARRAY_CLK2  XS1_CLKBLK_2
