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

// This class is needed to transparently map 'atomname' and similar fields of struct t_atoms.
// Avoids copying and mapping entire array to python.

%ModuleHeaderCode
class PStringListWrapper {
    public:
        PStringListWrapper(char ***stringList, size_t size);
        const char* operator[] (size_t i);
    private:
        char     ***stringList;
        size_t      size;
};
%End

%ModuleCode
PStringListWrapper::PStringListWrapper(char ***stringList, size_t size) :
    stringList(stringList), size(size)
{}
const char* PStringListWrapper::operator[] (size_t i) {
    if (i >= size)
    {
        return NULL;
    }
    return *stringList[i];
}
%End

class PStringListWrapper /NoDefaultCtors/ {
    public:
        const char* operator[] (int i);
        %MethodCode
        sipRes = (*sipCpp)[a0];

        if (!sipRes)
        {
            SIP_BLOCK_THREADS;
            PyErr_SetString(PyExc_IndexError, "Index out of range");
            SIP_UNBLOCK_THREADS;
            sipIsErr = 1;
        }
        %End
};
