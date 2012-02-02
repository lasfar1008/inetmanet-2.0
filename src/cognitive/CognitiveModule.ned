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

package inet.cognitive;

simple CognitiveModule {
    @display("i=block/tunnel");
    gates:
        // Lower Layer
        input lowerLayerIn1;
        input lowerLayerIn2;
        output lowerLayerOut1;
        output lowerLayerOut2;

        // Upper Layer
        input upperLayerIn;
        output upperLayerOut;
        
        // Control
        input upperControlIn;
        output upperControlOut;
        input lowerControlIn1;
        input lowerControlIn2;
        output lowerControlOut1;
        output lowerControlOut2;
}