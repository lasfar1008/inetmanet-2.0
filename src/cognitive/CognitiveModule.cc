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

#include "CognitiveModule.h"

Define_Module(CognitiveModule);

CognitiveModule::CognitiveModule() {
	// TODO Auto-generated constructor stub
}

CognitiveModule::~CognitiveModule() {
	// TODO Auto-generated destructor stub
}

void CognitiveModule::initialize(int stage) {
	if (stage == 0) {
		EV << "Initializing stage 0";

        lowerLayerIn1  = findGate("lowerLayerIn1");
        lowerLayerIn2  = findGate("lowerLayerIn2");
        lowerLayerOut1  = findGate("lowerLayerOut1");
        lowerLayerOut2  = findGate("lowerLayerOut2");

        upperLayerIn  = findGate("upperLayerIn");
        upperLayerOut  = findGate("upperLayerOut");

        lowerControlIn1 = findGate("lowerControlIn1");
        lowerControlIn2 = findGate("lowerControlIn2");
        lowerControlOut1 = findGate("lowerControlOut1");
        lowerControlOut2 = findGate("lowerControlOut2");

        upperControlIn = findGate("upperControlIn");
        upperControlOut = findGate("upperControlOut");

	} else if (stage == 1) {

	}
}

void CognitiveModule::handleUpperMsg(cMessage *msg) {
	// A message from the MAC has arrived. Select the radio which will send it.
	// TODO
	// For now, send it to the first radio
	send(msg, lowerLayerOut1);
}

void CognitiveModule::handleLowerMsg(cMessage *msg) {
	// A message has arrived. Pass it to the MAC layer.
	send(msg, upperLayerOut);
}

void CognitiveModule::handleMessage(cMessage* msg) {
if (msg->isSelfMessage()){
        handleSelfMsg(msg);
    } else if(msg->getArrivalGateId()==upperLayerIn) {
        //recordPacket(PassedMessage::INCOMING,PassedMessage::UPPER_DATA,msg);
        handleUpperMsg(msg);
    } else if(msg->getArrivalGateId()==upperControlIn) {
        //recordPacket(PassedMessage::INCOMING,PassedMessage::UPPER_CONTROL,msg);
        handleUpperControl(msg);
    } else if(msg->getArrivalGateId()==lowerControlIn1 || msg->getArrivalGateId()==lowerControlIn2){
        //recordPacket(PassedMessage::INCOMING,PassedMessage::LOWER_CONTROL,msg);
        handleLowerControl(msg);
    } else if(msg->getArrivalGateId()==lowerLayerIn1 || msg->getArrivalGateId()==lowerLayerIn2) {
        //recordPacket(PassedMessage::INCOMING,PassedMessage::LOWER_DATA,msg);
        handleLowerMsg(msg);
    }
    else if(msg->getArrivalGateId()==-1) {
        /* Classes extending this class may not use all the gates, f.e.
         * BaseApplLayer has no upper gates. In this case all upper gate-
         * handles are initialized to -1. When getArrivalGateId() equals -1,
         * it would be wrong to forward the message to one of these gates,
         * as they actually don't exist, so raise an error instead.
         */
        opp_error("No self message and no gateID?? Check configuration.");
    } else {
        /* msg->getArrivalGateId() should be valid, but it isn't recognized
         * here. This could signal the case that this class is extended
         * with extra gates, but handleMessage() isn't overridden to
         * check for the new gate(s).
         */
        opp_error("Unknown gateID?? Check configuration or override handleMessage().");
    }
}

void CognitiveModule::handleSelfMsg(cMessage* msg) {
	//error(msg->getName());
}

void CognitiveModule::handleLowerControl(cMessage* msg) {
	//error(msg->getName());
	send(msg,upperControlOut);
}

void CognitiveModule::handleUpperControl(cMessage* msg) {
	send(msg,lowerControlOut1);
}
