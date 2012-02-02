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

#ifndef COGNITIVEMODULE_H_
#define COGNITIVEMODULE_H_

#include <omnetpp.h>
#include <cmessage.h>
#include <BaseModule.h>

class CognitiveModule : public BaseModule {
	public:
		CognitiveModule();
		virtual ~CognitiveModule();
	protected:
        int lowerLayerIn1;
        int lowerLayerIn2;
        int lowerLayerOut1;
        int lowerLayerOut2;
        int upperLayerIn;
        int upperLayerOut;

        int lowerControlIn1;
        int lowerControlIn2;
        int lowerControlOut1;
        int lowerControlOut2;
        int upperControlIn;
        int upperControlOut;


		void initialize(int stage);
		void handleMessage(cMessage *msg);
		void handleUpperMsg(cMessage *msg);
		void handleLowerMsg(cMessage *msg);
		void handleSelfMsg(cMessage*);
		void handleLowerControl(cMessage* msg);
		void handleUpperControl(cMessage*);
};

#endif /* COGNITIVEMODULE_H_ */
