/*
 * This file is part of the GROMACS-PyAPI package.
 *
 * Copyright (c) 2014,2015,
 * by Maks Koltsov <maks@omrb.pnpi.spb.ru> and
 * by Alexey Shvetsov <alexxy@omrb.pnpi.spb.ru>
 *
 * GROMACS-PyAPI is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public License
 * as published by the Free Software Foundation; either version 2.1
 * of the License, or (at your option) any later version.
 *
 * GROMACS-PyAPI is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with GROMACS; if not, see
 * http://www.gnu.org/licenses, or write to the Free Software Foundation,
 * Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA.
 */

%ModuleHeaderCode
#include "gromacs/options/abstractoption.h"
#include "gromacs/selection/selectionoption.h"
typedef gmx::OptionTemplate < gmx::Selection, gmx::SelectionOption > SelectionOptionTemplate;
%End

typedef OptionTemplate < Selection, SelectionOption > SelectionOptionTemplate;

class SelectionOption: SelectionOptionTemplate /NoDefaultCtors/ {
    %TypeHeaderCode
#include "gromacs/selection/selectionoption.h"
    using namespace gmx;
    %End

    public:
        SelectionOption &evaluateVelocities();
        SelectionOption &evaluateForces();
        SelectionOption &onlyAtoms();
        SelectionOption &onlyStatic();
        SelectionOption &dynamicMask();
        SelectionOption &allowEmpty();
        SelectionOption &defaultSelectionText(const char*);
};
