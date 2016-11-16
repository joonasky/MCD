all: mtfort90.o main
	gfortran MCD.o mtfort90.o -o MCD
	gfortran MCDM.o mtfort90.o -o MCDM

main: MCD.f90 MCDM.f90
	gfortran -c MCD.f90
	gfortran -c MCDM.f90

mtfort90.o: mtfort90.f90
	gfortran -c mtfort90.f90

clean:
	rm MCD MCDM MCD.o MCDM.o mtmod.mod mtfort90.o
