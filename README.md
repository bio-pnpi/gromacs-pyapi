GROMACS Python API project
==========================

This project provides Python wrappers for Gromacs trajectory analysis [framework][trjan].

You can find an example tool written with this framework in `examples/example_pyapi.py`.

We would be very grateful for any feedback at this very alpha stage of the project.

Building and installing
-----------------------

gromacs-pyapi has following dependencies:

* Gromacs (tested with 2016.x branch)
* CMake
* [SIP][sip] (confirmed to work with 4.19)

These should be present in repositories of any modern Linux distro.

To build do the following:

```console
$ mkdir build
$ cd build
$ cmake .. -DCMAKE_INSTALL_PREFIX=~/.local
$ make
$ make install
```

Of course, you can choose any install location you like.

By default, the bindings will be built with currently active Python version. Both Python 2 and Python 3 are supported.

Usage
--------

To use analysis framework, you need to subclass `gromacs.TrajectoryAnalysis.TrajectoryAnalysisModule` and override all virtual methods as stated in Gromacs documentation. To run the tool, provide an instance of your module to `TrajectoryAnalysis.TrajectoryAnalysisCommandLineRunner.runAsMain` function. All this boilerplate code can be copied from the example.

When run, the script will behave exactly like any other `gmx` tool, accepting the same set of command-line options. Module specific options can be provided in `initOptions` method with use of `gromacs.Options.PyOptionsHolder` class. This class is needed to overcome impossibilities to directly wrap gromacs `Options` framework in Python.

`PyOptionHolder` class has several static methods:

* `doubleOption`
* `integerOption`
* `stringOption`
* `booleanOption`
* `selectionOption`
* `fileNameOption`

All of these methods accept three arguments: `name`, `count` and `default`. Only name is mandatory, `count` is 1 by default.
If `count` is zero, the option will accept an unlimited number of values. If `count` is greater than zero, the option will accept exactly `count` values.

You should store an instance of `PyOptionsHolder` class in your module's instance field and later access options values by name with `[]` operator. In other words, this class will behave as a dictionary.

This option framework may change in the future.

NumPy
----------

All data sent from C++ side is not copied into Python memory. Instead, a memory view of some sort is returned. For topology, frames and selections all coordinate, velocity, etc. vectors are provided as NumPy arrays directly on top of C++ arrays allocated by Gromacs. This means that actual references to these arrays are only valid during current fuction call, e.g. `analyzeFrame`. If you try to store an array and use it later, you may get a segmentation fault or you may access not the array you were expecting, because of memory re-writing. If you need to store this data for later use, allocate your own array and make a copy.

[trjan]: http://manual.gromacs.org/documentation/2016.3/doxygen/html-user/page_analysisframework.xhtml
[sip]: https://www.riverbankcomputing.com/software/sip/intro
