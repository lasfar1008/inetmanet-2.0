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

#ifndef SNREVALCOGNITIVE_H_
#define SNREVALCOGNITIVE_H_

#include "SnrEval80211.h"

class SnrEvalCognitive : public SnrEval80211 {
public:
	int getChannelNumber();
};

#endif /* SNREVALCOGNITIVE_H_ */
