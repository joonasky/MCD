all:
	gfortran -O3 mtfort90.f90 MCD.f90 -o MCD
	gfortran -O3 mtfort90.f90 MCDM.f90 -o MCDM
	gfortran -O3 theorvals.f90 -o tvals

clean:
	rm MCD MCDM tvals mtmod.mod
