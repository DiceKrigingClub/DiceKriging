

double C_covScalingFactor(const char *type);

double C_covWhiteNoise(const double *x1, const int *n1,
		       const double *x2, const int *n2,
		       const int *d,
		       const int *i1, const int *i2,
		       const double *param,
		       const double *scaling_factor,
		       const double *var);

double C_covGauss(const double *x1, const int *n1,
		  const double *x2, const int *n2,
		  const int *d,
		  const int *i1, const int *i2,
		  const double *param,
		  const double *scaling_factor,
		  const double *var);

double C_covExp(const double *x1, const int *n1,
		const double *x2, const int *n2,
		const int *d,
		const int *i1, const int *i2,
		const double *param,
		const double *scaling_factor,
		const double *var);

double C_covMatern3_2(const double *x1, const int *n1,
		      const double *x2, const int *n2,
		      const int *d,
		      const int *i1, const int *i2,
		      const double *param,
		      const double *scaling_factor,
		      const double *var);

double C_covMatern5_2(const double *x1, const int *n1,
		      const double *x2, const int *n2,
		      const int *d,
		      const int *i1, const int *i2,
		      const double *param,
		      const double *scaling_factor,
		      const double *var);

double C_covPowExp(const double *x1, const int *n1,
		   const double *x2, const int *n2,
		   const int *d,
		   const int *i1, const int *i2,
		   const double *param,
		   const double *scaling_factor,
		   const double *var);

void C_covMatrix(const double *x, const int *n,
		 const int *d,
		 const double *param,
		 const double *var,
		 const char **type, double *ans);

void C_covMat1Mat2(const double *x1, const int *n1,
		   const double *x2, const int *n2,
		   const int *d,
		   const double *param, const double *var,
		   const char **type, double *ans);

double C_covGaussDerivative(const double *X, const int *n,
			    const int *d,
			    const int *i, const int *j,
			    const double *param,
			    const double *scaling_factor,
			    const int *k, const double *C);
	
double C_covExpDerivative(const double *X, const int *n,
			  const int *d,
			  const int *i, const int *j,
			  const double *param,
			  const double *scaling_factor,
			  const int *k, const double *C);

double C_covMatern3_2Derivative(const double *X, const int *n,
				const int *d,
				const int *i, const int *j,
				const double *param,
				const double *scaling_factor,
				const int *k, const double *C);

double C_covMatern5_2Derivative(const double *X, const int *n,
				const int *d,
				const int *i, const int *j,
				const double *param,
				const double *scaling_factor,
				const int *k, const double *C);

double C_covPowExpDerivative(const double *X, const int *n,
			     const int *d,
			     const int *i, const int *j,
			     const double *param,
			     const double *scaling_factor,
			     const int *k, const double *C);

void C_covMatrixDerivative(const double *X, const int *n,
			   const int *d,
			   const double *param,
			   const char **type,
			   int *k, double *C, double *ans);

double C_covGaussDerivative_dx(const double *X, const int *n,
			       const int *d,
			       const int *i, const int *j,
			       const double *param,
			       const double *scaling_factor,
			       const int *k, const double *C);

double C_covExpDerivative_dx(const double *X, const int *n,
			     const int *d,
			     const int *i, const int *j,
			     const double *param,
			     const double *scaling_factor,
			     const int *k, const double *C);

double C_covMatern3_2Derivative_dx(const double *X, const int *n,
				   const int *d,
				   const int *i, const int *j,
				   const double *param,
				   const double *scaling_factor,
				   const int *k, const double *C);

double C_covMatern5_2Derivative_dx(const double *X, const int *n,
				   const int *d,
				   const int *i, const int *j,
				   const double *param,
				   const double *scaling_factor,
				   const int *k, const double *C);

double C_covPowExpDerivative_dx(const double *X, const int *n,
				const int *d,
				const int *i, const int *j,
				const double *param,
				const double *scaling_factor,
				const int *k, const double *C);

void C_covMatrixDerivative_dx(const double *X, const int *n,
			      const int *d,
			      const double *param,
			      const char **type,
			      int *k, double *C, double *ans);

double C_covGauss_dx(const double *x, const double *X, const int *n,
		     const int *d,
		     const int *i, const int *k,
		     const double *param,
		     const double *scaling_factor,
		     const double *c);

double C_covExp_dx(const double *x, const double *X, const int *n,
		   const int *d,
		   const int *i, const int *k,
		   const double *param,
		   const double *scaling_factor,
		   const double *c);

double C_covMatern3_2_dx(const double *x, const double *X, const int *n,
			 const int *d,
			 const int *i, const int *k,
			 const double *param,
			 const double *scaling_factor,
			 const double *c);

double C_covMatern5_2_dx(const double *x, const double *X, const int *n,
			 const int *d,
			 const int *i, const int *k,
			 const double *param,
			 const double *scaling_factor,
			 const double *c);

double C_covPowExp_dx(const double *x, const double *X, const int *n,
		      const int *d,
		      const int *i, const int *k,
		      const double *param,
		      const double *scaling_factor,
		      const double *c);

void C_covVector_dx(const double *x, const double *X, const int *n,
		    const int *d,
		    const double *param,
		    const char **type,
		    double *c, double *ans);

void Scale(int *n, int *nKnots,        
           double *x, double *knots,  
           double *eta, double *scale);

void Scale_dx(int *n, int *nKnots,
	      double *x, double *knots,
	      double *eta, double *scale_dx);

void gradScale(int *n, int *nKnots,
	       int *icuts,
	       double *x, double *knots,
	       double *grad);
