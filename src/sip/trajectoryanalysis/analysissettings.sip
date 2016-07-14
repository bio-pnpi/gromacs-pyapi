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

class TrajectoryAnalysisSettings {
    %TypeHeaderCode
#include <gromacs/trajectoryanalysis/analysissettings.h>
    using namespace gmx;
    %End

    public:
        enum {
            efRequireTop  = 1,
            efUseTopX     = 2,
            efNoUserPBC   = 16,
            efNoUserRmPBC = 32
        };

        TrajectoryAnalysisSettings();
        void setOptionsModuleSettings(ICommandLineOptionsModuleSettings *settings);
        /*
           const TimeUnitManager& timeUnitManager() const;
           TimeUnit timeUnit();
           const AnalysisDataPlotSettings& plotSettings() const;
         */
        unsigned long flags() const;
        bool hasFlag(unsigned long flag) const;
        bool hasPBC() const;
        bool hasRmPBC() const;
        int frflags() const;
        void setFlags(unsigned long flags);
        void setFlag(unsigned long flag, bool bSet = true);
        void setPBC(bool bPBC);
        void setRmPBC(bool bRmPBC);
        void setFrameFlags(int frflags);
        void setHelpText(const char *helpText);
        %MethodCode
        const char *const helpText[] = {a0};
        sipCpp->setHelpText(helpText);
        %End
    private:
        TrajectoryAnalysisSettings(const TrajectoryAnalysisSettings &other);
};

class TopologyInformation {
    %TypeHeaderCode
#include <gromacs/trajectoryanalysis/analysissettings.h>
    using namespace gmx;
    %End
    public:
        bool hasTopology() const;
        bool hasFullTopology() const;
        t_topology* topology() const;
    private:
        TopologyInformation(const TopologyInformation &other);
        ~TopologyInformation();
};
