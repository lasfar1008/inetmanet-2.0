//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Lesser General Public License for more details.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with this program.  If not, see http://www.gnu.org/licenses/.
// 

package inet.examples.cognitive;

import inet.mobility.IMobility;
import inet.linklayer.IWirelessNic;
import inet.base.NotificationBoard;
import inet.linklayer.mf80211.macLayer.Mac80211;
import inet.cognitive.CognitiveModule;

// Standard host module for a wireless MiXiM host with configurable NIC, and OSI 
// layers, and mobility module.

module cognitiveHost
{
    @display("bgb=249,329");
    gates:
        // Just One ATM
        //input radioIn[numRadios] @directIn;
        input radioIn @directIn;
    submodules:
        notificationBoard: NotificationBoard {
            parameters:
                @display("p=53,194");
        }

        // optional mobility module. Required only if wireless cards are present
        mobility: <mobilityType> like IMobility if mobilityType != "" && numRadios > 0 {
            parameters:
                @display("p=53,121");
        }

        mac: Mac80211 {

            @display("p=171,44");
        }

        cognitive: CognitiveModule {

            @display("p=171,152");
        }

		// Just One ATM
        //wlan[numRadios]: <default("Ieee80211Nic")> like IWirelessNic {
        nic1: <default("Ieee80211Nic")> like IWirelessNic {
            parameters:
                @display("p=171,256;q=queue");
        }

    connections:
        //appl.lowerLayerOut --> mac.upperLayerIn;
        //appl.lowerLayerIn <-- mac.upperLayerOut;
        //appl.lowerControlOut --> mac.upperControlIn;
        //appl.lowerControlIn <-- mac.upperControlOut;
        mac.lowerLayerOut --> cognitive.upperLayerIn;
        mac.lowerLayerIn <-- cognitive.upperLayerOut;

        cognitive.lowerLayerOut1 --> nic1.upperLayerIn;
        //cognitive.lowerLayerOut2 --> nic2.upperLayerIn;
        cognitive.lowerLayerIn1 <-- nic1.upperLayerOut;
        //cognitive.lowerLayerIn2 <-- nic2.upperLayerOut;
        //cognitive.lowerControlOut1 --> nic1.upperControlIn;
        //cognitive.lowerControlOut2 --> nic2.upperControlIn;
        //cognitive.lowerControlIn1 <-- nic1.upperControlOut;
        //cognitive.lowerControlIn2 <-- nic2.upperControlOut;

        radioIn --> nic1.radioIn;
        //radioInNotUsed --> nic2.radioIn;

}
