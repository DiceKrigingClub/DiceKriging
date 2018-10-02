/*
 *  DiceKriging/src/init.c by O. Roustant, D. Ginsbourger, Y.
 *  Deville. Contributors: C. Chevalier, Y. Richet.
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 or 3 of the License
 *  (at your option).
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  A copy of the GNU General Public License is available at
 *  http://www.r-project.org/Licenses/
 *
 */
#include <R.h>
#include "DiceKriging.h"
#include "R_ext/Rdynload.h"

static const R_CMethodDef CEntries[] = {
  {"C_covScalingFactor",  (DL_FUNC) &C_covScalingFactor, 1}, 
  {"C_covWhiteNoise",  (DL_FUNC) &C_covWhiteNoise, 10}, 
  {"C_covGauss", (DL_FUNC) &C_covGauss, 10},
  {"C_covExp", (DL_FUNC) &C_covExp, 10},
  {"C_covMatern3_2", (DL_FUNC) &C_covMatern3_2, 10},
  {"C_covMatern5_2", (DL_FUNC) &C_covMatern5_2, 10},
  {"C_covPowExp", (DL_FUNC) &C_covPowExp, 10},
  {"C_covMatrix", (DL_FUNC) &C_covMatrix, 7},
  {"C_covMat1Mat2", (DL_FUNC) &C_covMat1Mat2, 9},
  {"C_covGaussDerivative", (DL_FUNC) &C_covGaussDerivative, 9},
  {"C_covExpDerivative", (DL_FUNC) &C_covExpDerivative, 9},
  {"C_covMatern3_2Derivative", (DL_FUNC) &C_covMatern3_2Derivative, 9},
  {"C_covMatern5_2Derivative", (DL_FUNC) &C_covMatern5_2Derivative, 9},
  {"C_covPowExpDerivative", (DL_FUNC) &C_covPowExpDerivative, 9},
  {"C_covMatrixDerivative", (DL_FUNC) &C_covMatrixDerivative, 8},
  {"C_covGaussDerivative_dx", (DL_FUNC) &C_covGaussDerivative_dx, 9},
  {"C_covExpDerivative_dx", (DL_FUNC) &C_covExpDerivative_dx, 9},
  {"C_covMatern3_2Derivative_dx", (DL_FUNC) &C_covMatern3_2Derivative_dx, 9},
  {"C_covMatern5_2Derivative_dx", (DL_FUNC) &C_covMatern5_2Derivative_dx, 9},
  {"C_covPowExpDerivative_dx", (DL_FUNC) &C_covPowExpDerivative_dx, 9},
  {"C_covMatrixDerivative_dx", (DL_FUNC) &C_covMatrixDerivative_dx, 8},
  {"C_covGauss_dx", (DL_FUNC) &C_covGauss_dx, 8},
  {"C_covExp_dx", (DL_FUNC) &C_covExp_dx, 8},
  {"C_covMatern3_2_dx", (DL_FUNC) &C_covMatern3_2_dx, 8},
  {"C_covMatern5_2_dx", (DL_FUNC) &C_covMatern5_2_dx, 8},
  {"C_covPowExp_dx", (DL_FUNC) &C_covPowExp_dx, 8},
  {"C_covVector_dx", (DL_FUNC) &C_covVector_dx, 8},
  {"Scale", (DL_FUNC) &Scale, 6},
  {"Scale_dx", (DL_FUNC) &Scale_dx, 6},
  {"gradScale", (DL_FUNC) &gradScale, 6},
  {NULL, NULL, 0}
};

#include <Rversion.h>
void R_init_DiceKriging(DllInfo *dll)
{
    R_registerRoutines(dll, CEntries, NULL, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
#if defined(R_VERSION) && R_VERSION >= R_Version(2, 16, 0)
    R_forceSymbols(dll, TRUE);
#endif
}
