/*
 * This file is part of the GROMACS-PyAPI package.
 *
 * Copyright (c) 2014,2015,2016,2014,2015,
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

#ifndef NUMPY_CONV_H
#define NUMPY_CONV_H

#include <Python.h>
#include <numpy/ndarrayobject.h>

PyObject* array2dToNumpy(int dim1, int dim2, const void *data)
{
    npy_intp dims[] = {dim1, dim2};
    #if GMX_DOUBLE == 1
    return PyArray_SimpleNewFromData(2, dims, NPY_DOUBLE, (double*) data);
    #else
    return PyArray_SimpleNewFromData(2, dims, NPY_FLOAT, (float*) data);
    #endif
}

PyObject* array1dToNumpy(int dim, const void *data)
{
    npy_intp n_dim = dim;
    #if GMX_DOUBLE == 1
    return PyArray_SimpleNewFromData(1, &n_dim, NPY_DOUBLE, (double*) data);
    #else
    return PyArray_SimpleNewFromData(1, &n_dim, NPY_FLOAT, (float*) data);
    #endif
}

PyObject* iarray1dToNumpy(int dim, const int *data)
{
    npy_intp n_dim = dim;
    return PyArray_SimpleNewFromData(1, &n_dim, NPY_INT, (int*) data);
}
#endif
