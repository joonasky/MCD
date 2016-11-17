program theorvals
implicit none

integer,parameter :: rk = selected_real_kind(15,307)
integer,parameter :: ik = selected_int_kind(38)
integer,parameter :: Esize = 100

integer(kind=ik)  :: Nhalf
integer           :: i
  
real(kind=rk)     :: eps,epsb
real(kind=rk),dimension(Esize) :: E

eps = 1
epsb = 0.288640
Nhalf=Esize/2

do i=1,Esize
   E(i) = -eps*(Nhalf-abs((i-1)-Nhalf))
end do

open(unit=1,file='../run/E(i).txt',status='replace')
write(1,'(f23.13)') E
close(1)

print '(a7)','D when '
print '("T = 2 ",f15.10)', vals(2)
print '("T = 5 ",f15.10)', vals(5)
print '("T = 10",f15.10)', vals(10)
print '("T = 20",f15.10)', vals(20)
print '("T = 55",f15.10)', vals(55)
print '("T = 100",f14.10)', vals(100)
print '("T = 300",f14.10)', vals(300)
print '("T = 300 ",f13.10)', vals(650)
print '("T = 300 ",f13.10)', vals(1000)

contains

real(kind=rk) function vals(T) 
 integer,intent(in) :: T
 real(kind=rk)      :: psum
 
 psum=0.0
 do i=1,Esize
    psum = psum + exp((epsb-E(i))/T)
 end do

 vals = 1.0_rk/(2.0_rk/Esize*psum)
end function

end program
