      BLOCK DATA

C     NicheMapR: software for biophysical mechanistic niche modelling

C     Copyright (C) 2018 Michael R. Kearney and Warren P. Porter

c     This program is free software: you can redistribute it and/or modify
c     it under the terms of the GNU General Public License as published by
c     the Free Software Foundation, either version 3 of the License, or (at
c      your option) any later version.

c     This program is distributed in the hope that it will be useful, but
c     WITHOUT ANY WARRANTY; without even the implied warranty of
c     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
c     General Public License for more details.

c     You should have received a copy of the GNU General Public License
c     along with this program. If not, see http://www.gnu.org/licenses/.
C
c     ONLY VARIABLES USED IN A SUBROUTINE ARE DECLARED
C     THIS NON EXECUTABLE BLOCK IS USED TO
C     INITIALIZE ALL DATA FOR THE PROGRAM.  THE DATA ARE OVERWRITTEN
C     IF DATA ARE READ IN BY PROGRAM MAIN.

      IMPLICIT NONE

      DOUBLE PRECISION AMYCRO,C,DEP,OUT,PAR,T,Tannul,TD,TI,WC
      DOUBLE PRECISION PUNSH,ALAT,AMULT,PRESS,CMH2O,REFL,ALONC,TIMCOR
     & ,AZMUTH,SLOPE
      DOUBLE PRECISION TSNHR,TSRHR,HEMIS,TIME,TIMEF,DTAU,ERR1,H

      INTEGER ILOCT,IOUT,ITEST,ND,OPS,IPINT,NOSCAT,IUV,IALT,IDAYST,IDA
      INTEGER IEP,ISTART,IEND,MM,N,NOUT,NDUM,IPRINT,NDUM1

      CHARACTER*3 INAME,SYMBOL

      COMMON/NONSCR/MM,N,TIME,TIMEF,DTAU,ERR1,H,NOUT,NDUM1,IPRINT
      COMMON/ARRAY/T(30),WC(20),C(20),DEP(30),IOUT(100),
     1 OUT(101),ITEST(23)
      COMMON/CARRAY/INAME(20),SYMBOL(23)
      COMMON/TABLE/TI(211),TD(211)
      COMMON/TABLE2/ILOCT(21)
      COMMON/PAR/PAR(18)
      COMMON/DMYCRO/AMYCRO(4)
      COMMON/OPSHUN/OPS(10)
      COMMON/NDAY/ND

      COMMON/DAYS/Tannul
      COMMON/WIOCONS/PUNSH,ALAT,AMULT,PRESS,CMH2O,REFL,ALONC,TIMCOR,
     * AZMUTH,SLOPE,TSNHR,TSRHR,Hemis
      COMMON/WIOCONS2/IPINT,NOSCAT,IUV,IALT,IDAYST,IDA,IEP,ISTART,IEND

C     INITIALIZE ALL ARRAYS AND BLOCKS

      DATA WC/20*0.0/
      DATA C/20*0.0/
      DATA IOUT/100*0/
      DATA OUT/101*0.0/
      DATA ITEST/23*0/

C     DEFAULT DATA VALUES FOR PARAMETERS, ARRAYS AND TABLES

C     SOIL DEPTH DEFAULTS
      DATA  DEP/0.,2.5,5.,10.,15.,20.,40.,50.,100.,200.,20*0./

C     INITIAL TIMES FOR DEFAULT TABLE VALUES
      DATA  TI/0.,1440.,0.,1440.,0.,240.,480.,720.,960.,1200.,1440.,
     10.,300.,480.,600.,720.,840.,960.,1080.,1200.,1440.,
     2 -100.,-10.,0.,10.,
     3 20.,25.,30.,35.,40.,45.,50.,100.,-100.,     25.,30.,35.,40.,
     445.,50.,100.,0.,360.,780.,1200.,1440.,0.,50.,100.,200.,400.,1000.,
     52000.,4000.,10000.,156*0./

C     DEFAULT TIME DEPENDENT VALUES FOR TABLE VALUES
      DATA  TD/25.,25.,9000.,9000.,27.,24.,33.,41.,40.,31.,27.,
     1  0.,0.,.8,1.25,1.5,1.5,1.25,.8,0.,0.,.001,.001,.0027,.0074,.0201,
     2 .0331,.0546,.0901,.1485,.2448,.4036,.4036,.005,.005,.0744,.1228,
     3 .2025,.3338,.5504,.5504,80.,80.,20.,80.,80.,0.,.003618,.005484,
     4  .008312,.01260,.02183,.03309,.05015,.08691,156*0./
      DATA T/30*25./

C     PARAMETER NAMES FOR DATA READ IN
C     'SUN' IS USED IN DSUB TO ACCOUNT FOR VEGETATION INTERCEPTING SOLAR
C      BEFORE IT HITS THE GROUND. 1.0=FULL SUN, 0.0=FULL SHADE
      DATA SYMBOL/'SIG','RCS','STC','SSA','HGT','RUF','BEG','MON','PRT'
     1,'ERR','END','SLE','DAS','NON','SUN','PLT','FIN','STP','TIN','DEP'
     2 ,'IOT','TTL','TAB'/

C     DEFAULT PARAMETER VALUES FOR 'SYMBOLS' ABOVE IN CAL, CM, MIN, C
      DATA PAR/.8126E-10,.5,.05,.7,120.,.268,0.,0.,60.,2.,1440.,1.,0.,
     * 10.,1.,0.,0.,0./

C     TABLE NAMES FOR DATA READ IN (IN PAIRS: TIME,DATA)
      DATA INAME/'DIR','TDS','TAR','REL','CLD','VEL','SOL','ZEN'
     2,'ZSL','IRD',' ',' ',' ',' ',' ',' ',' ',' ' ,' ',' '/
C     INITIAL STARTING PLACES FOR TABLE LOCATIONS IN TIME DEPENDENT
C     TABLE ARRAYS
      DATA  ILOCT/1,10,12,37,62,87,112,137,162,187,212,10*0/

C     HERE ARE THE DATA FOR SUB. MICRO FOR MULTISEGMENT PROFILE
C     THE 1ST 2 DATA IN DMYCRO ARE ZO'S (Z01,Z02)(CM) FROM THE TOP DOWN
C     THE 2ND 2 DATA ARE HEIGHTS (ZH1,ZH2)(CM) FOR THOSE "ZO'S"
C     USER CAN RUN MICRO 3 SEGMENT VELOCITY MODEL AS A 1 OR 2 SEGMENT MODEL
C     SIMPLY BY USING THE SAME ZO AT DIFFERENT HEIGHTS (SEE Sub. MICRO)

C     Dimensions in cm Z01 Z02 ZH1 ZH2  ***************
      DATA AMYCRO/10.,10.,100.,20./

C     SUBR. STEDI OPTIONS: MONLY,NOPRNT,NOTRAN,NOCON,IPCH,ISHADE,NKHT,
C     NPOS,NLIZ,NOSUM
      DATA OPS/1,0,0,0,0,1,1,3,1,0/
C
C     DAY INTERVALS (ND) THAT OUTPUT IS DESIRED (3=EVERY THIRD DAY)
C     THIS APPLIES TO SUBROUTINES OSUB AND PTTABL
      DATA ND/1/

C     SOLRAD INITIALIZATION DATA
      DATA ISTART/1/
      DATA IEND/24/

      END
