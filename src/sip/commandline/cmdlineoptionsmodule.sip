/*
 * This file is part of the GROMACS-PyAPI package.
 *
 * Copyright (c) 2016,2014,2015,
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

class ICommandLineOptionsModuleSettings /NoDefaultCtors/ {
    %TypeHeaderCode
#include <gromacs/utility/arrayref.h>
#include <gromacs/commandline/cmdlineoptionsmodule.h>
    using gmx::ICommandLineOptionsModuleSettings;
    %End
    public:
        virtual void setHelpText(const char *help) = 0;
        %MethodCode
        const char *const helpText[] = {a0};
        sipCpp->setHelpText(helpText);
        %End
        virtual void addOptionsBehavior(
            IOptionsBehavior *behavior /Transfer/) = 0;
        %MethodCode
        sipCpp->addOptionsBehavior(std::shared_ptr < IOptionsBehavior > (a0));
        %End
    private:
        virtual ~ICommandLineOptionsModuleSettings();
};

// This class is needed by Pipeline python implementation.
// ICommandLineOptionsModuleSettings can't be subclassed in Python
// due to private destructor, so subclass it here.

%ModuleHeaderCode
#include <gromacs/commandline/cmdlineoptionsmodule.h>
#include <memory>

namespace pygmx {
    class DummyOptionsModuleSettings: public gmx::ICommandLineOptionsModuleSettings {
        public:
            virtual void setHelpText(const gmx::ConstArrayRef < const char* > &) {};
            virtual void addOptionsBehavior(const std::shared_ptr < gmx::IOptionsBehavior > &) {};
    };
}
%End

class DummyOptionsModuleSettings: public ICommandLineOptionsModuleSettings {
    %TypeHeaderCode
#include <gromacs/commandline/cmdlineoptionsmodule.h>
    using gmx::ICommandLineOptionsModuleSettings;
    using pygmx::DummyOptionsModuleSettings;
    %End
    private:
        virtual void setHelpText(const char *);
        virtual void addOptionsBehavior(IOptionsBehavior* /Transfer/);
};

class CommandLineModuleSettings /NoDefaultCtors/ {
    %TypeHeaderCode
#include <gromacs/commandline/cmdlinemodule.h>
    using gmx::CommandLineModuleSettings;
    %End
};

class ICommandLineOptionsModule /VirtualErrorHandler = vehandler/ {
    %TypeHeaderCode
#include <gromacs/commandline/cmdlineoptionsmodule.h>
    using gmx::ICommandLineOptionsModule;
    %End
    public:
        virtual void init(CommandLineModuleSettings *settings) = 0;
        virtual void initOptions(IOptionsContainer *options, ICommandLineOptionsModuleSettings *settings) = 0;
        virtual void optionsFinished() = 0;
        virtual int run()              = 0;
        static int runAsMain(SIP_PYOBJECT mod, SIP_PYLIST argv, const char *name, const char *description);
        %MethodCode
        auto runner = [a0, a2, a3] (int argc, char **argv)->int {
            return ICommandLineOptionsModule::runAsMain(argc, argv, a2, a3, PyFactory < gmx::ICommandLineOptionsModule > (sipType_ICommandLineOptionsModule, a0));
        };
        sipRes = argv_wrapper(a1, runner);
        %End
};
