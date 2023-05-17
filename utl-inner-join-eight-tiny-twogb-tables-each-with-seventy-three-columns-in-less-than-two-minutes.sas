%let pgm=utl-inner-join-eight-tiny-twogb-tables-each-with-seventy-three-columns-in-less-than-two-minutes;

Inner join eight timy twogb tables each with seventy eight columns in less than two minutes

For tiny datasets like these it probably does not matter what algorithm you use. All should
take less than 10 minutes.

  Paul Dorfmans algorithm should substantially outperform(non tiny) datasets (datsets over about 30gb).

                                         Sort/Index  SQL/MERGE   Time

     1 Parallel Sort*,index and SQL        12sec       20sec     32 seconds
     2 Parallel Sort*,index and MERGE      12sec       70sec     82 seconds
     3 HASH (no need to sort. will scale                         30 seconds
       RUN LAST IT CLOBBERS INPUTS
       (not as useful for this tiny data)
        maga-
        xine  subscribers hash match                             resulting
        ====  ==========                                         pbservations
        10    5,600,000
        11    5,543,984   inner join 5,600,000 with 5,543,984    21,379
        12    5,544,002   inner join 21,379    with 5,544,002    21,171
        13    5,544,227   inner join 21,171    with 5,544,227    20,981
        14    5,544,014   inner join 20,981    with 5,544,014    20,767
        15    5,544,069   inner join 20,767    with 5,544,069    20,540
        16    5,544,128   inner join 20,540    with 5,544,128    20,341
        17    5,544,010   inner join 20,341    with 5,544,010    20,125

     * probably do not need to index and sort;


The hash join below is better suited for tables in the 30+gb range.

Hash join fof eight two db tables each with seventy eight columns in less than a minute columns

This algorithm was first codified by Paul Dorfman (saslhole@gmail.com).

From Paul on the hash solution

Note that the crux of the matter here is using single EID(tecord number) instead of overloading the hash
data portion with a slew of satellite variables and using POINT=RID downstream. Privately,
I call it "data portion disk offloading" (first overtly proposed, IIRC, at SUGI 31 in SF).

As far as the MD5 goes, it works really well when you have a truly long mixed-type composite
key. In this case, with 6 numeric hash variables per hash item, it cuts the hash memory
footprint somewhat, too, but only by 16 bytes per item (80 bytes against 64 under X64_7PRO).
Which is why methinks it may run faster if you simply include the
keys in the key portion and match on them,hereby getting rid of the CATX+MD5 overhead."


github
https://tinyurl.com/ys7drs8n
https://github.com/rogerjdeangelis/utl-inner-join-eight-tiny-twogb-tables-each-with-seventy-three-columns-in-less-than-two-minutes

Related
https://tinyurl.com/y79vrz7f
https://github.com/rogerjdeangelis/utl_benchmarks_hash_merge_of_two_un-sorted_data_sets_with_some_common_variables

https://tinyurl.com/4hts72m9
https://github.com/rogerjdeangelis?tab=repositories&q=parallel&type=&language=&sort=

/*                   _
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
*/

/**************************************************************************************************************************/
/*                                                                                                                        */
/*  INNER JOIN KEY                                                                                                        */
/*                                                                                                                        */
/*  MSA                                                                                                                   */
/*  COUNTYCODE                                                                                                            */
/*  STATE                                                                                                                 */
/*  MEMBER                                                                                                                */
/*                                                                                                                        */
/*                                                                                                                        */
/*  EIGHT TABLES                                                                                                          */
/*                                                                                                                        */
/*                Obs, Entries                                                                                            */
/*   #  Name       or Indexes   Vars   File Size                                                                          */
/*                                                                                                                        */
/*   1  _10       5,600,000      73       2 GB                                                                            */
/*   2  _11       5,543,984      73       2 GB                                                                            */
/*   3  _12       5,544,002      73       2 GB                                                                            */
/*   4  _13       5,544,227      73       2 GB                                                                            */
/*   5  _14       5,544,014      73       2 GB                                                                            */
/*   6  _15       5,544,069      73       2 GB                                                                            */
/*   7  _16       5,544,128      73       2 GB                                                                            */
/*   8  _17       5,544,010      73       2 GB                                                                            */
/*                                                                                                                        */
/*                                                                                                                        */
/*  Middle Observation(2800000 ) of table = f._10 - Total Obs 20157 16MAY2023:18:49:10                                    */
/*                                                                                                                        */
/*   -- CHARACTER --                       Sample                                                                         */
/*  Variable                        Typ    Value                                                                          */
/*                                                                                                                        */
/*  DIMENSION VARIABLES                                                                                                   */
/*                                                                                                                        */
/*  MSA                              C1    D                                                                              */
/*  COUNTYCODE                       C2    16                                                                             */
/*  STATE                            C2    TX                                                                             */
/*  MEMBER                           N8    7000                                                                           */
/*                                                                                                                        */
/*  B1                               C8    12345678                                                                       */
/*  B2                               C8    12345678                                                                       */
/*  B3                               C8    12345678                                                                       */
/*  ....                                                                                                                  */
/*  B38                              C8    12345678                                                                       */
/*  B39                              C8    12345678                                                                       */
/*  B40                              C8    12345678                                                                       */
/*                                                                                                                        */
/*                                                                                                                        */
/*   -- NUMERIC --                                                                                                        */
/*  M1                               N3    12344                                                                          */
/*  M2                               N3    12344                                                                          */
/*  M3                               N3    12344                                                                          */
/*  ....                                                                                                                  */
/*  M26                              N3    12344                                                                          */
/*  M27                              N3    12344                                                                          */
/*  M28                              N3    12344                                                                          */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*___    _                   _     _        _     _
 ( _ )  (_)_ __  _ __  _   _| |_  | |_ __ _| |__ | | ___  ___
 / _ \  | | `_ \| `_ \| | | | __| | __/ _` | `_ \| |/ _ \/ __|
| (_) | | | | | | |_) | |_| | |_  | || (_| | |_) | |  __/\__ \
 \___/  |_|_| |_| .__/ \__,_|\__|  \__\__,_|_.__/|_|\___||___/
                |_|
*/

libname f "f:/wrk";

%macro genEgt(yr);

    data f._1&yr (sgio=yes bufno=100 );

       array as[40] $8 b1-b40 (40*'12345678');
       array ns[28] 3  m1-m28 (28*12345);

       do year='11','12','13','14','15','16','17','18';
          do MSA='A','B','C','D';
             do CountyCode='12','13','14','15','16';
                do State='AK','AL','CA','VT','TX';
                   do _n_=1 to 7000 by 1;
                     %if &yr ^= 0 %then %do;
                       if not (3000 <= _n_ <=3025 + &yr) then member=-&yr;
                       else member=_n_;
                       if uniform(&yr.5431) > .01 then output;
                     %end;
                     %else %do;
                       member=_n_;
                       output;
                     %end;
                   end;
                end;
             end;
          end;
       end;

    run;quit;

%mend genEgt;

%genEgt(0);
%genEgt(1);
%genEgt(2);
%genEgt(3);
%genEgt(4);
%genEgt(5);
%genEgt(6);
%genEgt(7);

/*                     _ _      _                  _
 _ __   __ _ _ __ __ _| | | ___| |  ___  ___  _ __| |_
| `_ \ / _` | `__/ _` | | |/ _ \ | / __|/ _ \| `__| __|
| |_) | (_| | | | (_| | | |  __/ | \__ \ (_) | |  | |_
| .__/ \__,_|_|  \__,_|_|_|\___|_| |___/\___/|_|   \__|
|_|
*/

/*--- create autocall macro ---*/
filename ft15f001 "c:/oto/utl_parSrt.sas";
parmcards4;
%macro utl_parSrt(seq);
   libname f "f:/wrk";
   proc datasets lib=f nodetails nolist;
     delete _1&seq.Srt;
   run;quit;
   proc sort sortsize=9g force
     data=f._1&seq
     out=f._1&seq.Srt(
     index=(dim=(
       year
       msa
       countycode
       state
       member     )));
     by
       year
       msa
       countycode
       state
       member;
   run;quit;
%mend utl_parSrt;
;;;;
run;quit;

/*---- test interactively   ---*/
%utlopts;
%utl_parSrt(0);

%let _s=%sysfunc(compbl(C:\Progra~1\SASHome\SASFoundation\9.4\sas.exe -sysin c:\nul
  -sasautos c:\oto -autoexec c:\oto\Tut_Oto.sas -work m:\wrk));

%let tym=%sysfunc(datetime());
%put &=tym;

systask kill sys0 sys1 sys2 sys3 sys4  sys5  sys6 sys7 ;
systask command "&_s -termstmt %nrstr(%utl_parSrt(0);) -log d:\log\a0.log" taskname=sys0;
systask command "&_s -termstmt %nrstr(%utl_parSrt(1);) -log d:\log\a1.log" taskname=sys1;
systask command "&_s -termstmt %nrstr(%utl_parSrt(2);) -log d:\log\a2.log" taskname=sys2;
systask command "&_s -termstmt %nrstr(%utl_parSrt(3);) -log d:\log\a3.log" taskname=sys3;
systask command "&_s -termstmt %nrstr(%utl_parSrt(4);) -log d:\log\a4.log" taskname=sys4;
systask command "&_s -termstmt %nrstr(%utl_parSrt(5);) -log d:\log\a5.log" taskname=sys5;
systask command "&_s -termstmt %nrstr(%utl_parSrt(6);) -log d:\log\a6.log" taskname=sys6;
systask command "&_s -termstmt %nrstr(%utl_parSrt(7);) -log d:\log\a7.log" taskname=sys7;
waitfor sys0 sys1 sys2 sys3 sys4  sys5 sys6 sys7;

%put Elapsed %sysevalf(%sysfunc(datetime()) - &tym);

/*         _   _                           _       _
 ___  __ _| | (_)_ __  _ __   ___ _ __    (_) ___ (_)_ __
/ __|/ _` | | | | `_ \| `_ \ / _ \ `__|   | |/ _ \| | `_ \
\__ \ (_| | | | | | | | | | |  __/ |      | | (_) | | | | |
|___/\__, |_| |_|_| |_|_| |_|\___|_|     _/ |\___/|_|_| |_|
        |_|                             |__/
*/

/*--- you may want to decide which variables to add from eight input tables ---*/

proc sql;
  create
     table want_sql as
  select
     a.*
    ,b.b1 ,b.m1
    ,c.b2 ,c.m2
    ,d.b3 ,d.m3
    ,e.b4 ,e.m4
    ,f.b5 ,f.m5
    ,g.b6 ,g.m6
    ,h.b7 ,h.m7
  from
     f._10Srt(drop=b1-b7 m1-m7                                      )  as a
     inner join f._11Srt(keep=year msa countycode state member b1 m1)  as b
        on a.year=b.year & a.msa=b.msa & a.countycode=b.countycode & a.state=b.state & a.member=b.member
     inner join f._12Srt(keep=year msa countycode state member b2 m2)  as c
        on a.year=c.year & a.msa=c.msa & a.countycode=c.countycode & a.state=c.state & a.member=c.member
     inner join f._13Srt(keep=year msa countycode state member b3 m3)  as d
        on a.year=d.year & a.msa=d.msa & a.countycode=d.countycode & a.state=d.state & a.member=d.member
     inner join f._14Srt(keep=year msa countycode state member b4 m4)  as e
        on a.year=e.year & a.msa=e.msa & a.countycode=e.countycode & a.state=e.state & a.member=e.member
     inner join f._15Srt(keep=year msa countycode state member b5 m5)  as f
        on a.year=f.year & a.msa=f.msa & a.countycode=f.countycode & a.state=f.state & a.member=f.member
     inner join f._16Srt(keep=year msa countycode state member b6 m6)  as g
        on a.year=g.year & a.msa=g.msa & a.countycode=g.countycode & a.state=g.state & a.member=g.member
     inner join f._17Srt(keep=year msa countycode state member b7 m7)  as h
        on a.year=h.year & a.msa=h.msa & a.countycode=h.countycode & a.state=h.state & a.member=h.member
;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/*  NOTE: Table WORK.WANT_SQL created, with 20125 rows and 73 columns.                                                    */
/*                                                                                                                        */
/*  NOTE: PROCEDURE SQL used (Total process time):                                                                        */
/*        real time           20.34 seconds                                                                               */
/*                                                                                                                        */
/**************************************************************************************************************************/

data wantStp;
  merge
       f._10Srt(drop=b1-b7 m1-m7                             in=_0)
       f._11Srt(keep=year msa countycode state member b1 m1  in=_1)
       f._12Srt(keep=year msa countycode state member b2 m2  in=_2)
       f._13Srt(keep=year msa countycode state member b3 m3  in=_3)
       f._14Srt(keep=year msa countycode state member b4 m4  in=_4)
       f._15Srt(keep=year msa countycode state member b5 m5  in=_5)
       f._16Srt(keep=year msa countycode state member b6 m6  in=_6)
       f._17Srt(keep=year msa countycode state member b7 m7  in=_7)
  ;
  by year msa countycode state member;
  if
     _0 and
     _1 and
     _2 and
     _3 and
     _4 and
     _5 and
     _6 and
     _7  ;
run;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/*  NOTE: There were 5600000 observations read from the data set F._10SRT.                                                */
/*  NOTE: There were 5543984 observations read from the data set F._11SRT.                                                */
/*  NOTE: There were 5544002 observations read from the data set F._12SRT.                                                */
/*  NOTE: There were 5544227 observations read from the data set F._13SRT.                                                */
/*  NOTE: There were 5544014 observations read from the data set F._14SRT.                                                */
/*  NOTE: There were 5544069 observations read from the data set F._15SRT.                                                */
/*  NOTE: There were 5544128 observations read from the data set F._16SRT.                                                */
/*  NOTE: There were 5544010 observations read from the data set F._17SRT.                                                */
/*                                                                                                                        */
/*  NOTE: The data set WORK.WANTSTP has 20125 observations and 73 variables.                                              */
/*                                                                                                                        */
/*  NOTE: DATA statement used (Total process time):                                                                       */
/*        real time           1:12.15                                                                                     */
/*                                                                                                                        */
/**************************************************************************************************************************/


%put %sysevalf(%sysfunc(datetime()) - &tym);

%utlnopts;

/*---- %let year=14; ----*/
libname f "f:/wrk";

%let tym=%sysfunc(datetime());
%put &=tym;

%macro utl_hrecurse(seq);

  %let pre=%eval(&seq - 1);

  data f._1&seq (drop = key)  ;
    dcl hash h(hashexp:20, multidata:"y") ;
    h.definekey ("key") ;
    h.definedata ("rid") ;
    h.definedone() ;
    length key $ 16 ;
    do rid = 1 by 1 until (z1) ;
      set f._1&pre (keep=Year--member
        rename=(
          year       = ryear
          msa        = rmsa
          countycode = rcountycode
          state      = rstate
          member     = rmember
        )) end = z1 ;
      key = md5 (catx (of rYear--rmember)) ;
      h.add() ;
    end ;
    do until (z2) ;
      set f._1&seq end = z2 ;
      key = md5 (catx (of Year--member)) ;
      do _iorc_ = h.find() by 0 while (_iorc_ = 0) ;
        set f._1&pre point = rid ;
        output f._1&seq ;
        _iorc_ = h.find_next() ;
      end ;
    end ;
    stop ;
  run;quit;

  %put %utl_nobs(f._1&seq);

%mend utl_hrecurse;

%utl_hrecurse(1);
%utl_hrecurse(2);
%utl_hrecurse(3);
%utl_hrecurse(4);
%utl_hrecurse(5);
%utl_hrecurse(6);
%utl_hrecurse(7);

%put elapse %sysevalf(%sysfunc(datetime()) - &tym);

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
