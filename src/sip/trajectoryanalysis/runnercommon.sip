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

// These classes belong to gromacs.Selection, but will remain here until
// t_trxframe and t_pbc are split from TrajectoryAnalysis
class SelectionCollection /NoDefaultCtors/ {
    %TypeHeaderCode
#include <gromacs/selection/selectioncollection.h>
    %End
    public:
        SelectionCollection();
        void evaluate(t_trxframe *fr, t_pbc *pbc);
        void evaluateFinal(int nframes);
};

class ITopologyProvider;
class SelectionOptionBehavior: public IOptionsBehavior /NoDefaultCtors/ {
    %TypeHeaderCode
#include <gromacs/selection/selectionoptionbehavior.h>
    using gmx::SelectionOptionBehavior;
    using gmx::ITopologyProvider;
    %End
    public:
        SelectionOptionBehavior(SelectionCollection *selections,
                                ITopologyProvider   *topologyProvider);
        void initOptions(IOptionsContainer *options);
        virtual void initBehavior(Options *options);
        virtual void optionsFinishing(Options *options);
        virtual void optionsFinished();
};

class TrajectoryAnalysisRunnerCommon /NoDefaultCtors/ {
    %TypeHeaderCode
#include <gromacs/trajectoryanalysis/runnercommon.h>
    %End
    public:
        explicit TrajectoryAnalysisRunnerCommon(TrajectoryAnalysisSettings *settings);
        ~TrajectoryAnalysisRunnerCommon();

        ITopologyProvider *topologyProvider();

        void initOptions(IOptionsContainer *options, TimeUnitBehavior *timeUnitBehavior);
        void optionsFinished();
        void initTopology();
        void initFirstFrame();
        void initFrameIndexGroup();
        bool readNextFrame();
        void initFrame();

        bool hasTrajectory() const;
        const TopologyInformation &topologyInformation() const;
        t_trxframe                &frame() const;
};
