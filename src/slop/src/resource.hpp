/* resource.hpp: Handles getting resources like textures and stuff.
 *
 * Copyright (C) 2014: Dalton Nell, Slop Contributors (https://github.com/naelstrof/slop/graphs/contributors).
 *
 * This file is part of Slop.
 *
 * Slop is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Slop is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Slop.  If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef N_RESOURCE_H_
#define N_RESOURCE_H_

#include <stdexcept>
#include <stdlib.h>
#include <cassert>
#include <cstdio>
#include <string>
#include <unistd.h>
#include <sys/types.h>
#include <sys/param.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <pwd.h>

namespace slop {

class Resource {
public:
    Resource();
    std::string getRealPath( const std::string& localpath );
private:
    std::string dirname(const std::string& localpath);
    bool validatePath( const std::string& path );
    std::string usrconfig;
};

extern Resource* resource;

}

#endif // IS_RESOURCE_H_
