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
import inet.base.NotificationBoard;
import inet.linklayer.ieee80211.mac.Ieee80211Mac;
import inet.linklayer.ieee80211.radio.Ieee80211Radio;
import inet.cognitive.CognitiveModule;

// Standard host module for a wireless MiXiM host with configurable NIC, and OSI 
// layers, and mobility module.

module cognitiveHost {
    @display("bgb=249,329");
    @node();
    string mobilityType;
    int numRadios = default(1);
    bool IPForward = default(true);
    string routingFile = default("");
    
    int numTcpApps = default(0);  // no of TCP apps. Specify the app types in INI file with tcpApp[0..1].typename="TCPEchoApp" syntax
    int numUdpApps = default(0);  // no of UDP apps. Specify the app types in INI file with udpApp[0..1].typename="UDPVideoStreamCli" syntax
    int numSctpApps = default(0); // no of SCTP apps. Specify the app types in INI file with sctpApp[0..1].typename="SCTPServer" syntax
    string tcpType = default(firstAvailable("TCP", "TCP_lwIP", "TCP_NSC", "TCP_None"));  // tcp implementation (e.g. ~TCP, ~TCP_lwIP, ~TCP_NSC) or ~TCPSpoof
    string udpType = default(firstAvailable("UDP","UDP_None"));
    string sctpType = default(firstAvailable("SCTP","SCTP_None"));
    
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
        
        //appl : UDPBasicBurst { }
        
        mac: Ieee80211Mac {
            @display("p=171,44");
        }

        cognitive: CognitiveModule {
            @display("p=171,152");
        }

		// Just One ATM
        //wlan[numRadios]: <default("Ieee80211Nic")> like IWirelessNic {
        radio: Ieee80211Radio {
            parameters:
                @display("p=171,256;q=queue");
        }

    connections allowunconnected:
        //appl.udpOut --> mac.upperLayerIn;
        //appl.udpIn <-- mac.upperLayerOut;

        mac.lowerLayerOut --> cognitive.upperLayerIn;
        mac.lowerLayerIn <-- cognitive.upperLayerOut;

        cognitive.lowerLayerOut1 --> radio.upperLayerIn;
        cognitive.lowerLayerIn1 <-- radio.upperLayerOut;

        radioIn --> radio.radioIn;
}