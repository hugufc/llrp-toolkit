
/*
 ***************************************************************************
 *  Copyright 2007 Impinj, Inc.
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 *
 ***************************************************************************
 */


#include "ltkc_platform.h"
#include "ltkc_base.h"




void
LLRP_Decoder_destruct (
  LLRP_tSDecoder *              pDecoder)
{
    return pDecoder->pDecoderOps->pfDestruct(pDecoder);
}

LLRP_tSMessage *
LLRP_Decoder_decodeMessage (
  LLRP_tSDecoder *              pDecoder)
{
    return pDecoder->pDecoderOps->pfDecodeMessage(pDecoder);
}

void
LLRP_Encoder_destruct (
  LLRP_tSEncoder *              pEncoder)
{
    return pEncoder->pEncoderOps->pfDestruct(pEncoder);
}

void
LLRP_Encoder_encodeElement (
  LLRP_tSEncoder *              pEncoder,
  const LLRP_tSElement *        pElement)
{
    return pEncoder->pEncoderOps->pfEncodeElement(pEncoder, pElement);
}
