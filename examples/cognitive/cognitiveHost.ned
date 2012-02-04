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
import inet.linklayer.mf80211.phyLayer.snrEval.SnrEval80211;
import inet.linklayer.mf80211.phyLayer.decider.Decider80211;
import inet.linklayer.mf80211.macLayer.Mac80211;
import inet.cognitive.CognitiveModule;
import inet.cognitive.SnrEvalCognitive;
import inet.networklayer.common.InterfaceTable;

import inet.nodes.inet.NetworkLayer;
import inet.applications.udpapp.UDPBasicBurst;
import inet.networklayer.ipv4.RoutingTable;

// Standard host module for a wireless MiXiM host with configurable NIC, and OSI 
// layers, and mobility module.

module cognitiveHost
{
    @display("bgb=291,531");
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
                @display("p=53,339");
        }

        // optional mobility module. Required only if wireless cards are present
        mobility: <mobilityType> like IMobility if mobilityType != "" && numRadios > 0 {
            parameters:
                @display("p=53,233");
        }

		interfaceTable: InterfaceTable {
            @display("p=53,127");
        }

//        appl: UDPBasicBurst {
//
//            @display("p=173,29");
//        }
        
        netwl: NetworkLayer {
            parameters:
            	@display("p=173,127");
            	proxyARP = false;
            gates:
                ifIn[1];
                ifOut[1];
        }
        routingTable: RoutingTable {
            parameters:
            	@display("p=53,29");
            	IPForward = true;
            	routerId = "";
            	routingFile = "";
        }

        mac: Mac80211 {
            parameters:
                @display("p=173,233");
        }
        decider: Decider80211 {
            parameters:
                @display("p=204,405");
        }

        cognitive: CognitiveModule {
            @display("p=173,339");
        }

		// Just One ATM
        //wlan[numRadios]: <default("Ieee80211Nic")> like IWirelessNic {
        radio: SnrEvalCognitive {
            parameters:
                @display("p=173,467;q=queue");
        }

    connections allowunconnected:
//        appl.udpOut --> netwl.udpIn;
//        appl.udpIn <-- netwl.udpOut;
        
        mac.upperLayerIn <-- netwl.ifOut[0];
        mac.upperLayerOut --> netwl.ifIn[0];

        mac.lowerLayerOut --> cognitive.upperLayerIn;
        mac.lowerLayerIn <-- cognitive.upperLayerOut;

        decider.lowerLayerIn <-- radio.upperLayerOut;
        cognitive.lowerLayerIn1 <-- decider.upperLayerOut;

        radioIn --> radio.radioIn;
}
