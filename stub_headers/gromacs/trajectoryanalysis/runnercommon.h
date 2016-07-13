#ifndef RUNNERCOMMON_H
#define RUNNERCOMMON_h

namespace gmx {
class ITopologyProvider;
class TrajectoryAnalysisRunnerCommon {
    public:
    explicit TrajectoryAnalysisRunnerCommon(TrajectoryAnalysisSettings*);
    ~TrajectoryAnalysisRunnerCommon();

    ITopologyProvider *topologyProvider();

    void initOptions(IOptionsContainer*, TimeUnitBehavior*);
    void optionsFinished();
    void initTopology();
    void initFirstFrame();
    void initFrameIndexGroup();
    bool readNextFrame();
    void initFrame();

    bool hasTrajectory() const;
    const TopologyInformation &topologyInformation() const;
    t_trxframe &frame() const;
};
}

#endif
