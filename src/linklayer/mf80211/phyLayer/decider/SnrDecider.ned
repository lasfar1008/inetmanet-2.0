//***************************************************************************
// * file:        SnrDecider.ned
// *
// * author:      Marc Loebbers
// *
// * copyright:   (C) 2004 Telecommunication Networks Group (TKN) at
// *              Technische Universitaet Berlin, Germany.
// *
// *              This program is free software; you can redistribute it
// *              and/or modify it under the terms of the GNU General Public
// *              License as published by the Free Software Foundation; either
// *              version 2 of the License, or (at your option) any later
// *              version.
// *              For further information see file COPYING
// *              in the top level directory
// ***************************************************************************
// * part of:     framework implementation developed by tkn
// **************************************************************************/


package inet.linklayer.mf80211.phyLayer.decider;

//
// Decider module to be used with ~SnrEval
//
// This component has been taken over from Mobility Framework 1.0a5.
//
simple SnrDecider
{
    parameters:
        bool debug = default(false); // debug switch
        double snrThresholdLevel @unit("dB");
        @display("i=box2_s");
    gates:
        output upperLayerOut;
        input lowerLayerIn;
}
