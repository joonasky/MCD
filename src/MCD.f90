program MCD
use mtmod
implicit none

  integer,parameter :: rk = selected_real_kind(15,307)
  integer,parameter :: ik = selected_int_kind(38)
  integer,parameter :: right = 1, left = -1, Esize = 100, &
                       tmax = 100000, nsamplemax = 100000
  
  character(len=80)                 :: message, arg, fname,fname2

  integer(kind=ik),dimension(Esize) :: Px
  integer(kind=ik)                  :: Nhalf, t, nsample, Temperature
  integer                           :: i, x, x0, dir, ios, distance, iarg
  
  real(kind=rk)                     :: J, eps, epsb, xt
  real(kind=rk),dimension(Esize)    :: E
  real(kind=rk),dimension(0:tmax)   :: xt2


  iarg=command_argument_count()
  if (iarg<3) then
     call get_command_argument(0,arg)
     write(0,'(a,a,a,/,"             1            2               3")') &
          'usage: ',trim(arg), ' T - filename for x(t)^2 - filename for P(x)'
     stop
  end if
  call getarg(1,arg)
  read(arg,*) Temperature
  call getarg(2,fname)
  call getarg(3,fname2)
  print '(3(a,x),i4)', 'calculating',trim(fname),'with T:',Temperature

  !STEP 0 - Initialize lattice
  
  eps = 1
  epsb = 0.288640
  Nhalf = Esize/2
  
  do i=1,Esize
    E(i) = -eps*(Nhalf-abs((i-1)-Nhalf))
  end do

  !STEP 1
  xt2 = 0
  Px = 0
  call sgrnd(232140665)

  do nsample = 0,nsamplemax
    
    !STEP 2
    x0 = ceiling(grnd()*Esize) ! 1-Esize
    x = x0
    distance = 0

    do t = 0,tmax
      
      !STEP 3
      if (grnd() < 0.5) then
         dir = left
      else
         dir = right
      end if

      !calculate prob for jump
           
      J = 0.5*exp(-(epsb-E(x))/Temperature)
      
      !jump with probability J
      if (J > grnd()) then
        x = x + dir
        distance = distance + dir
        if (x < 1) then
           x = Esize
        else if (x > Esize) then
           x = 1
        end if
        Px(x) = Px(x) + 1
      end if
      
      !STEP 4
      
      xt2(t) = xt2(t) + (distance)**2
      
    end do
    
  end do
  
  print *, 'simulation complete '

  open(unit=1,file=fname,iostat=ios,iomsg=message,status='replace')
  if (ios/=0) then
     print '(a,a,5x,i0)','*** Error in opening file ',trim(fname),ios
     print '(a,a)','Error message: ',trim(message)
     stop
  end if
 
  write(1,*) xt2/nsamplemax
  
  close(1)

  open(unit=1,file=fname2,iostat=ios,iomsg=message,status='replace')
  if (ios/=0) then
     print '(a,a,5x,i0)','*** Error in opening file ',trim(fname2),ios
     print '(a,a)','Error message: ',trim(message)
     stop
  end if
 
  write(1,*) Px
  
  close(1)

end program
