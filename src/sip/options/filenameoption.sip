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
#include "gromacs/options/filenameoption.h"
#include "gromacs/fileio/filetypes.h"
typedef gmx::OptionTemplate < std::string, gmx::FileNameOption > FileNameOptionTemplate;
using namespace gmx; // needed for compilation of enum
%End

typedef OptionTemplate < std::string, FileNameOption > FileNameOptionTemplate;

enum OptionFileType {
    eftUnknown, eftTopology, eftTrajectory, eftPDB,
    eftIndex, eftPlot, eftGenericData, eftOptionFileType_NR
};

enum {
    efMDP,
    efTRX, efTRO, efTRN, efTRR, efCOMPRESSED, efXTC, efTNG,
    efEDR,
    efSTX, efSTO, efGRO, efG96, efPDB, efBRK, efENT, efESP, efPQR,
    efCPT,
    efLOG, efXVG, efOUT,
    efNDX,
    efTOP, efITP,
    efTPS, efTPR,
    efTEX, efRTP, efATP, efHDB,
    efDAT, efDLG,
    efMAP, efEPS, efMAT, efM2P,
    efMTX,
    efEDI,
    efCUB,
    efXPM,
    efRND,
    efNR
};

class FileNameOption: FileNameOptionTemplate /NoDefaultCtors/ {
    %TypeHeaderCode
#include "gromacs/options/filenameoption.h"
    using gmx::FileNameOption;
    %End
    public:
        FileNameOption &filetype(OptionFileType);
        FileNameOption &legacyType(int);
        FileNameOption &inputFile();
        FileNameOption &outputFile();
        FileNameOption &inputOutputFile();
        FileNameOption &readWriteFlags(bool, bool);
        FileNameOption &libraryFile(bool = true);
        FileNameOption &defaultBasename(const char* /KeepReference/);
        FileNameOption &defaultType(int);
};

class FileNameOptionManager: public IOptionManager /NoDefaultCtors/ {
    %TypeHeaderCode
#include <gromacs/options/filenameoptionmanager.h>
    %End
    public:
        FileNameOptionManager();
};
