program MCD
use mtmod
implicit none

  integer,parameter :: rk = selected_real_kind(15,307)
  integer,parameter :: ik = selected_int_kind(38)
  integer,parameter :: right = -1, left = 1, Esize = 10000, &
                       & tmax = 60000, nsamplemax = 100000
  
  integer(kind=ik)  :: Nhalf, t, nsample, Temperature
  integer           :: i, x, x0, dir, ios

  real(kind=rk)     :: J, eps, epsb, xt, dE
  real(kind=rk),dimension(Esize) :: E
  real(kind=rk),dimension(tmax)  :: xt2

  character(len=80) :: fname, arg, message

  call getarg(1,arg)
  read(arg,*) Temperature
  call getarg(2,fname)
  print '(3(a,x),i4)', 'calculating',trim(fname),'with T:',Temperature

  !STEP 0 - Initialize lattice
  
  eps = 1
  epsb = 0.288640
  Nhalf = Esize/2
  
  do i=1,Esize
    E(i) = -eps*(Nhalf-abs((i-1)-Nhalf))
  end do

  !STEP 1
  nsample = 0
  xt2 = 0
  call sgrnd(232140665)

  do nsample = 0,nsamplemax
    
    !STEP 2
    x0 = ceiling(grnd()*Esize) ! 1-Esize
    x = x0

    do t = 0,tmax
      
      !STEP 3
      if (grnd() < 0.5) then
         dir = left
      else
         dir = right
      end if

      !calculate prob for jump
      
      dE = (E(x+dir)-E(x))

      if (dE > 0) then
         J = 0.5*exp(-(dE)/Temperature)
      else 
         J = 1
      end if

      !jump with probability J
      if (J > grnd()) then
        x = x + dir
        if (x < 1) then
           x = Esize
        else if (x > Esize) then
           x = 1
        end if
      end if
      
      !STEP 4
      
      xt2(t) = xt2(t) + (x-x0)**2
      
    end do
    
  end do
  
  print *, '<x(t)^2> : ', xt2(tmax-tmax/6)/nsamplemax

  open(unit=1,file=fname,iostat=ios,iomsg=message,status='replace')
  if (ios/=0) then
     print '(a,a,5x,i0)','*** Error in opening file ',trim(fname),ios
     print '(a,a)','Error message: ',trim(message)
     stop
  end if
 
  write(1,'(f23.13)') xt2/nsamplemax
  
  close(1)

end program
