//
// author: Thomas Reschka
//

package inet.examples.inet.tcpwindowscale;

import ned.DatarateChannel;
import inet.nodes.inet.StandardHost;

network tcpwindowscale {
    parameters:
        @display("bgb=400,200");
    submodules:
        client: StandardHost {
            parameters:
                @display("p=50,100");
            gates:
                pppg[1];
        }
        server: StandardHost {
            parameters:
                @display("p=350,100;i=device/server");
            gates:
                pppg[1];
        }
    connections:
        client.pppg[0] <--> LFNPath <--> server.pppg[0];
}

channel LFNPath extends DatarateChannel {
    parameters:
        datarate = 1Gbps;
        delay = 565ms;
        per = 0;
        ber = 0;
}
